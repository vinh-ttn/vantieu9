-- 龙门镖局镖车绑定脚本

Include("\\script\\global\\maplist.lua")
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\extend.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

tbDialogNpcList = {
    ["L� Quan"]         = 1,
    ["B� Long"]         = 1,
    ["Чi s� ho箃 ng"]     = 1,
    ["M芻 Th筩h L穙 Nh﹏"]     = 1,
    ["Rng ch鴄 "]       = 1,
    ["Nhi誴 Th� Tr莕"]       = 1,
    ["B譶h B譶h c� nng"]     = 1,
    ["Xa phu"]         = 1,
    [" V� binh Th祅h m玭"]     = 1,
    ["Quan nh綾 nh� Ho祅g Th祅h T�"] = 1,
    ["V� l﹎ truy襫 nh﹏"]   = 1,
    ["Tri襲 ёnh Chi猽 M� S�"]   = 1,
    ["D� T萿"]         = 1,
    ["Long M玭 Ti猽 S�"]     = 1,
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
    -- 获取镖车信息
    local nLevel = GetNpcParam(nNpcIndex, 1);
    local nHash1 = GetNpcParam(nNpcIndex, 2); -- 接镖玩家名字Hash值1
    local nHash2 = GetNpcParam(nNpcIndex, 3); -- 接镖玩家名字Hash值2
    local nTaskTime = GetNpcParam(nNpcIndex, 4); -- 获取这次接镖时间
    SyncBiaoCheDeathInfoToRelay(nNpcIndex);

    -- 判断是否在热门NPC附近
    local tbNpcIdxList, nCount = GetNpcAroundNpcList(nNpcIndex, 5);
    for i = 1, nCount do
        local nNpcIdx = tbNpcIdxList[i];
        local szNpcName = GetNpcName(nNpcIdx);
        if tbDialogNpcList[szNpcName] == 1 then
            WriteYunBiaoLog(format("<%s> t筰 <%s>  h駓 <%s>, 產ng trong thao t竎 tr筺g th竔 chi課 u.", GetName(), tbGlobalMapId2Name[nMapID], szBiaoCheName));
            return nil;
        end
    end

    local szBiaoCheName = GetNpcName(nNpcIndex);

    if nLevel < 10 then
        -- 找不到玩家索引
        if not PlayerIndex or PlayerIndex <= 0 then
            return nil;
        end
        -- 获取最后一击的劫镖玩家的位置_刷宝箱
        local _, nPX, nPY = GetWorldPos();
        -- 获取镖车位置_刷破损镖车
        local nNpcBQIdx = AddNpcEx(2158, 1, 1, nMapIdx, nX32, nY32, 1, "Ti猽 Xa b� ph� ho筰", 0);
        SetNpcScript(nNpcBQIdx, "\\script\\activitysys\\config\\129\\npc_lmbiaoqi.lua");
        SetNpcTimer(nNpcBQIdx, 600*18);
        SetNpcParam(nNpcBQIdx, 1, nLevel); -- 设置镖旗的等级
        SetNpcParam(nNpcBQIdx, 2, nHash1); -- 接镖玩家名字Hash值1
        SetNpcParam(nNpcBQIdx, 3, nHash2); -- 接镖玩家名字Hash值2
        SetNpcParam(nNpcBQIdx, 4, nTaskTime); -- 保存接镖时间，防止玩家接任务后再来捡旗
        -- 刷宝箱
        local nBXNpcIdx = AddNpcEx(2156, 1, 1, nMapIdx, nPX*32, nPY*32, 1, "T竛 L筩 Ti猽 V藅", 0);
        SetNpcScript(nBXNpcIdx, "\\script\\activitysys\\config\\129\\npc_lmbiaowu.lua");
        SetNpcTimer(nBXNpcIdx, 600*18);
        SetNpcParam(nBXNpcIdx, 1, nLevel);  -- 设置镖物的等级
        SetNpcParam(nBXNpcIdx, 2, 0);       -- 已被点击次数
        SetNpcParam(nBXNpcIdx, 3, GetCurrentTime()); -- 镖物洒落时间_捡镖保护时间
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
        WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] %s b� h駓, B秐  hi謓 t筰: %s", szBiaoCheName, tbGlobalMapId2Name[nMapID]));
    else -- 刷帮会镖车
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
        SetNpcParam(nBXNpcIdx, 1, 0);       -- 已被点击次数
        SetNpcParam(nBXNpcIdx, 2, GetCurrentTime()); -- 镖物洒落时间_捡镖保护时间
        if nCarTongId == nOwnerTongId then
            nOwnerTongId = 0;
        end
        nHash1 = floor(nOwnerTongId/2);
        nHash2 = nOwnerTongId - nHash1;
        SetNpcParam(nBXNpcIdx, 3, nHash1);
        SetNpcParam(nBXNpcIdx, 4, nHash2);
        SetNpcParam(nBXNpcIdx, 5, nSrcHash1);
        SetNpcParam(nBXNpcIdx, 6, nSrcHash2);
        Msg2Tong(nCarTongId, format("Ti猽 Xa Bang c馻 qu� bang t筰 %s b� h駓.", tbGlobalMapId2Name[nMapID]));

	--帮会活跃度系统新增：帮会镖车被劫，劫镖最后一击玩家所在帮会获得活跃度
    	--local nJoinTongTime = GetJoinTongTime()
    	--if nAwardTongId > 0 and nJoinTongTime >= 7*24*60 then  --入帮时间超过一周方可增加活跃度
    	    --DynamicExecute("\\script\\tong\\tong_huoyuedu.lua", "tbTongHuoYueDu:BangHuiYaBiao", nAwardTongId);
    	--end

        -- 日志埋点
        AddStatData("bhyb_destroy_count");
        local szLogs = format("T筰 <%s> c玭g ph� %s", tbGlobalMapId2Name[nMapID], szBiaoCheName);
        pActivity:WriteTongYBLog(szLogs);
    end
end

