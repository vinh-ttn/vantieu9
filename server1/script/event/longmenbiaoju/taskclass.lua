Include("\\script\\event\\longmenbiaoju\\head.lua")
Include("\\script\\misc\\eventsys\\type\\func.lua")

local TaskClass = {}
LongMenBiaoJu.TaskClass = TaskClass

TaskClass.RelayRequest = {}
TaskClass.RequestId = 0
TaskClass.Route = {
	--[1] = {nStartMapId=, nFinishMapId=, nType=1, szStartPosName=, szFinishPosName=}
}
TaskClass.TypeToRoute = {
	
}

TaskClass.tbHighTaskRandom = {{60,7},{30,8},{10,9}}

function TaskClass:New()
	return self
end

function TaskClass:Load()
	local szSetting = "\\settings\\event\\longmenbiaoju\\route.txt"
	if TabFile_Load(szSetting, szSetting) ~= 1 then
		print("Error. Load LongMenBiaoJu Setting File Failed.")
		return
	end
	
	for i = 2, TabFile_GetRowCount(szSetting) do
		local tbData = {}
		tbData.nRouteId = tonumber(TabFile_GetCell(szSetting, i, 1))
		tbData.szStartPosName = TabFile_GetCell(szSetting, i, 2)
		tbData.szFinishPosName = TabFile_GetCell(szSetting, i, 3)
		tbData.nType = tonumber(TabFile_GetCell(szSetting, i, 4))
		tinsert(self.Route, tbData)
		
		self.TypeToRoute[tbData.nType] = self.TypeToRoute[tbData.nType] or {}
		tinsert(self.TypeToRoute[tbData.nType], tbData.nRouteId)
	end
	
	TabFile_UnLoad(szSetting)
end

function TaskClass:GetRemainTime(data)
	local nStartTime = data:GetStartTime()
	local nCurTime = GetCurrentTime()
	return nCurTime - nStartTime
end

function TaskClass:OnBiaoCheTimeout(npc)

end

function TaskClass:OnBiaoCheBroken(npc)
	--ToDo:掉落
	local nX32, nY32, nMapIndex = GetNpcPos(npc.nNpcIndex)
	LongMenBiaoJu:NewBrokenBiaoChe(nMapIndex, nX32, nY32, npc.szOwner, npc:GetCreateTime())
	local szKiller = "None"
	
	if PlayerIndex and PlayerIndex > 0 then
		local nX32, nY32, nMapIndex = GetPos()
		LongMenBiaoJu:NewDropBox(npc.nType, nMapIndex, nX32, nY32, GetName())
		szKiller = GetName()
	end
	
	tbLog:TabFormatLog(GetLocalDate("%H:%M"), GetLocalDate("%d/%m/%Y"), GetServerName(), "LongMenBiaoJu", 
		"BiaoCheBroken", "Owner:"..npc.szOwner, "Killer:"..szKiller, "map:"..SubWorldName(nMapIndex))
end

function TaskClass:OnBiaoCheChangeMap(npc)
	if npc.nType >= LongMenBiaoJu.MIN_NOTIFY_TYPE then
		local _, _, nMapIndex = GetNpcPos(npc.nNpcIndex)
		local szMapName = SubWorldName(nMapIndex) or ""
		local szGlobalNews = format(LongMenBiaoJu.LANG.BIAOCHE_NOTIFY, npc.nType, npc.szOwner, szMapName)
		AddGlobalNews(szGlobalNews)
	end
end

function TaskClass:OnPlayerChangeMapByTrap()
	local tbParam = {}
	tbParam.nType = LongMenBiaoJu:GetDataClass():GetType()
	tbParam.nMapId, tbParam.nX, tbParam.nY = GetWorldPos()
	tbParam.szOwner = GetName()
	
	local npc = LongMenBiaoJu:FindBiaoChe(tbParam.szOwner)
	if npc then
		NpcNewWorld(npc.nNpcIndex, tbParam.nMapId, tbParam.nX, tbParam.nY)
		self:OnBiaoCheChangeMap(npc)
		return
	end
	
	LongMenBiaoJu:RemoteCall("DeleteBiaoCheForTransfer", {tbParam.szOwner},
		self.CreateBiaoCheForTransfer,
		{self, tbParam.szOwner, tbParam.nType, tbParam.nMapId, tbParam.nX, tbParam.nY})
end

function TaskClass:DeleteBiaoCheForTransfer(szOwner)
	local npc = LongMenBiaoJu:FindBiaoChe(szOwner)
	if npc then
		local nCreateTime = npc:GetCreateTime()
		local nCurLife = GetNpcCurLife(npc.nNpcIndex)
		LongMenBiaoJu:RemoveBiaoChe(npc)
		npc:DelNpc()
		return nCurLife, nCreateTime
	end
end

function TaskClass:CreateBiaoCheForTransfer(szOwner, nType, nMapId, nX, nY, nLife, nCreateTime)
	if not (nLife and nCreateTime) then
		return
	end
	local npc = LongMenBiaoJu:FindBiaoChe(szOwner)
	if npc then
		return
	end
	npc = LongMenBiaoJu:NewBiaoChe(nType, nMapId, nX, nY, szOwner)
	if npc then
		SetNpcCurLife(npc.nNpcIndex, nLife)
		npc:SetCreateTime(nCreateTime)
		self:OnBiaoCheChangeMap(npc)
	else
		LongMenBiaoJu:WriteLog("CreateBiaoCheFailed", szOwner, nType, nMapId, nX, nY, nLife, nCreateTime)
	end
end

function TaskClass:CheckAwardType()
	local lang = LongMenBiaoJu.LANG
	
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()
	if nType == 0 then
		Talk(1, "", lang.MSG_FINISH_NO_TASK)
		return
	end
	local nStartTime = data:GetStartTime()
	if nStartTime == 0 then
		Talk(1, "", lang.MSG_FINISH_NOT_START)
		return
	end
	
	local nRouteId, nInvert = data:GetRoute()
	local _, szFinishPos = self:GetRouteInfo(nRouteId, nInvert)
	local tbNpcPos = LongMenBiaoJu.BiaoShiPos[szFinishPos]
	if not tbNpcPos then
		return
	end
	
	local tbItemProp = LongMenBiaoJu.ItemList.BiaoQi.tbProp
	local nItemCount = CalcItemCount(-1, tbItemProp[1], tbItemProp[2], tbItemProp[3], tbItemProp[4])
	
	local biaoche = LongMenBiaoJu:FindBiaoChe(GetName())
	if biaoche then
		local nX32, nY32, nMapIndex = GetNpcPos(biaoche.nNpcIndex)
		local nOwnerX32, nOwnerY32, nOwnerMapIndex = GetPos()
		if ((nX32-nOwnerX32)^2 + (nY32-nOwnerY32)^2 > LongMenBiaoJu.FINISH_DISTANCE) or nMapIndex~= nOwnerMapIndex then
			return 1
		end
	else
		if nItemCount > 0 then
			return 2
		end
		return 1
	end
	
	local nNpcIndex = GetLastDiagNpc()
	local nNpcSettingId = GetNpcSettingIdx(nNpcIndex)
	local nBiaoShiIndex = GetNpcParam(nNpcIndex, LongMenBiaoJu.BIAOSHI_PARAM_INDEX)
	if nBiaoShiIndex ~= tbNpcPos[4] or nNpcSettingId ~= LongMenBiaoJu.NpcList.BiaoShi.nNpcId then
		Talk(1, "", lang.MSG_FINISH_WRONG_NPC)
		return
	end
	
	return 3
end

function TaskClass:CheckStart(nNpcIndex)
	local lang = LongMenBiaoJu.LANG
	local nCurTime = tonumber(GetLocalDate("%H%M"))
	local StartTime = LongMenBiaoJu.StartTime
	local EndTime = LongMenBiaoJu.EndTime
	if nCurTime < StartTime[1]*100 + StartTime[2] or ( nCurTime >= EndTime[1]*100 + EndTime[2]) then
		Talk(1, "", lang.MSG_NOT_OPEN)
		return
	end
	
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()
	if nType == 0 then
		Talk(1, "", lang.MSG_NO_TASK)
		return
	end
	
	local nStartTime = data:GetStartTime()
	if nStartTime ~= 0 then
		Talk(1, "", lang.MSG_START_ALREADY_START)
		return
	end
	
	local nRouteId, nInvert = data:GetRoute()
	local szStartPos = self:GetRouteInfo(nRouteId, nInvert)
	local tbNpcPos = LongMenBiaoJu.BiaoShiPos[szStartPos]
	if not tbNpcPos then
		return
	end
	
	local nNpcSettingId = GetNpcSettingIdx(nNpcIndex)
	local nBiaoShiIndex = GetNpcParam(nNpcIndex, LongMenBiaoJu.BIAOSHI_PARAM_INDEX)
	if nBiaoShiIndex ~= tbNpcPos[4] or nNpcSettingId ~= LongMenBiaoJu.NpcList.BiaoShi.nNpcId then
		Talk(1, "", lang.MSG_START_WRONG_NPC)
		return
	end
	
	return 1
end


function TaskClass:CheckAcceptTask()
	local lang = LongMenBiaoJu.LANG
	local nCurTime = tonumber(GetLocalDate("%H%M"))
	local StartTime = LongMenBiaoJu.StartTime
	local EndTime = LongMenBiaoJu.EndTime
	if nCurTime < StartTime[1]*100 + StartTime[2] or ( nCurTime >= EndTime[1]*100 + EndTime[2]) then
		Talk(1, "", lang.MSG_NOT_OPEN)
		return
	end
	
	local data = LongMenBiaoJu:GetDataClass()
	if data:GetType() ~= 0 then
		local tbItemProp = LongMenBiaoJu.ItemList.BiaoQi.tbProp
		if CalcEquiproomItemCount(tbItemProp[1], tbItemProp[2], tbItemProp[3], tbItemProp[4]) > 0 then
			Talk(1, "",lang.MSG_NEED_FINISH)
			return
		end
		
		Talk(1, "", lang.MSG_ALREADY_ACCEPT)
		return
	end
	
	local bHasTongTask = self:CheckHasTongTask()
	if bHasTongTask == 1 then
		Talk(1, "", lang.MSG_ALREADY_ACCEPT_TONG_TASK)
		return
	end
	
	return 1
end

function TaskClass:CheckHasTongTask()
	local TSK_LMBJTaskFlag        = 4179 -- 任务ID*10 + Flag (Flag:起点终点是否交换)
	local TSK_LMBJTaskTime        = 4180 -- 接镖时间戳
	local nTaskValue = GetTask(TSK_LMBJTaskFlag);
	if (nTaskValue ~= 0) then
		local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
		if nPassTime < 1800 then
			return 1;
		end
	end
	return 0;
end

function TaskClass:GenerateBaseTask()
	return 1, random(0, 1)
end

function TaskClass:GetRouteInfo(nRouteId, nInvert)
	local tbRoute = self.Route[nRouteId]
	if not tbRoute then
		print("Error, TaskClass:GetRouteInfo, tbRoute is nil")
		return "", "", 0
	end
	if nInvert == 0 then
		return tbRoute.szStartPosName, tbRoute.szFinishPosName, tbRoute.nType
	end
	return tbRoute.szFinishPosName, tbRoute.szStartPosName, tbRoute.nType
end

function TaskClass:AcceptTask(nRouteId, nInvert)
	local data = LongMenBiaoJu:GetDataClass()
	data:SetType(self.Route[nRouteId].nType)
	data:SetRoute(nRouteId, nInvert)
	tbLog:PlayerActionLog("LongMenBiaoJu", "AcceptTask", self.Route[nRouteId].nType, nRouteId)
	return 1
end

function TaskClass:GenerateRandomTask()
	local handle = OB_Create()
	ObjBuffer:PushObject(handle, GetName())
	RemoteExecute(LongMenBiaoJu.szRelayFile, "LongMenBiaoJu:GenerateTask", handle, "LongMenBiaoJu:CallBack_GenerateTask", 0)
	OB_Release(handle)
end

function TaskClass:RefreshRandomTaskFree()
	PlayerFunLib:AddTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_REFRESH_COUNT, 1)
	self:GenerateRandomTask()
end

function TaskClass:RefreshRandomTaskCharge(nRouteId, nInvert)
	local tbItemProp = LongMenBiaoJu.ItemList.PingZheng.tbProp
	if ConsumeEquiproomItem(1, tbItemProp[1], tbItemProp[2], tbItemProp[3], tbItemProp[4]) ~= 1 then
		local dlg = LongMenBiaoJu:GetDlgClass()
		dlg:RefreshTaskCharge_NoItem(nRouteId, nInvert)
		return
	end
	
	self:GenerateRandomTask()
	tbLog:PlayerActionLog("LongMenBiaoJu", "RefreshTaskCharge")
end

function TaskClass:AcceptLowTask(nRouteId, nInvert)
	if PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_COUNT) >= LongMenBiaoJu.MAX_TASK_COUNT then
		Talk(1, "", LongMenBiaoJu.LANG.MSG_MAX_COUNT_DAILY)
		return
	end
	
	if self:CheckAcceptTask() == 1 then
		local data = LongMenBiaoJu:GetDataClass()
		data:SetTempRouteLow(0, 0)
		self:AcceptTask(nRouteId, nInvert)
		PlayerFunLib:AddTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_COUNT, 1)
		self:TransferPlayerToStartNpc(nRouteId, nInvert)
	end
end

function TaskClass:AcceptRandomTask(nRouteId, nInvert)
	if not self:GetRouteInfo(nRouteId, nInvert) then
		return
	end
	
	if PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_COUNT) >= LongMenBiaoJu.MAX_TASK_COUNT then
		Talk(1, "", lang.MSG_MAX_COUNT_DAILY)
		return
	end
	
	local data = LongMenBiaoJu:GetDataClass()
	data:SetTempRouteRandom(0, 0)
	PlayerFunLib:AddTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_COUNT, 1)
	self:AcceptTask(nRouteId, nInvert)
	self:TransferPlayerToStartNpc(nRouteId, nInvert)
end

function TaskClass:AcceptHighTask()
	
	if self:CheckAcceptTask() ~= 1 then
		return
	end
	
	local tbItemProp = LongMenBiaoJu.ItemList.WeiRenZhuang.tbProp
	if ConsumeEquiproomItem(1, tbItemProp[1], tbItemProp[2], tbItemProp[3], tbItemProp[4]) ~= 1 then
		Talk(1, "", LongMenBiaoJu.LANG.MSG_NO_ITEM_WRZ)
		return
	end
	
	local tbRand = self.tbHighTaskRandom
	local nRand = random(1, 100)
	local nCurPos = 0
	local nType = 0
	for i = 1, getn(tbRand) do
		local tb = tbRand[i]
		if nCurPos < nRand and nRand <= nCurPos + tb[1] then
			nType = tb[2]
			break
		end
		nCurPos = nCurPos + tb[1]
	end
	
	local routes = self.TypeToRoute[nType]
	if not routes then
		return
	end
	
	local nRandRoute = random(1, getn(routes))
	local nRouteId = routes[nRandRoute]
	local nInvert = random(0, 1)
	
	self:AcceptTask(nRouteId, nInvert)
	Msg2Player(LongMenBiaoJu.LANG.MSG_HIGH_TASK_ACCEPTED)
	self:TransferPlayerToStartNpc(nRouteId, nInvert)
		
	tbLog:PlayerActionLog("LongMenBiaoJu", "AcceptHighLevelTask", nType, nRouteId)
end

function TaskClass:TransferPlayerToStartNpc(nRouteId, nInvert)
	local szStartPosName = self:GetRouteInfo(nRouteId, nInvert)
	local tbPos = LongMenBiaoJu.BiaoShiPos[szStartPosName]
	if tbPos then
		NewWorld(tbPos[1], tbPos[2], tbPos[3])
	end
end

function TaskClass:CheckCancelTask()
	local lang = LongMenBiaoJu.LANG
	local nCurTime = tonumber(GetLocalDate("%H%M"))
	local StartTime = LongMenBiaoJu.StartTime
	local EndTime = LongMenBiaoJu.EndTime
	if nCurTime < StartTime[1]*100 + StartTime[2] or ( nCurTime >= EndTime[1]*100 + EndTime[2]) then
		Talk(1, "", lang.MSG_NOT_OPEN)
		return
	end
	
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()
	if nType == 0 then
		Talk(1, "", lang.MSG_NO_TASK)
		return
	end
	
	local nStartTime = data:GetStartTime()
	if nStartTime ~= 0 then
		Talk(1, "", lang.MSG_CANCEL_ALREADY_START)
		return
	end
	
	if nType >= 7 then
		Talk(1, "", lang.MSG_CANCEL_HIGH_TASK)
		return
	end
	
	return 1
end


function TaskClass:CancelTask()
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()
	data:ClearAll()
	tbLog:PlayerActionLog("LongMenBiaoJu", "CancelTask", nType)
end


function TaskClass:TransferToBiaoChe(tbData)
	local lang = LongMenBiaoJu.LANG
	
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()
	if nType == 0 then
		Talk(1, "", lang.MSG_NO_TASK)
		return
	end
	
	local nStartTime = data:GetStartTime()
	if nStartTime == 0 then
		Talk(1, "", lang.MSG_NO_START)
		return
	end
	
	if GetCash() < LongMenBiaoJu.TRANSFER_COST then
		Talk(1, "", lang.MSG_NO_MONEY)
		return
	end
	
	if not (tbData.nMapId and tbData.nX32 and tbData.nY32) then
		Talk(1, "", lang.MSG_NO_BIAOCHE)
		return
	end
	
	local nCurTime = GetCurServerTime()
	if nCurTime - GetTask(LongMenBiaoJu.TASK_ID.TRANSFER_TIME) < LongMenBiaoJu.TRANSFER_CD then
		Talk(1, "", lang.MSG_TRANSFER_CD)
		return
	end
	
	Pay(LongMenBiaoJu.TRANSFER_COST)
	SetTask(LongMenBiaoJu.TASK_ID.TRANSFER_TIME, nCurTime)
	local nMapId = GetWorldPos()
	SetFightState(tbData.nState)
	if nMapId == tbData.nMapId then
		SetPos(tbData.nX32/32, tbData.nY32/32)
	else
		NewWorld(tbData.nMapId, tbData.nX32/32, tbData.nY32/32)
	end
end

function TaskClass:FinishTask_TaskFailed()
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()

	local tbBaseAwardParam = LongMenBiaoJu.tbAwardBaseParam[nType]
	if tbBaseAwardParam then
		local nExpFactor, nCurrencyFactor, nExpBiaoCheFactor, nCurrencyBiaoCheFactor = unpack(tbBaseAwardParam)
		local nExpAwardValue = LongMenBiaoJu:GetExpAwardValue(nExpFactor, nExpBiaoCheFactor)
		local nCurrencyValue = LongMenBiaoJu:GetCurrencyAwardValue(nCurrencyFactor, nCurrencyBiaoCheFactor)
		local nIsAwardRise = LongMenBiaoJu:CanGetAwardRise()
		if nIsAwardRise == 1 then
			nExpAwardValue = nExpAwardValue * LongMenBiaoJu.tbAwardRiseFactor
			nCurrencyValue = nCurrencyValue * LongMenBiaoJu.tbAwardRiseFactor
		end
		local tbBaseAward  = 
		{
			{nExp=nExpAwardValue},
		}
		tbAwardTemplet:Give(tbBaseAward, 1, LongMenBiaoJu.tbLogTittle)
		Earn(nCurrencyValue)
	end
	
	data:ClearAll()
	tbAwardTemplet:Give({nExp=LongMenBiaoJu.FAILED_EXP}, 1, {"LongMenBiaoJu", "LowLevelAward"})
	tbLog:PlayerActionLog("LongMenBiaoJu", "FinishTask", "FailedNoBiaoQi")
	return 1
end

function TaskClass:FinishTask_TaskSuccess()
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()

	local tbAwardData = LongMenBiaoJu.BoxAwardData[nType]
	if not tbAwardData then
		return
	end

	local tbInfo = tbAwardData.tbHighLevel
	if PlayerFunLib:CheckFreeBagCell(tbInfo.nFreeBag + 2, "default") ~= 1 then
		return
	end
	
	local biaoche = LongMenBiaoJu:FindBiaoChe(GetName())
	if biaoche then
		biaoche:OnTaskFinish()
	end
	
	if LongMenBiaoJu:IsInAwardRiseTime() == 0 then
		SetBitTask(LongMenBiaoJu.TSK_IS_IN_AWARDRISE_TIME, 3, 1, 0)
	end
	
	local tbBaseAwardParam = LongMenBiaoJu.tbAwardBaseParam[nType]
	if tbBaseAwardParam then
		local nExpFactor, nCurrencyFactor, nExpBiaoCheFactor, nCurrencyBiaoCheFactor = unpack(tbBaseAwardParam)
		local nExpAwardValue = LongMenBiaoJu:GetExpAwardValueSuccess(nExpFactor, nExpBiaoCheFactor)
		local nCurrencyValue = LongMenBiaoJu:GetCurrencyAwardValueSuccess(nCurrencyFactor, nCurrencyBiaoCheFactor)
		local nIsAwardRise = LongMenBiaoJu:CanGetAwardRise()
		if nIsAwardRise == 1 then
			nExpAwardValue = nExpAwardValue * LongMenBiaoJu.tbAwardRiseFactor
			nCurrencyValue = nCurrencyValue * LongMenBiaoJu.tbAwardRiseFactor
		end
		local tbBaseAward  = 
		{
			{nExp=nExpAwardValue},
		}
		tbAwardTemplet:Give(tbBaseAward, 1, LongMenBiaoJu.tbLogTittle)
		Earn(nCurrencyValue)
	end
	
	PlayerFunLib:AddTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_SUCCESS_COUNT, 1)
	local nCurTaskCount = PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_SUCCESS_COUNT)
	if nCurTaskCount == LongMenBiaoJu.nExtraAwardCondition then
		tbAwardTemplet:Give(LongMenBiaoJu.tbExtraAward, 1, {"LongMenBiaoJu", "ExtraAward"})
		local szString = LongMenBiaoJu.LANG.MSG_EXTRA_AWARD
		Msg2Player(szString)
	end
	
	DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", "longmenbiaoju")
	
	%EventSys:GetType("LongMenExpress"):OnPlayerEvent("OnFinish", PlayerIndex, nType)
	data:ClearAll()
	tbAwardTemplet:Give(tbAwardData.tbAward, tbInfo.nCount, {"LongMenBiaoJu", "HighLevelAward"})
	tbAwardTemplet:Give(LongMenBiaoJu.ItemList.HuBiaoLing, 2, {"LongMenBiaoJu", "GiveHuBiaoLing"})
	tbLog:PlayerActionLog("LongMenBiaoJu", "FinishTask", "Successfully")
	return 1
end

function TaskClass:FinishTask_WithBiaoQi()
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()

	local tbAwardData = LongMenBiaoJu.BoxAwardData[nType]
	if not tbAwardData then
		return
	end

	local tbInfo = tbAwardData.tbLowLevel
	if PlayerFunLib:CheckFreeBagCell(tbInfo.nFreeBag, "default") ~= 1 then
		return
	end

	local tbItemProp = LongMenBiaoJu.ItemList.BiaoQi.tbProp
	if ConsumeItem(-1, 1, tbItemProp[1], tbItemProp[2], tbItemProp[3], tbItemProp[4]) ~= 1 then
		return
	end
	
	local biaoche = LongMenBiaoJu:FindBiaoChe(GetName())
	if biaoche then
		biaoche:OnTaskFinish()
	end
	
	local tbBaseAwardParam = LongMenBiaoJu.tbAwardBaseParam[nType]
	if tbBaseAwardParam then
		local nExpFactor, nCurrencyFactor, nExpBiaoCheFactor, nCurrencyBiaoCheFactor = unpack(tbBaseAwardParam)
		local nExpAwardValue = LongMenBiaoJu:GetExpAwardValue(nExpFactor, nExpBiaoCheFactor)
		local nCurrencyValue = LongMenBiaoJu:GetCurrencyAwardValue(nCurrencyFactor, nCurrencyBiaoCheFactor)
		local nIsAwardRise = LongMenBiaoJu:CanGetAwardRise()
		if nIsAwardRise == 1 then
			nExpAwardValue = nExpAwardValue * LongMenBiaoJu.tbAwardRiseFactor
			nCurrencyValue = nCurrencyValue * LongMenBiaoJu.tbAwardRiseFactor
		end
		local tbBaseAward  = 
		{
			{nExp=nExpAwardValue},
		}
		tbAwardTemplet:Give(tbBaseAward, 1, LongMenBiaoJu.tbLogTittle)
		Earn(nCurrencyValue)
	end
	
	DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", "longmenbiaoju")
	data:ClearAll()
	tbAwardTemplet:Give(tbAwardData.tbAward, tbInfo.nCount, {"LongMenBiaoJu", "MediumLevelAward"})
	tbLog:PlayerActionLog("LongMenBiaoJu", "FinishTask", "FailedWithBiaoQI")
	return 1
end

function TaskClass:Start()
	local szName = GetName()
	local data = LongMenBiaoJu:GetDataClass()
	
	local nRouteId, nInvert = data:GetRoute()
	local szStartPos,_,nType = self:GetRouteInfo(nRouteId, nInvert)
	local tbNpcPos = LongMenBiaoJu.BiaoShiPos[szStartPos]
	if not tbNpcPos then
		return
	end

	local npc = LongMenBiaoJu:NewBiaoChe(nType, tbNpcPos[1], tbNpcPos[2], tbNpcPos[3], szName)
	if not npc then
		return
	end
	
	local nCurSvrTime = GetCurServerTime()
	data:SetStartTime(nCurSvrTime)
	npc:SetCreateTime(nCurSvrTime)
	
	
end

function TaskClass:QueryBiaoChe(nParam)
	local handle = OB_Create()
	ObjBuffer:PushObject(handle, GetName())
	RemoteExecute(LongMenBiaoJu.szRelayFile, "LongMenBiaoJu:QueryBiaoChe", handle, "LongMenBiaoJu:CallBack_QueryBiaoChe", nParam)
	OB_Release(handle)
end

TaskClass:Load()
LongMenBiaoJu.TaskClass = TaskClass

function LongMenBiaoJu:CallBack_GenerateTask(nParam, HResult)
	if OB_IsEmpty(HResult) == 1 then
		return
	end
	
	local szPlayer = ObjBuffer:PopObject(HResult)
	local nRouteId = ObjBuffer:PopObject(HResult)
	local nInvert = ObjBuffer:PopObject(HResult)
	
	local nPlayerIndex = SearchPlayer(szPlayer)
	if nPlayerIndex <= 0 then
		return
	end
	
	local dlg = LongMenBiaoJu:GetDlgClass()
	local data = LongMenBiaoJu:GetDataClass()
	
	data:SetTempRouteRandom(nRouteId, nInvert)
	CallPlayerFunction(nPlayerIndex, dlg.ShowRandomTaskResult, dlg, nRouteId, nInvert)
end
