-- ÁúÃÅïÚ¾ÖïÚ³µ°ó¶¨½Å±¾

Include("\\script\\global\\maplist.lua")
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\extend.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

tbDialogNpcList = {
    ["LÔ Quan"]         = 1,
    ["BÐ Long"]         = 1,
    ["§¹i sø ho¹t ®éng"]     = 1,
    ["MÆc Th¹ch L·o Nh©n"]     = 1,
    ["R­¬ng chøa ®å"]       = 1,
    ["NhiÕp ThÝ TrÇn"]       = 1,
    ["B×nh B×nh c« n­¬ng"]     = 1,
    ["Xa phu"]         = 1,
    [" VÖ binh Thµnh m«n"]     = 1,
    ["Quan nh¾c nhë Hoµng Thµnh T­"] = 1,
    ["Vâ l©m truyÒn nh©n"]   = 1,
    ["TriÒu §×nh Chiªu Mé Sø"]   = 1,
    ["D· TÈu"]         = 1,
    ["Long M«n Tiªu S­"]     = 1,
}


function OnTimer(nNpcIndex, nTimeOut)
    local nTongId = GetNpcParam(nNpcIndex, 5) + GetNpcParam(nNpcIndex, 6);
    local tbPlayerList, nCount = GetNpcAroundPlayerList(nNpcIndex, 25);
    local nOldPlayerIndex = PlayerIndex;
    for i = 1, nCount do
        PlayerIndex = tbPlayerList[i];
        local szScripPath = "\\script\\activitysys\\config\\129\\extend.lua";
        local szFunName = "pActivity:AddFollowExp"
        DynamicExecuteByPlayer(tbPlayerList[i], szScripPath, szFunName, nTongId);
    end
    PlayerIndex = nOldPlayerIndex;
    SetNpcTimer(nNpcIndex, 18*60);
end

-- npc death
function OnDeath(nNpcIndex)
    local nX32, nY32, nMapIdx = GetNpcPos(nNpcIndex);
    local nMapID = SubWorldIdx2ID(nMapIdx);
    -- »ñÈ¡ïÚ³µÐÅÏ¢
    local nLevel = GetNpcParam(nNpcIndex, 1);
    local nHash1 = GetNpcParam(nNpcIndex, 2); -- ½ÓïÚÍæ¼ÒÃû×ÖHashÖµ1
    local nHash2 = GetNpcParam(nNpcIndex, 3); -- ½ÓïÚÍæ¼ÒÃû×ÖHashÖµ2
    local nTaskTime = GetNpcParam(nNpcIndex, 4); -- »ñÈ¡Õâ´Î½ÓïÚÊ±¼ä
    SyncBiaoCheDeathInfoToRelay(nNpcIndex);

    -- ÅÐ¶ÏÊÇ·ñÔÚÈÈÃÅNPC¸½½ü
    local tbNpcIdxList, nCount = GetNpcAroundNpcList(nNpcIndex, 5);
    for i = 1, nCount do
        local nNpcIdx = tbNpcIdxList[i];
        local szNpcName = GetNpcName(nNpcIdx);
        if tbDialogNpcList[szNpcName] == 1 then
            WriteYunBiaoLog(format("<%s> t¹i <%s> ®· hñy <%s>, ®ang trong thao t¸c tr¹ng th¸i chiÕn ®Êu.", GetName(), tbGlobalMapId2Name[nMapID], szBiaoCheName));
            return nil;
        end
    end

    local szBiaoCheName = GetNpcName(nNpcIndex);

    if nLevel < 10 then
        -- ÕÒ²»µ½Íæ¼ÒË÷Òý
        if not PlayerIndex or PlayerIndex <= 0 then
            return nil;
        end
        -- »ñÈ¡×îºóÒ»»÷µÄ½ÙïÚÍæ¼ÒµÄÎ»ÖÃ_Ë¢±¦Ïä
        local _, nPX, nPY = GetWorldPos();
        -- »ñÈ¡ïÚ³µÎ»ÖÃ_Ë¢ÆÆËðïÚ³µ
        local nNpcBQIdx = AddNpcEx(2158, 1, 1, nMapIdx, nX32, nY32, 1, "Tiªu Xa bÞ ph¸ ho¹i", 0);
        SetNpcScript(nNpcBQIdx, "\\script\\activitysys\\config\\129\\npc_lmbiaoqi.lua");
        SetNpcTimer(nNpcBQIdx, 600*18);
        SetNpcParam(nNpcBQIdx, 1, nLevel); -- ÉèÖÃïÚÆìµÄµÈ¼¶
        SetNpcParam(nNpcBQIdx, 2, nHash1); -- ½ÓïÚÍæ¼ÒÃû×ÖHashÖµ1
        SetNpcParam(nNpcBQIdx, 3, nHash2); -- ½ÓïÚÍæ¼ÒÃû×ÖHashÖµ2
        SetNpcParam(nNpcBQIdx, 4, nTaskTime); -- ±£´æ½ÓïÚÊ±¼ä£¬·ÀÖ¹Íæ¼Ò½ÓÈÎÎñºóÔÙÀ´¼ñÆì
        -- Ë¢±¦Ïä
        local nBXNpcIdx = AddNpcEx(2156, 1, 1, nMapIdx, nPX*32, nPY*32, 1, "T¸n L¹c Tiªu VËt", 0);
        SetNpcScript(nBXNpcIdx, "\\script\\activitysys\\config\\129\\npc_lmbiaowu.lua");
        SetNpcTimer(nBXNpcIdx, 600*18);
        SetNpcParam(nBXNpcIdx, 1, nLevel);  -- ÉèÖÃïÚÎïµÄµÈ¼¶
        SetNpcParam(nBXNpcIdx, 2, 0);       -- ÒÑ±»µã»÷´ÎÊý
        SetNpcParam(nBXNpcIdx, 3, GetCurrentTime()); -- ïÚÎïÈ÷ÂäÊ±¼ä_¼ñïÚ±£»¤Ê±¼ä
        local dwHashValue = String2Id( GetName() );
        nHash1 = floor(dwHashValue/2);
        nHash2 = dwHashValue - nHash1;
        SetNpcParam(nBXNpcIdx, 4, nHash1);
        SetNpcParam(nBXNpcIdx, 5, nHash2);
        local szDataStr = "lmbj_car_kill_high";
        if (nLevel < 7) then
            szDataStr = "lmbj_car_kill_low";
        end
        AddStatData(szDataStr);
        WriteYunBiaoLog(format("[Long M«n Tiªu Côc] %s bÞ hñy, B¶n ®å hiÖn t¹i: %s", szBiaoCheName, tbGlobalMapId2Name[nMapID]));
    else -- Ë¢°ï»áïÚ³µ
        local szTongName = "";
        local nOwnerTongId = 0;
        local nAwardTongId = 0;
        if PlayerIndex and PlayerIndex > 0 then
            szTongName, nOwnerTongId = GetTongName();
            nAwardTongId = nOwnerTongId;
        end
        local nSrcHash1, nSrcHash2 = GetNpcParam(nNpcIndex,5), GetNpcParam(nNpcIndex,6);
        local nCarTongId = nSrcHash1 + nSrcHash2;
        local nBXNpcIdx = AddNpcEx(nNpcTongBoxID, 1, 1, nMapIdx, nX32, nY32, 1, szNpcTongBoxName, 0);
        SetNpcScript(nBXNpcIdx, szNpcTongBoxScriptPath);
        SetNpcTimer(nBXNpcIdx, 900*18);
        SetNpcParam(nBXNpcIdx, 1, 0);       -- ÒÑ±»µã»÷´ÎÊý
        SetNpcParam(nBXNpcIdx, 2, GetCurrentTime()); -- ïÚÎïÈ÷ÂäÊ±¼ä_¼ñïÚ±£»¤Ê±¼ä
        if nCarTongId == nOwnerTongId then
            nOwnerTongId = 0;
        end
        nHash1 = floor(nOwnerTongId/2);
        nHash2 = nOwnerTongId - nHash1;
        SetNpcParam(nBXNpcIdx, 3, nHash1);
        SetNpcParam(nBXNpcIdx, 4, nHash2);
        SetNpcParam(nBXNpcIdx, 5, nSrcHash1);
        SetNpcParam(nBXNpcIdx, 6, nSrcHash2);
        Msg2Tong(nCarTongId, format("Tiªu Xa Bang cña quý bang t¹i %s bÞ hñy.", tbGlobalMapId2Name[nMapID]));

	--°ï»á»îÔ¾¶ÈÏµÍ³ÐÂÔö£º°ï»áïÚ³µ±»½Ù£¬½ÙïÚ×îºóÒ»»÷Íæ¼ÒËùÔÚ°ï»á»ñµÃ»îÔ¾¶È
    	--local nJoinTongTime = GetJoinTongTime()
    	--if nAwardTongId > 0 and nJoinTongTime >= 7*24*60 then  --Èë°ïÊ±¼ä³¬¹ýÒ»ÖÜ·½¿ÉÔö¼Ó»îÔ¾¶È
    	    --DynamicExecute("\\script\\tong\\tong_huoyuedu.lua", "tbTongHuoYueDu:BangHuiYaBiao", nAwardTongId);
    	--end

        -- ÈÕÖ¾Âñµã
        AddStatData("bhyb_destroy_count");
        local szLogs = format("T¹i <%s> c«ng ph¸ %s", tbGlobalMapId2Name[nMapID], szBiaoCheName);
        pActivity:WriteTongYBLog(szLogs);
    end
end

