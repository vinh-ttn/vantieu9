Include("\\script\\event\\longmenbiaoju\\head.lua")
Include("\\script\\event\\longmenbiaoju\\lang.lua")
------------------------帮会运镖道具和个人运镖道具共用，越南版逻辑和大陆版逻辑共用
Include("\\script\\activitysys\\config\\129\\head.lua");
Include("\\script\\activitysys\\config\\129\\config.lua");
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

function LongMenBiaoJu:UseSkillItem(nItemIndex, tbItem)
	local nCurTime = GetCurServerTime()
	local nRemainTime = tbItem.CD - (nCurTime - GetTask(tbItem.nTaskId))
	if nRemainTime > 0 then
		Msg2Player(format(LongMenBiaoJu.LANG.MSG_ITEM_CD, floor(nRemainTime/60), mod(nRemainTime, 60)))
		return 1
	end
	
	local biaoche = LongMenBiaoJu:FindBiaoChe(GetName())
	if biaoche and biaoche:IsPlayerNear(PlayerIndex) == 1 then --个人镖车
		SetTask(tbItem.nTaskId, nCurTime)
		local nLevel = 1
		if tbItem.tbSkillLevel then
			nLevel = tbItem.tbSkillLevel[biaoche.tbNpcLevel[biaoche.nType]]
		end
		NpcCastSkill(biaoche.nNpcIndex, tbItem.nSkillId, nLevel)
	elseif UseForTongBiaoCheCheck(nItemIndex) == 1 then --帮会镖车
		UseForTongBiaoChe(nItemIndex, tbItem)
	else
		Msg2Player(LongMenBiaoJu.LANG.MSG_BIAOCHE_NOT_NEAR)
		return 1
	end
end

function LongMenBiaoJu:UseTransferItem(nItemIndex, tbItem)
	local nCurTime = GetCurServerTime()
	local nRemainTime = tbItem.CD - (nCurTime - GetTask(tbItem.nTaskId))
	if nRemainTime > 0 then
		Msg2Player(format(LongMenBiaoJu.LANG.MSG_ITEM_CD, floor(nRemainTime/60), mod(nRemainTime, 60)))
		return 1
	end
	
	local biaoche = LongMenBiaoJu:FindBiaoChe(GetName())
	if biaoche and biaoche:IsPlayerNear(PlayerIndex) == 1 then --个人镖车
		SetTask(tbItem.nTaskId, nCurTime)
		biaoche:TransferToPlayer(PlayerIndex)
	elseif UseForTongBiaoCheCheck(nItemIndex) == 1 then --帮会镖车
		UseForTongBiaoChe(nItemIndex, tbItem)
	else
		Msg2Player(LongMenBiaoJu.LANG.MSG_BIAOCHE_NOT_NEAR)
		return 1
	end
end

function main(nItemIndex)
	local nG,nD,nP = GetItemProp(nItemIndex)
	local szGDP = format("%d,%d,%d", nG, nD, nP)
	
	local tbItem = nil
	if szGDP == "6,1,4204" then
		return LongMenBiaoJu:UseSkillItem(nItemIndex, LongMenBiaoJu.ItemList.KuaiMaJiaBian)
	elseif szGDP == "6,1,4205" then
		return  LongMenBiaoJu:UseSkillItem(nItemIndex, LongMenBiaoJu.ItemList.JianBuKeCui)
	elseif szGDP == "6,1,4207" then
		return LongMenBiaoJu:UseTransferItem(nItemIndex, LongMenBiaoJu.ItemList.BiaoCheWeiYi)
	end
	
	return 1
end

function getSkillLevel(nTskID)
    local nLevel = pActivity.tbBJPathLevel[nTskID][2];
    local tbSkillLevelbyLevel = {
        [1] = 1,
        [2] = 1,
        [3] = 1,
        [4] = 2,
        [5] = 2,
        [6] = 2,
        [7] = 3,
        [8] = 3,
        [9] = 3,
        [10] = 3,
    }
    return tbSkillLevelbyLevel[nLevel];
end

--帮会运镖检查
function UseForTongBiaoCheCheck(nItemIndex)
	local nG,nD,nP = GetItemProp(nItemIndex)
	local nResult = 0
	-- 是否接任务
	local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
	if (nTaskFlagValue == 0) then
		return nResult;
	end

	local nCarNpcIndex = GetTask(TSK_LMBJCarIndex);
	if (nCarNpcIndex == 0) then
		return nResult;
	end
	
	-- 检查镖车是否在有效范围
	local nX32, nY32, nMapIdx = GetBiaoChePos();
	local nPMapID, nPX, nPY = GetWorldPos();
	if (nMapID == -1 or nMapIdx ~= SubWorldID2Idx(nPMapID)) then
		return nResult;
	end
	
	local nDistance = sqrt((nX32-nPX*32)*(nX32-nPX*32) + (nY32-nPY*32)*(nY32-nPY*32));
	if ( nDistance >= 750) then
		return nResult;
	end
	nResult = 1
	return nResult
end

--帮会运镖
function UseForTongBiaoChe(nItemIndex, tbItem)
	local nG,nD,nP = GetItemProp(nItemIndex)
	local nCarNpcIndex = GetTask(TSK_LMBJCarIndex);
	local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
	local nPMapID, nPX, nPY = GetWorldPos();
	local nCurTime = GetCurServerTime()
	
	if (nP == 4204) then
		SetTask(tbItem.nTaskId, nCurTime);
		NpcCastSkill(nCarNpcIndex, 1467, 1);
	elseif (nP == 4205) then
		-- 获取押镖任务信息
		local nId = floor(nTaskFlagValue/10);       -- 押镖路线ID
		SetTask(tbItem.nTaskId, nCurTime);
		NpcCastSkill(nCarNpcIndex, 1468, getSkillLevel(nId));
	elseif (nP == 4207) then
    SetTask(tbItem.nTaskId, nCurTime);
    SetNpcPos(nCarNpcIndex, nPX*32, nPY*32);
	end
end
