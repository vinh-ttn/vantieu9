Include("\\script\\event\\longmenbiaoju\\head.lua")

local Player = {}

function Player:New()
	local tbNew = {}
	for k, v in self do
		tbNew[k] = v
	end
	return tbNew
end

function Player:OnLeaveMap()
	local data = LongMenBiaoJu:GetDataClass()
	data:SetTransferFlag(0)
	--if self.nGameLoop ~= GetLoop() then --²Ètrapµã¿çµØÍ¼
	--	return
	--end

	local biaoche = LongMenBiaoJu:FindBiaoChe(GetName())
	if not biaoche then
		return
	end
	
	local nX1, nY1, nMapIndex1 = GetNpcPos(biaoche.nNpcIndex)
	local nX2, nY2, nMapIndex2 = GetPos()
	if nMapIndex1 ~= nMapIndex2 then
		return
	end
	
	local nDis = ((nX1-nX2) ^ 2) + ((nY1-nY2) ^ 2)
	if nDis <= LongMenBiaoJu.FOLLOW_DISTANCE then
		data:SetTransferFlag(1)
	end
end

function Player:OnEnterTrapPoint()
	self.nGameLoop = GetLoop()
end

function Player:OnEnterMap()
	local task = LongMenBiaoJu:GetTaskClass()
	local data = LongMenBiaoJu:GetDataClass()
	if data:GetTransferFlag() ~= 0 then
		data:SetTransferFlag(0)
		task:OnPlayerChangeMapByTrap()
	end
end

LongMenBiaoJu.PlayerClass = Player
