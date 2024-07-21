Include("\\script\\event\\longmenbiaoju\\head.lua")

local BiaoCheClass = {}
BiaoCheClass.tbNpcType = {
	[1] = {nId=2146, nLevel=95}, 
	[2] = {nId=2147, nLevel=95}, 
	[3] = {nId=2148, nLevel=95}, 
}

BiaoCheClass.tbNpcLevel = {1, 1, 1, 2, 2, 2, 3, 3, 3}

BiaoCheClass.SYNC_LIMIT = 5

function BiaoCheClass:New(nType, nMapId, nX, nY, szOwner)
	local tbNew = self:_new()
	tbNew:CreateNpc(nType, nMapId, nX, nY, szOwner)
	tbNew:SyncDataToRelay()
	return tbNew
end

function BiaoCheClass:_new()
	local tbNew = {}
	for k, v in self do
		tbNew[k] = v
	end
	return tbNew
end


function BiaoCheClass:CreateNpc(nType, nMapId, nX, nY, szOwner)
	local nMapIndex = SubWorldID2Idx(nMapId)
	if not(nMapIndex >= 0) then --the map isn't in this server
		return
	end

	local NpcInfo = self.tbNpcType[self.tbNpcLevel[nType]]
	local szNpcName = format(LongMenBiaoJu.LANG.BIAOCHE_NAME, nType, szOwner)
	local nNpcIndex = AddNpcEx(NpcInfo.nId, NpcInfo.nLevel, random(0,4), nMapIndex, nX *32, nY * 32, 1, szNpcName, 1)
	if not(nNpcIndex > 0) then
		return
	end
	SetNpcActiveRegion(nNpcIndex, 1)
	SetNpcScript(nNpcIndex, "\\script\\event\\longmenbiaoju\\biaoche.lua")
	SetNpcTimer(nNpcIndex, 1)
	SetNpcAI(nNpcIndex, 0)
	self.nNpcIndex = nNpcIndex
	self.nType = nType
	self.szOwner = szOwner
	self.nPlayerLeaveTime = GetCurServerTime()
	self.nLastSyncTime = 0
	self.nState = 0
	self.nCreateTime = self.nPlayerLeaveTime
	return self
end

function BiaoCheClass:SetCreateTime(nCreateTime)
	self.nCreateTime = nCreateTime
end

function BiaoCheClass:GetCreateTime()
	return self.nCreateTime
end

function BiaoCheClass:OwnerFarAway()
	if self.bOwnerHere then
		self.bOwnerHere = nil
		self:OnOwnerLeave()
	else
		if GetCurServerTime() - self.nPlayerLeaveTime >= LongMenBiaoJu.BIAOCHE_ALONE then
			local _, _, nMapIndex = GetNpcPos(self.nNpcIndex)
			tbLog:TabFormatLog(GetLocalDate("%H:%M"), GetLocalDate("%d/%m/%Y"), GetServerName(), "LongMenBiaoJu", 
				"BiaoCheDisappearLeavePlayer", "Owner:"..self.szOwner, "map:"..SubWorldName(nMapIndex))
			return 1 --表示镖车要死亡了
		end
	end
end

function BiaoCheClass:OwnerNear(nOwnerIndex, nX, nY)
	if not self.bOwnerHere then
		self.bOwnerHideOrDeath = 1
		self:OnOwnerEnter()
		self.bOwnerHere = 1
	end
	
	self.nState = CallPlayerFunction(nOwnerIndex, GetFightState)
	
	if IsPlayerDeath(nOwnerIndex) == 0 and IsPlayerHidden(nOwnerIndex) == 0 then
		NpcWalk(self.nNpcIndex, nX, nY)
		if self.bOwnerHideOrDeath == 1 then
			self.bOwnerHideOrDeath = nil
			SetNpcFightState(self.nNpcIndex, 0)
		end
	else
		if self.bOwnerHideOrDeath == nil then
			self.bOwnerHideOrDeath = 1
			SetNpcFightState(self.nNpcIndex, 1)
			StopNpcAction(self.nNpcIndex)
		end
	end
end

function BiaoCheClass:OnOwnerEnter()
	self.bNotifyOwner = nil
	local nOwnerIndex = SearchPlayer(self.szOwner)
	if nOwnerIndex > 0 then
		CallPlayerFunction(nOwnerIndex, DisabledUseTownP, 1)
		CallPlayerFunction(nOwnerIndex, DisabledUseHeart, 1)
	end
end

function BiaoCheClass:OnOwnerLeave()
	SetNpcFightState(self.nNpcIndex, 1)
	local nCurTime = GetCurServerTime()
	StopNpcAction(self.nNpcIndex)
	self.nPlayerLeaveTime = nCurTime
	self:SyncDataToRelay()
	self:NotifyOwner()

	local nOwnerIndex = SearchPlayer(self.szOwner)
	if nOwnerIndex > 0 then
		CallPlayerFunction(nOwnerIndex, DisabledUseTownP, 0)
		CallPlayerFunction(nOwnerIndex, DisabledUseHeart, 0)
	end

end

function BiaoCheClass:IsPlayerNear(nPlayerIndex)
	local nPlayerX32, nPlayerY32, nPlayerMapIndex = CallPlayerFunction(nPlayerIndex, GetPos)
	local nSelfX32, nSelfY32, nSelfMapIndex = GetNpcPos(self.nNpcIndex)
	local nDis = ((nPlayerX32 - nSelfX32)^2) + ((nPlayerY32 - nSelfY32)^2)
	if nPlayerMapIndex == nSelfMapIndex and nDis <= LongMenBiaoJu.FOLLOW_DISTANCE then
		return 1
	end
end

function BiaoCheClass:TransferToPlayer(nPlayerIndex)
	local nPlayerMapId, nPlayerX32, nPlayerY32 = CallPlayerFunction(nPlayerIndex, GetWorldPos)
	NpcNewWorld(self, nPlayerMapId, nPlayerX32, nPlayerY32)
end

function BiaoCheClass:NotifyOwner()
	if self.bNotifyOwner == nil then
		self.bNotifyOwner = 1
		local nOwnerIndex = SearchPlayer(self.szOwner)
		if nOwnerIndex > 0 then
			CallPlayerFunction(nOwnerIndex, Msg2Player, LongMenBiaoJu.LANG.MSG_BIAOCHE_FARAWAY)
		else
			local handle = OB_Create()
			ObjBuffer:PushObject(handle, szOwner)
			ObjBuffer:PushObject(handle, LongMenBiaoJu.LANG.MSG_BIAOCHE_FARAWAY)
			RemoteExecute(LongMenBiaoJu.szRelayFile, "LongMenBiaoJu:Msg2Player", handle)
			OB_Release(handle)
		end
	end
end

function BiaoCheClass:Breath(nTimeOut) --返回nil, 表示没有呼吸了
	if GetCurServerTime() - self.nCreateTime >= LongMenBiaoJu.BIAOCHE_LIFE then
		local _, _, nMapIndex = GetNpcPos(self.nNpcIndex)
		tbLog:TabFormatLog(GetLocalDate("%H:%M"), GetLocalDate("%d/%m/%Y"), GetServerName(), "LongMenBiaoJu", 
			"BiaoCheDisappearTaskTimeout", "Owner:"..self.szOwner, "map:"..SubWorldName(nMapIndex))
		return
	end
	
	local nOwnerIndex = SearchPlayer(self.szOwner)
	if not (nOwnerIndex > 0) then
		return not self:OwnerFarAway()
	end
	
	local nOwnerX32, nOwnerY32, nOwnerMapIndex = CallPlayerFunction(nOwnerIndex, GetPos)
	if not nOwnerX32 then
		return not self:OwnerFarAway()
	end
	
	local nSelfX32, nSelfY32, nSelfMapIndex = GetNpcPos(self.nNpcIndex)
	local nDis = ((nOwnerX32 - nSelfX32)^2) + ((nOwnerY32 - nSelfY32)^2)
	if nOwnerMapIndex ~= nSelfMapIndex or nDis >= LongMenBiaoJu.FOLLOW_DISTANCE then
		return not self:OwnerFarAway()
	end
	
	self:OwnerNear(nOwnerIndex, nOwnerX32/32, nOwnerY32/32)
	return 1 --Keep Breath
end

function BiaoCheClass:OnDeath() --全局PlyaerIndex； >0 表示最后一击的玩家. =0表示不是玩家最后一击
	local task = LongMenBiaoJu:GetTaskClass()
	task:OnBiaoCheBroken(self)
	self:DeleteRelayData()
	LongMenBiaoJu:RemoveBiaoChe(self)
end

function BiaoCheClass:DelNpc()
	DelNpc(self.nNpcIndex)
	self.nNpcIndex = nil
end

function OnTimer(nNpcIndex, nTimeOut)
	local npc = LongMenBiaoJu:FindBiaoCheByIndex(nNpcIndex)
	if npc then
		if npc:Breath(nTimeOut) then
			SetNpcTimer(npc.nNpcIndex, 18)
		else
			local task = LongMenBiaoJu:GetTaskClass()
			npc:DeleteRelayData()
			task:OnBiaoCheTimeout(npc)
			LongMenBiaoJu:RemoveBiaoChe(npc)
			npc:DelNpc()
		end
	end
end

function BiaoCheClass:OnTaskFinish()
	self:DeleteRelayData()
	LongMenBiaoJu:RemoveBiaoChe(self)
	self:DelNpc()
end

function OnDeath(nNpcIndex)
	local npc = LongMenBiaoJu:FindBiaoCheByIndex(nNpcIndex)
	if npc then
		npc:OnDeath()
	end
end

function BiaoCheClass:SyncDataToRelay()
	local nX, nY, nMapIndex = GetNpcPos(self.nNpcIndex)
	local nLife = GetNpcCurLife(self.nNpcIndex)
	local nMapId = SubWorldIdx2ID(nMapIndex)
	
	local handle = OB_Create()
	ObjBuffer:PushObject(handle, {nX32=nX, nY32=nY, nMapId=nMapId, nLife=nLife, szOwner=self.szOwner, nState=self.nState})
	RemoteExecute(LongMenBiaoJu.szRelayFile, "LongMenBiaoJu:SyncBiaoChe", handle)
	OB_Release(handle)
end

function BiaoCheClass:DeleteRelayData()
	local handle = OB_Create()
	ObjBuffer:PushObject(handle,self.szOwner)
	RemoteExecute(LongMenBiaoJu.szRelayFile, "LongMenBiaoJu:DeleteBiaoChe", handle)
	OB_Release(handle)
end

LongMenBiaoJu.BiaoCheClass = BiaoCheClass
