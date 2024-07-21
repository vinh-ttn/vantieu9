IncludeLib("NPCINFO")
 
		

function SetNpcCurLife(id, life)
	return NPCINFO_SetNpcCurrentLife(id, life)
end

function GetNpcCurLife(id)
	return NPCINFO_GetNpcCurrentLife(id)
end

function SetNpcFightState(id, canFight)
	if canFight == 1 then
		SetNpcKind(id, 4)
	else
		SetNpcKind(id, 0)
	end

end

function StopNpcAction(id)
	--SetNpcAI(id, 0)
end


function IsPlayerDeath(id)
	local pId = CallPlayerFunction(id, GetNpcIdx)
	if pId > 0 then
		return 0
	end
	return 1
end
function IsPlayerHidden(id)
	local pId = CallPlayerFunction(id, GetNpcIdx)
	if pId > 0 then
		return 0
	end
	return 1
end

function NpcNewWorld(npc, nMapId, nX, nY)
	print("NEW BAOCHE")
	DelNpc(npc.nNpcIndex)
	npc:CreateNpc(npc.nType, nMapId, nX, nY, npc.szOwner)
end