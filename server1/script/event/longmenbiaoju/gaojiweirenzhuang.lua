Include("\\script\\misc\\eventsys\\type\\func.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\droptemplet.lua")

function OnKillKillerBoss(nTaskId, nTaskValue)
	local nKillerLevel = (ceil(GetTask(nTaskId)/20)+1)*10
	if nKillerLevel ~= 90 then
		return 
	end
	local tbAward = {{tbProp={6,1,4202,1,0,0}, nRate=0.2}}
	if CalcFreeItemCellCount() > 0 then
		tbAwardTemplet:Give(tbAward, 1, {"FinishKiller90", "Get_GaoJiWeiRenZhuang"})
	else
		tbDropTemplet:DropItem(GetNpcIdx(), PlayerIndex, tbAward)
	end
end

EventSys:GetType("KillerBoss"):Reg("OnKillBoss", OnKillKillerBoss)