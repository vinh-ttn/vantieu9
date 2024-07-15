Include("\\script\\event\\longmenbiaoju\\head.lua")
Include("\\script\\event\\longmenbiaoju\\lang.lua")
Include("\\script\\lib\\progressbar.lua")

local BoxClass = {}
LongMenBiaoJu.BoxClass = BoxClass

BoxClass.tbNpcInfo = {
	nId=2156, szName=LongMenBiaoJu.LANG.NPC_NAME_BIAOWU, nLevel=95
}
BoxClass.NPC_PARAM_DEL = 1
BoxClass.List = {}


function BoxClass:CreateNpc(nType, nMapIndex, nX32, nY32, szOwner)
	local NpcInfo = self.tbNpcInfo
	local nNpcIndex = AddNpcEx(NpcInfo.nId, NpcInfo.nLevel, 0, nMapIndex, nX32, nY32, 1, NpcInfo.szName, 0)
	if not(nNpcIndex > 0) then
		return
	end
	
	local tbData = {}
	tbData.nCreateTime = GetCurServerTime()
	tbData.szOwner = szOwner
	tbData.nType = nType
	tbData.nPickupCount = 0
	tbData.nNpcIndex = nNpcIndex
	
	self.List[nNpcIndex] = tbData
	
	SetNpcActiveRegion(nNpcIndex, 1)
	SetNpcScript(nNpcIndex, "\\script\\event\\longmenbiaoju\\box.lua")
	SetNpcTimer(nNpcIndex, LongMenBiaoJu.BOX_TIME * 18)
	return tbData
end

function BoxClass:IsPickable(tbBoxData)
	local nPassTime = GetCurServerTime() - tbBoxData.nCreateTime
	if nPassTime >= LongMenBiaoJu.BOX_PROTECT_TIME then
		return 1
	end
	local szPlayer = GetName()
	if szPlayer == tbBoxData.szOwner then
		return 1;
	end
end

function BoxClass:FindBoxData(nNpcIndex)
	local tbData = self.List[nNpcIndex]
	if tbData and tbData.nNpcIndex == nNpcIndex then
		return tbData
	end
end

function BoxClass:Remove(nNpcIndex)
	self.List[nNpcIndex] = nil
end

function BoxClass:OnClick(tbBoxData)
	if GetNpcParam(nNpcIndex, self.NPC_PARAM_DEL) == 1 then
		return
	end
	
    if PlayerFunLib:CheckTotalLevel(LongMenBiaoJu.MIN_LEVEL, LongMenBiaoJu.LANG.MSG_CAN_NOT_PICK, ">=") ~= 1 then
	    return nil
	end
	
	if (GetCamp() == 0) then
		Talk(1, "", LongMenBiaoJu.LANG.MSG_CAN_NOT_PICK2)
		return nil
	end
	
	if self:IsPickable(tbBoxData) ~= 1 then
		Msg2Player(LongMenBiaoJu.LANG.MSG_CAN_NOT_PICK_NOW)
		return
	end
	
	if PlayerFunLib:GetTaskDaily(LongMenBiaoJu.TASK_ID.BIAOWU_PICK_COUNT) >= LongMenBiaoJu.MAX_BIAO_WU_PICK_COUNT then
		Talk(1, "", LongMenBiaoJu.LANG.MSG_BIWO_WU_MAX)
		return
	end
	
	local tbAwardData = LongMenBiaoJu.BoxAwardData[tbBoxData.nType]
	if not tbAwardData then
		return
	end
	
	if PlayerFunLib:CheckFreeBagCell(tbAwardData.tbRobber.nFreeBag, "default") ~= 1 then
		return
	end
	
	Msg2Player(LongMenBiaoJu.LANG.MSG_START_PICK)
	
	tbProgressBar:OpenByConfig(4, self.OnPick, {self, tbBoxData.nNpcIndex, GetNpcId(tbBoxData.nNpcIndex)}, self.OnBreak, {self});
end

function BoxClass:OnBreak()
	Msg2Player(LongMenBiaoJu.LANG.MSG_PICK_BROKEN)
end

function BoxClass:OnPick(nNpcIndex, nNpcId)
	if GetNpcId(nNpcIndex) ~= nNpcId then
		Msg2Player(LongMenBiaoJu.LANG.MSG_PICK_FAILED)
		return
	end
	
	local tbBoxData = self:FindBoxData(nNpcIndex)
	if not tbBoxData then
		Msg2Player(LongMenBiaoJu.LANG.MSG_PICK_FAILED)
	end
	
	if GetNpcParam(tbBoxData.nNpcIndex, self.NPC_PARAM_DEL) == 1 then
		Msg2Player(LongMenBiaoJu.LANG.MSG_PICK_FAILED)
		return
	end
	local tbAwardData = LongMenBiaoJu.BoxAwardData[tbBoxData.nType]
	if not tbAwardData then
		return
	end
	
	local tbInfo = tbAwardData.tbRobber
	if PlayerFunLib:CheckFreeBagCell(tbInfo.nFreeBag, "default") ~= 1 then
		return
	end

	PlayerFunLib:AddTaskDaily(LongMenBiaoJu.TASK_ID.BIAOWU_PICK_COUNT, 1)

	local nCurCount = tbBoxData.nPickupCount + 1
	tbBoxData.nPickupCount = nCurCount
	Msg2Player(LongMenBiaoJu.LANG.MSG_PICK_SUCCESS)
--	WriteYunBiaoLog(format("[龙门镖局] 账号：%s 角色：%s 拾取[%s]散落的镖物 ID：%d", GetAccount(), GetName(), GetNpcName(nNpcIndex), nCurCount));

	if (nCurCount >= tbInfo.nPickUpMax) then
		SetNpcParam(tbBoxData.nNpcIndex, self.NPC_PARAM_DEL, 1)
		DelNpc(nNpcIndex)
	end
	
	local nType = tbBoxData.nType
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
		
	tbAwardTemplet:Give(tbAwardData.tbAward, tbInfo.nCount, {"LongMenBiaoJu", "RobberAward"})
	tbLog:PlayerActionLog("LongMenBiaoJu", "PickUpBiaowu")
end

function main()
	local nNpcIndex = GetLastDiagNpc()
	local BoxClass = LongMenBiaoJu.BoxClass
	local tbBoxData = BoxClass:FindBoxData(nNpcIndex)
	BoxClass:OnClick(tbBoxData)
end

function OnTimer(nNpcIndex)
	LongMenBiaoJu.BoxClass:Remove(nNpcIndex)
	SetNpcParam(nNpcIndex, LongMenBiaoJu.BoxClass.NPC_PARAM_DEL, 1)
	DelNpc(nNpcIndex)
end