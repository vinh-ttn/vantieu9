Include("\\script\\event\\longmenbiaoju\\head.lua")
Include("\\script\\event\\longmenbiaoju\\lang.lua")

local BrokenBiaoCheClass = {}
BrokenBiaoCheClass.tbNpcInfo = {
	nId=2158, szName= LongMenBiaoJu.LANG.NPC_NAME_BROKEN_BIAOCHE, nLevel=95
}
BrokenBiaoCheClass.NPC_PARAM_DEL = 1
BrokenBiaoCheClass.NPC_PARAM_START_TIME = 2
BrokenBiaoCheClass.List = {}

function BrokenBiaoCheClass:CreateNpc(nMapIndex, nX32, nY32, szOwner, nTaskTime)
	local NpcInfo = self.tbNpcInfo
	local nNpcIndex = AddNpcEx(NpcInfo.nId, NpcInfo.nLevel, 0, nMapIndex, nX32, nY32, 1, NpcInfo.szName, 0)
	if not(nNpcIndex > 0) then
		return
	end
	
	local npc = {
		szOwner = szOwner,
		nNpcIndex = nNpcIndex,
	}
	
	self.List[nNpcIndex] = npc
	
	SetNpcParam(nNpcIndex, self.NPC_PARAM_START_TIME, nTaskTime)
	SetNpcActiveRegion(nNpcIndex, 1)
	SetNpcScript(nNpcIndex, "\\script\\event\\longmenbiaoju\\broken_biaoche.lua")
	SetNpcTimer(nNpcIndex, LongMenBiaoJu.BIAOQI_TIME * 18)
	
	return npc
end


function OnTimer(nNpcIndex)
	local class = LongMenBiaoJu.BrokenBiaoCheClass
	local npc = class:FindNpc(nNpcIndex)
	if npc then
		class:RemoveNpc(npc)
	end
end

function BrokenBiaoCheClass:FindNpc(nNpcIndex)
	local tbData = self.List[nNpcIndex]
	if tbData and tbData.nNpcIndex == nNpcIndex then
		return tbData
	end
end

function BrokenBiaoCheClass:OnClick(npc)
	local szPlayer = GetName()
	if npc.szOwner ~= szPlayer then
		Msg2Player("Ng­¬i kh«ng thÓ nhËn Tiªu Kú cña ng­êi kh¸c")
		return
	end
	
	if GetNpcParam(nNpcIndex, self.NPC_PARAM_DEL) == 1 then
		return
	end
	
	local data = LongMenBiaoJu:GetDataClass()
	if data:GetStartTime() ~= GetNpcParam(npc.nNpcIndex, self.NPC_PARAM_START_TIME) then
		--Talk(1, "", LongMenBiaoJu.LANG.MSG_BAG_FULL)
		return
	end
	
	if CalcFreeItemCellCount() < 1 then
		Talk(1, "", LongMenBiaoJu.LANG.MSG_BAG_FULL)
		return
	end
	
	PlayerFunLib:GetItem(LongMenBiaoJu.ItemList.BiaoQi, 1, "LongMenBiaoJu" , "PickBiaoQi")
	self:RemoveNpc(npc)
end

function BrokenBiaoCheClass:RemoveNpc(npc)
	SetNpcParam(npc.nNpcIndex, self.NPC_PARAM_DEL, 1)
	DelNpc(npc.nNpcIndex)
	self.List[npc.nNpcIndex] = nil
end

function main()
	local nNpcIndex = GetLastDiagNpc()
	local class = LongMenBiaoJu.BrokenBiaoCheClass
	local npc = class:FindNpc(nNpcIndex)
	if npc then
		class:OnClick(npc)
	end
end

LongMenBiaoJu.BrokenBiaoCheClass = BrokenBiaoCheClass