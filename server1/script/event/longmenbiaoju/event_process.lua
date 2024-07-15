Include("\\script\\event\\longmenbiaoju\\head.lua")
Include("\\script\\misc\\eventsys\\type\\player.lua")
Include("\\script\\misc\\eventsys\\type\\map.lua")

function LongMenBiaoJu:OnPlayerLeaveMap()
	local szName = GetName()
	if not szName then
		return
	end
	local player = self:FindPlayer(szName)
	if player then
		player:OnLeaveMap()
		self:DelPlayer(szName)
	end
end

function LongMenBiaoJu:OnPlayerEnterMap()
	local szName = GetName()
	if not szName then
		return
	end
	local data = self:GetDataClass()
	if (data:GetType() == 0) or (data:GetStartTime() == 0) then
		return
	end
	
	local player = self:FindPlayer(szName)
	if not player then
		player = self:NewPlayer(szName)
	end
	if player then
		player:OnEnterMap()
	end
end

function LongMenBiaoJu:OnPlayerEnterTrapPoint()
	local szName = GetName()
	if not szName then
		return
	end
	local player = self:FindPlayer(szName)
	if player then
		player:OnEnterTrapPoint()
	end
end

EventSys:GetType("OnEnterTrapPoint"):Reg(0, LongMenBiaoJu.OnPlayerEnterTrapPoint, LongMenBiaoJu)
EventSys:GetType("LeaveMap"):Reg("ALL", LongMenBiaoJu.OnPlayerLeaveMap, LongMenBiaoJu)
EventSys:GetType("EnterMap"):Reg("ALL", LongMenBiaoJu.OnPlayerEnterMap, LongMenBiaoJu)
