-- 龙门镖局（增益道具绑定脚本）
Include("\\script\\activitysys\\config\\129\\head.lua");
Include("\\script\\activitysys\\config\\129\\config.lua");
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

function main(nItemIndex)
	-- 检查等级
	if PlayerFunLib:CheckTotalLevel(150,"Ch� ngi ch琲 t c蕄 150 ho芻  chuy觧 sinh m韎 c� th� d飊g o c� n祔!",">=") ~= 1 then
		return 1;
    end
    local nG, nD, nP =  GetItemProp(nItemIndex);
    if (nP>4207 or nP<4204) then
        return nil;
    end
    -- 是否接任务
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        return 1;
    end

    local nCarNpcIndex = GetTask(TSK_LMBJCarIndex);
    if (nCarNpcIndex == 0) then
        Talk(1, "", "Hi謓 kh玭g c� Ti猽 Xa, kh玭g th� d飊g o c�.");
        return 1;
    end

    -- 检查是否在冷却时间(5分钟)
    local nCurTime = GetCurrentTime();
    local nItemTaskID = nP - 4204 + TSK_ItemKMJBTime;
    local nLeftTime = 180 - (nCurTime-GetTask(nItemTaskID));
    if nLeftTime > 0 then
        Talk(1, "", format("Ngi v鮝 s� d鬾g o c� n祔, sau %d ph髏 %d gi﹜ n鱝 s� d鬾g l筰", floor(nLeftTime/60), mod(nLeftTime, 60)));
        return 1;
    end
    -- 检查镖车是否在有效范围
    local nX32, nY32, nMapIdx = GetBiaoChePos();
    local nPMapID, nPX, nPY = GetWorldPos();
    if (nMapID == -1 or nMapIdx ~= SubWorldID2Idx(nPMapID)) then
        Talk(1, "", "Ti猽 Xa kh玭g n籱 trong ph筸 vi c� hi謚 qu�, h穣 l筰 g莕 Ti猽 Xa.");
        return 1;
    end
    local nDistance = sqrt((nX32-nPX*32)*(nX32-nPX*32) + (nY32-nPY*32)*(nY32-nPY*32));
    if ( nDistance >= 750) then
        Talk(1, "", "Ti猽 Xa kh玭g n籱 trong ph筸 vi c� hi謚 qu�, h穣 l筰 g莕 Ti猽 Xa.");
        return 1;
    end
    -- 快马加鞭
    if (nP == 4204) then
        SetTask(nItemTaskID, nCurTime);
        NpcCastSkill(nCarNpcIndex, 1467, 1);
        return nil;
    end
    -- 坚不可摧
    if (nP == 4205) then
        -- 获取押镖任务信息
        local nId = floor(nTaskFlagValue/10);       -- 押镖路线ID
        SetTask(nItemTaskID, nCurTime);
        NpcCastSkill(nCarNpcIndex, 1468, getSkillLevel(nId));
        return nil;
    end
    -- 铁棘密布
--    if (nP == 4206) then
--        SetTask(nItemTaskID, nCurTime);
--        NpcCastSkill(nCarNpcIndex, 1469, 1);
--        return nil;
--    end
    -- 镖车移位
    if (nP == 4207) then
        SetTask(nItemTaskID, nCurTime);
        SetNpcPos(nCarNpcIndex, nPX*32, nPY*32);
        return nil;
    end
    return nil;
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

