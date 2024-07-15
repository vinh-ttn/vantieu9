-- ÁúÃÅïÚ¾Ö£¨ÔöÒæµÀ¾ß°ó¶¨½Å±¾£©
Include("\\script\\activitysys\\config\\129\\head.lua");
Include("\\script\\activitysys\\config\\129\\config.lua");
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

function main(nItemIndex)
	-- ¼ì²éµÈ¼¶
	if PlayerFunLib:CheckTotalLevel(150,"ChØ ng­êi ch¬i ®¹t cÊp 150 hoÆc ®· chuyÓn sinh míi cã thÓ dïng ®¹o cô nµy!",">=") ~= 1 then
		return 1;
    end
    local nG, nD, nP =  GetItemProp(nItemIndex);
    if (nP>4207 or nP<4204) then
        return nil;
    end
    -- ÊÇ·ñ½ÓÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        return 1;
    end

    local nCarNpcIndex = GetTask(TSK_LMBJCarIndex);
    if (nCarNpcIndex == 0) then
        Talk(1, "", "HiÖn kh«ng cã Tiªu Xa, kh«ng thÓ dïng ®¹o cô.");
        return 1;
    end

    -- ¼ì²éÊÇ·ñÔÚÀäÈ´Ê±¼ä(5·ÖÖÓ)
    local nCurTime = GetCurrentTime();
    local nItemTaskID = nP - 4204 + TSK_ItemKMJBTime;
    local nLeftTime = 180 - (nCurTime-GetTask(nItemTaskID));
    if nLeftTime > 0 then
        Talk(1, "", format("Ng­¬i võa sö dông ®¹o cô nµy, sau %d phót %d gi©y n÷a sö dông l¹i", floor(nLeftTime/60), mod(nLeftTime, 60)));
        return 1;
    end
    -- ¼ì²éïÚ³µÊÇ·ñÔÚÓÐÐ§·¶Î§
    local nX32, nY32, nMapIdx = GetBiaoChePos();
    local nPMapID, nPX, nPY = GetWorldPos();
    if (nMapID == -1 or nMapIdx ~= SubWorldID2Idx(nPMapID)) then
        Talk(1, "", "Tiªu Xa kh«ng n»m trong ph¹m vi cã hiÖu qu¶, h·y l¹i gÇn Tiªu Xa.");
        return 1;
    end
    local nDistance = sqrt((nX32-nPX*32)*(nX32-nPX*32) + (nY32-nPY*32)*(nY32-nPY*32));
    if ( nDistance >= 750) then
        Talk(1, "", "Tiªu Xa kh«ng n»m trong ph¹m vi cã hiÖu qu¶, h·y l¹i gÇn Tiªu Xa.");
        return 1;
    end
    -- ¿ìÂí¼Ó±Þ
    if (nP == 4204) then
        SetTask(nItemTaskID, nCurTime);
        NpcCastSkill(nCarNpcIndex, 1467, 1);
        return nil;
    end
    -- ¼á²»¿É´Ý
    if (nP == 4205) then
        -- »ñÈ¡ÑºïÚÈÎÎñÐÅÏ¢
        local nId = floor(nTaskFlagValue/10);       -- ÑºïÚÂ·ÏßID
        SetTask(nItemTaskID, nCurTime);
        NpcCastSkill(nCarNpcIndex, 1468, getSkillLevel(nId));
        return nil;
    end
    -- Ìú¼¬ÃÜ²¼
--    if (nP == 4206) then
--        SetTask(nItemTaskID, nCurTime);
--        NpcCastSkill(nCarNpcIndex, 1469, 1);
--        return nil;
--    end
    -- ïÚ³µÒÆÎ»
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

