Include("\\script\\event\\longmenbiaoju\\taskclass.lua")
Include("\\script\\event\\longmenbiaoju\\lang.lua")
Include("\\script\\activitysys\\g_activity.lua")
Include("\\script\\misc\\eventsys\\eventsys.lua")

local DlgClass = {}
LongMenBiaoJu.DlgClass = DlgClass

function DlgClass:OnNpcDialog(nNpcIndex)
	if PlayerFunLib:CheckTotalLevel(120, "", ">=") ~= 1 then
		CreateNewSayEx(LongMenBiaoJu.LANG.DLG_TOO_YONG, {{LongMenBiaoJu.LANG.DLG_CLOSE}})
		return
	end

	if GetCamp() == 0 then
		CreateNewSayEx(LongMenBiaoJu.LANG.DLG_CAMP_ERROR, {{LongMenBiaoJu.LANG.DLG_CLOSE}})
		return
	end
	
	local nNpcSettingId = GetNpcSettingIdx(nNpcIndex)
	if nNpcSettingId == LongMenBiaoJu.NpcList.BiaoShi.nNpcId then
		CreateNewSayEx(LongMenBiaoJu.LANG.DLG_MAIN_CONTENT, self.DlgOpt.BiaoShi)
	elseif nNpcSettingId == LongMenBiaoJu.NpcList.ZhangGui.nNpcId then
		CreateNewSayEx(LongMenBiaoJu.LANG.DLG_MAIN_CONTENT, self.DlgOpt.ZhangGui)
	end
	
end

function DlgClass:OnSelAcceptTask()
	local task = LongMenBiaoJu:GetTaskClass()
	if task:CheckAcceptTask() == 1 then
		CreateNewSayEx(LongMenBiaoJu.LANG.DLG_ACCEPT_CONTENT, self.DlgOpt.SelectTaskType)
		if LongMenBiaoJu:IsInAwardRiseTime() == 1 then
			LongMenBiaoJu:ResetRecordIsAwardRiseTime()
			SetBitTask(LongMenBiaoJu.TSK_IS_IN_AWARDRISE_TIME, 1, 1, 1)
		end
	end
end

function DlgClass:OnSelStartTask()
	local task = LongMenBiaoJu:GetTaskClass()
	local nNpcIndex = GetLastDiagNpc()
	if task:CheckStart(nNpcIndex) == 1 then
		task:Start()
		if LongMenBiaoJu:IsInAwardRiseTime() == 1 then
			SetBitTask(LongMenBiaoJu.TSK_IS_IN_AWARDRISE_TIME, 2, 1, 1)
		end
	end
end

function DlgClass:OnSelCancelTask()
	local task = LongMenBiaoJu:GetTaskClass()
	if task:CheckCancelTask() == 1 then
		CreateNewSayEx(LongMenBiaoJu.LANG.DLG_CANCEL_CONFIRM, self.DlgOpt.ConfirmCancel)
	end
end

function DlgClass:OnSelConfirmCancel()
	local task = LongMenBiaoJu:GetTaskClass()
	if task:CheckCancelTask() == 1 then
		task:CancelTask()
	end
end

function DlgClass:OnSelFinishTask()
	local task = LongMenBiaoJu:GetTaskClass()
	local nAwardType = task:CheckAwardType()
	if not nAwardType then
		return
	end
	
	local lang = LongMenBiaoJu.LANG
	if nAwardType == 1 then
		local tbOpt = {
			{lang.DLG_GET_AWARD_QUERY, task.QueryBiaoChe, {task, 2}},
			{lang.DLG_CLOSE_2},
		}
		CreateNewSayEx(lang.DLG_GET_AWARD_NOT_FINISH_CONTENT, tbOpt)
	elseif nAwardType == 2 then
		if task:FinishTask_WithBiaoQi() == 1 then
			CreateNewSayEx(lang.DLG_FINISH_TASK_BIAOQI, {{lang.DLG_CLOSE}})
		end
	elseif nAwardType == 3 then
		if LongMenBiaoJu:IsInAwardRiseTime() == 1 then
			SetBitTask(LongMenBiaoJu.TSK_IS_IN_AWARDRISE_TIME, 3, 1, 1)
		end
		
		if task:FinishTask_TaskSuccess() == 1 then
			CreateNewSayEx(lang.DLG_FINISH_TASK_OK, {{lang.DLG_CLOSE}})
			G_ACTIVITY:OnMessage("FinishLongMenBiaoju", PlayerIndex)
		end
	end
end

function DlgClass:ShowFinishTaskResult(tbData)
	local task = LongMenBiaoJu:GetTaskClass()
	local nAwardType = task:CheckAwardType()
	if not nAwardType then
		return
	end

	local lang = LongMenBiaoJu.LANG
	local tbOpt = {}
	local szContent
	if tbData.szOwner == GetName() and tbData.nLife > 0 then
		szContent = lang.DLG_FINISH_TASK_BIAOCHE_EXIST
		tinsert(tbOpt, {lang.DLG_CLOSE})
	else
		local task = LongMenBiaoJu:GetTaskClass()
		szContent = lang.DLG_FINISH_TASK_FAILED
		tinsert(tbOpt, {lang.DLG_CONFIRM, task.FinishTask_TaskFailed, {task}})
		tinsert(tbOpt, {lang.DLG_CLOSE})
	end
	CreateNewSayEx(szContent, tbOpt)
end


function DlgClass:OnSelViewTaskInfo()
	local szName = GetName()
	local data = LongMenBiaoJu:GetDataClass()
	if data:GetType() == 0 then
		self:ShowTaskInfo(LongMenBiaoJu.LANG.MSG_NO_TASK)
		return
	end
	LongMenBiaoJu:GetTaskClass():QueryBiaoChe(0)
end

function DlgClass:ShowTaskInfo(str1)
	local lang = LongMenBiaoJu.LANG
	local nCurTaskCount = PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_COUNT)
	local nCurRefreshCount = PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_REFRESH_COUNT)
	local str2 = format(lang.MSG_TASK_COUNT, nCurTaskCount, LongMenBiaoJu.MAX_TASK_COUNT)
	local str3 = format(lang.MSG_REFRESH_COUNT_FREE, nCurRefreshCount, LongMenBiaoJu.MAX_REFRESH_COUNT)
	str = format("%s\n%s\n%s", str1, str2, str3)
	CreateNewSayEx(str, {{lang.DLG_CLOSE}})
end

function DlgClass:ViewTaskInfo(tbData)
	local task = LongMenBiaoJu:GetTaskClass()
	local data = LongMenBiaoJu:GetDataClass()
	local nType = data:GetType()
	if nType == 0 then
		self:ShowTaskInfo(lang.MSG_NO_TASK)
		return
	end
	
	local lang = LongMenBiaoJu.LANG
	local nStartTime = data:GetStartTime()
	local nRemainTime = LongMenBiaoJu.TASK_TIME - (GetCurServerTime() - nStartTime)
	local nRouteId, nInvert = data:GetRoute()
	local szStartPos, szFinishPos, nType = task:GetRouteInfo(nRouteId, nInvert)
	local str1 = format(lang.MSG_ROUTE_INFO, nType, szStartPos, szFinishPos)
	local str2
	if nStartTime == 0 then
		str2 = lang.MSG_NO_START
	elseif tbData.szOwner ~= GetName() then
		str2 = format(lang.MSG_TASK_STATE_BROKEN)
	elseif nRemainTime > 0 then
		str2 = format(lang.MSG_TASK_TIME_REMAIN, floor(nRemainTime/60), mod(nRemainTime, 60))
	else
		str2 = lang.MSG_TASK_FAILED
	end
	
	self:ShowTaskInfo(format("%s\n%s",str1, str2))
end

function DlgClass:OnSelTransferToBiaoChe()
	LongMenBiaoJu:GetTaskClass():QueryBiaoChe(1)
end

function DlgClass:OnSelSelectTypeLow()
	if PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_COUNT) >= LongMenBiaoJu.MAX_TASK_COUNT then
		Talk(1, "", LongMenBiaoJu.LANG.MSG_MAX_COUNT_DAILY)
		return
	end
	
	local task = LongMenBiaoJu:GetTaskClass()
	local data = LongMenBiaoJu:GetDataClass()
	local nRouteId, nInvert = data:GetTempRouteLow()
	if nRouteId == 0 then
		nRouteId, nInvert = task:GenerateBaseTask()
		data:SetTempRouteLow(nRouteId, nInvert)
	end
	local szStartMap, szFinishMap, nType = task:GetRouteInfo(nRouteId, nInvert)
	local szContent = format(LongMenBiaoJu.LANG.DLG_CONFIRM_TASK_CONTENT, nType, szStartMap, szFinishMap, LongMenBiaoJu.TASK_TIME/60)
	local lang = LongMenBiaoJu.LANG
	local tbOpt = {
		{lang.DLG_CONFIRM, task.AcceptLowTask, {task, nRouteId, nInvert}},
		{lang.DLG_CANCEL},
	}
	CreateNewSayEx(szContent, tbOpt)
end

function DlgClass:OnSelSelectTypeRandom() --这个有跟RELAY通信的异步过程，注定是蛋疼, 最后才写吧
	if PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_FINISH_COUNT) >= LongMenBiaoJu.MAX_TASK_COUNT then
		Talk(1, "", LongMenBiaoJu.LANG.MSG_MAX_COUNT_DAILY)
		return
	end
	
	local task = LongMenBiaoJu:GetTaskClass()
	local lang = LongMenBiaoJu.LANG
	local data = LongMenBiaoJu:GetDataClass()
	if task:CheckAcceptTask() ~= 1 then
		return
	end
	local nRouteId, nInvert = data:GetTempRouteRandom()
	if nRouteId == 0 then
		task:GenerateRandomTask()
		return
	end
	self:ShowRandomTaskResult(nRouteId, nInvert)
end

function DlgClass:OnSelRefreshTaskFree(nRouteId, nInvert)
	local lang = LongMenBiaoJu.LANG
	local nRefreshCount = PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_REFRESH_COUNT)
	local szContent = lang.DLG_FREE_REFRESH_END
	local tbOpt = {}
	if nRefreshCount < LongMenBiaoJu.MAX_REFRESH_COUNT then
		szContent =  lang.MSG_REFRESH_COMFIRM
		local task = LongMenBiaoJu:GetTaskClass()
		tinsert(tbOpt, {lang.DLG_CONFIRM, task.RefreshRandomTaskFree, {task}})
	end
	tinsert(tbOpt, {lang.DLG_BACK, self.ShowRandomTaskResult, {self, nRouteId, nInvert}})
	CreateNewSayEx(szContent, tbOpt)
end

function DlgClass:OnSelRefreshTaskCharge(nRouteId, nInvert)
	local lang = LongMenBiaoJu.LANG
	local nRefreshCount = PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOCHE_REFRESH_COUNT)
	local szContent = lang.DLG_FREE_REFRESH_AVAILABLE
	local tbOpt = {}
	if nRefreshCount >= LongMenBiaoJu.MAX_REFRESH_COUNT then
		szContent = lang.DLG_REFRESH_USING_ITEM_CONFIRM
		local task = LongMenBiaoJu:GetTaskClass()
		tinsert(tbOpt, {lang.DLG_CONFIRM, task.RefreshRandomTaskCharge, {task, nRouteId, nInvert}})
	end
	tinsert(tbOpt, {lang.DLG_BACK, self.ShowRandomTaskResult, {self, nRouteId, nInvert}})
	CreateNewSayEx(szContent, tbOpt)
end

function DlgClass:RefreshTaskCharge_NoItem(nRouteId, nInvert)
	local tbOpt = {
		{LongMenBiaoJu.LANG.DLG_BACK, self.ShowRandomTaskResult, {self, nRouteId, nInvert}},
		{LongMenBiaoJu.LANG.DLG_CLOSE},
	}
	CreateNewSayEx(LongMenBiaoJu.LANG.MSG_NO_ITEM_PZ, tbOpt)
end

function DlgClass:ShowRandomTaskResult(nRouteId, nInvert)
	local task = LongMenBiaoJu:GetTaskClass()
	local lang = LongMenBiaoJu.LANG
	local szStartMap, szFinishMap, nType = task:GetRouteInfo(nRouteId, nInvert)
	local szContent = format(lang.DLG_CONFIRM_TASK_CONTENT, nType, szStartMap, szFinishMap, LongMenBiaoJu.TASK_TIME/60)
	
	local tbOpt = {
		{lang.DLG_RANDOM_ACCEPT, task.AcceptRandomTask, {task, nRouteId, nInvert}},
		{lang.DLG_RANDOM_REFRESH_FREE, self.OnSelRefreshTaskFree, {self, nRouteId, nInvert}},
		{lang.DLG_RANDOM_REFRESH_CHARGE, self.OnSelRefreshTaskCharge, {self, nRouteId, nInvert}},
		{lang.DLG_CLOSE},
	}
	CreateNewSayEx(szContent, tbOpt)
end

function DlgClass:OnSelSelectTypeHigh()
	CreateNewSayEx(LongMenBiaoJu.LANG.DLG_HIGH_CONTENT ,self.DlgOpt.ConfirmHighTask)
end

function DlgClass:OnConfirmHighTask()
	CreateNewSayEx(LongMenBiaoJu.LANG.DLG_HIGH_CONTENT_FINAL ,self.DlgOpt.ConfirmHighTaskFinal)
end

function DlgClass:OnConfirmHighTaskFinal()
	local task = LongMenBiaoJu:GetTaskClass()
	task:AcceptHighTask()
end

function DlgClass:BuyItem(tbItem)
	local tbHuBiaoLing = LongMenBiaoJu.ItemList.HuBiaoLing
	local tbFormula = {
		tbMaterial = {
			{tbProp=tbHuBiaoLing.tbProp, szName=tbHuBiaoLing.szName, nCount=tbItem.nPrice}
		},
		tbProduct = tbItem,
		nWidth = 1,
		nHeight = 1,
		nFreeItemCellLimit = 0.02,
	}
	tbActivityCompose:new(tbFormula, "LongMenBiaoJuShop"):ComposeDailog(1)
	
end

function DlgClass:OnSelOpenShop()
	CreateNewSayEx(LongMenBiaoJu.LANG.DLG_SHOP, self.DlgOpt.Shop)
end

local lang = LongMenBiaoJu.LANG

DlgClass.DlgOpt = {
	ZhangGui = {
		{lang.DLG_ACCEPT_TASK, DlgClass.OnSelAcceptTask, {DlgClass}},
		{lang.DLG_CANCEL_TASK, DlgClass.OnSelCancelTask, {DlgClass}},
		{lang.DLG_GET_AWARD, DlgClass.OnSelFinishTask, {DlgClass}},
		{lang.DLG_VIEW_INFO, DlgClass.OnSelViewTaskInfo, {DlgClass}},
		{lang.DLG_TRANSFER_TO_BIAOCHE, DlgClass.OnSelTransferToBiaoChe, {DlgClass}},
		{lang.DLG_OPEN_SHOP, DlgClass.OnSelOpenShop, {DlgClass}},
		{lang.DLG_CLOSE},
	},
	BiaoShi = {
		{lang.DLG_START_TASK, DlgClass.OnSelStartTask, {DlgClass}},
		{lang.DLG_GET_AWARD, DlgClass.OnSelFinishTask, {DlgClass}},
		{lang.DLG_VIEW_INFO, DlgClass.OnSelViewTaskInfo, {DlgClass}},
		{lang.DLG_TRANSFER_TO_BIAOCHE, DlgClass.OnSelTransferToBiaoChe, {DlgClass}},
		{lang.DLG_OPEN_SHOP, DlgClass.OnSelOpenShop, {DlgClass}},
		{lang.DLG_CLOSE},
	},
	SelectTaskType = {
		{lang.DLG_ACCEPT_TYPE_LOW, DlgClass.OnSelSelectTypeLow, {DlgClass}},
		{lang.DLG_ACCEPT_TYPE_RANDOM, DlgClass.OnSelSelectTypeRandom, {DlgClass}},
		{lang.DLG_ACCEPT_TYPE_HIGH, DlgClass.OnSelSelectTypeHigh, {DlgClass}},
		{lang.DLG_CLOSE},
	},
	ConfirmHighTask = {
		{lang.DLG_HIGH_CONFIRM, DlgClass.OnConfirmHighTask, {DlgClass}},
		{lang.DLG_CLOSE},
	},
	ConfirmHighTaskFinal = {
		{lang.DLG_CONFIRM, DlgClass.OnConfirmHighTaskFinal, {DlgClass}},
		{lang.DLG_CLOSE},
	},
	ConfirmCancel = {
		{lang.DLG_CONFIRM, DlgClass.OnSelConfirmCancel, {DlgClass}},
		{lang.DLG_CANCEL},
	},
	Shop = {
		{lang.DLG_ITEM_NAME_1, DlgClass.BuyItem, {DlgClass, LongMenBiaoJu.ItemList.KuaiMaJiaBian}},
		{lang.DLG_ITEM_NAME_2, DlgClass.BuyItem, {DlgClass, LongMenBiaoJu.ItemList.JianBuKeCui}},
		{lang.DLG_ITEM_NAME_3, DlgClass.BuyItem, {DlgClass, LongMenBiaoJu.ItemList.BiaoCheWeiYi}},
		{lang.DLG_CLOSE},
	}
}

function LongMenBiaoJu:CallBack_QueryBiaoChe(nParam, HResult)
	if OB_IsEmpty(HResult) == 1 then
		return
	end
	
	local szPlayer = ObjBuffer:PopObject(HResult)
	local tbData = ObjBuffer:PopObject(HResult)
	if type(tbData) ~= "table" then
		return
	end
	
	local nPlayerIndex = SearchPlayer(szPlayer)
	if nPlayerIndex <= 0 then
		return
	end
	
	if nParam == 0 then
		local dlg = LongMenBiaoJu:GetDlgClass()
		CallPlayerFunction(nPlayerIndex, dlg.ViewTaskInfo, dlg, tbData)
	elseif nParam == 1 then
		local task = LongMenBiaoJu:GetTaskClass()
		CallPlayerFunction(nPlayerIndex, task.TransferToBiaoChe, task, tbData)
	elseif nParam == 2 then
		local dlg = LongMenBiaoJu:GetDlgClass()
		CallPlayerFunction(nPlayerIndex, dlg.ShowFinishTaskResult, dlg, tbData)
	end
end

