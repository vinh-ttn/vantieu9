-- 龙门镖局活动 -- 镖车被劫后的镖物绑定脚本
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\activitysys\\g_activity.lua");
Include("\\script\\dailogsys\\g_dialog.lua");

Include("\\script\\lib\\progressbar.lua");
Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\activitysys\\playerfunlib.lua");

-- clear npc
function OnTimer(nNpcIndex, nTimeOut)
    DelNpc(nNpcIndex);
end

--break
local _OnBreak = function(nNpcIndex)
	Msg2Player("Qu� tr譶h nh薾 Ti猽 v藅 b� t 畂筺 r錳.");
	return 0;
end

-- process
local _GetAward = function(nNpcIndex, dwNpcID)
    local nTSK_DailyPickNum = 3501;
    if GetNpcParam(nNpcIndex, 6) == 1 then
        return nil;
    end
    -- npc index 非法
    if nNpcIndex == nil then
        Msg2Player("Nh薾 Ti猽 v藅 th蕋 b筰.");
        return 0;
    end
    -- npc index 非法
    if nNpcIndex <= 0 or GetNpcId(nNpcIndex) ~= dwNpcID then
        Msg2Player("Nh薾 Ti猽 v藅 th蕋 b筰.");
        return 0;
    end
    -- 
    local nSettingIdx = GetNpcSettingIdx(nNpcIndex);
    if (nSettingIdx ~= 2156) then       --%%%%
        Msg2Player("Nh薾 Ti猽 v藅 th蕋 b筰.");
        return 0;
    end
    -- 取出镖物等级
    local nLevel = GetNpcParam(nNpcIndex, 1);
    -- 背包空间判断
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return 0;
    end
    -- 给物品：先记任务变量再给物品
    pActivity:AddTaskDailyA(nTSK_DailyPickNum, 1);
    -- 给奖励
    local tbItemAward = pActivity.tbAward[nLevel];
    tbAwardTemplet:GiveAwardByRate(tbItemAward, "[Long M玭 Ti猽 C鬰-Nhi謒 v� 竝 Ti猽] Nh苩 v藅 ph萴 r琲 cp ti猽 nh薾 thng");
    local nCurCount = GetNpcParam(nNpcIndex, 2) + 1;
    SetNpcParam(nNpcIndex, 2, nCurCount);
    WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] T礽 kho秐: %s, Nh﹏ v藅: %s, ID nh苩 ti猽 v藅 [%s] r琲: %d", 
                GetAccount(), GetName(), GetNpcName(nNpcIndex), nCurCount));
    AddStatData("lmbj_treasure_get");
    -- 删除npc
    if (nCurCount >= pActivity.tbPickCountCell[nLevel][1]) then
        SetNpcParam(nNpcIndex, 6, 1);
        DelNpc(nNpcIndex);
    end
end

--入口函数
function main()
    --等级判断
    if PlayerFunLib:CheckTotalLevel(150, "Ch璦 t c蕄 150 v� ch璦 chuy觧 sinh kh玭g th� ti猽 v藅.", ">=") ~= 1 then
	    return nil;
    end
    -- 是否是白名玩家
    if (GetCamp() == 0) then
        Talk(1, "", "Чi hi謕 v蒼 ch璦 gia nh藀 m玭 ph竔, kh玭g th� nh薾 Ti猽 v藅 r韙 ra.");
        return nil;
    end
    local nNpcIndex = GetLastDiagNpc();
    -- 判断保护时间(3分钟)内最后一击玩家或队伍成员可捡 超出保护时间都可捡 待完成
    if CanPickBiaoWu(nNpcIndex) ~= 1 then
        Msg2Player("Hi謓 t筰 ngi kh玭g th� nh薾 Ti猽 v藅 n祔.");
        return nil;
    end
    -- 背包空间判断
    local nLevel = GetNpcParam(nNpcIndex, 1);
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return nil;
    end
    --当日采集数量判断
    if pActivity:GetTaskDailyA(TSK_DailyPickNum) >= 5 then
	    Msg2Player("M鏸 hi謕 s� m鏸 ng祔 t鑙 產 nh苩 5 l莕 ti猽 v藅, s� l莕 nh苩 h玬 nay c馻 hi謕 s�  t t鑙 產.")
	    return nil;
    end
    Msg2Player("B総 u nh薾 Ti猽 v藅");
    --进度条
    local dwNpcIndex = GetNpcId(nNpcIndex);
    tbProgressBar:OpenByConfig(4, %_GetAward, {nNpcIndex, dwNpcIndex}, %_OnBreak, {nNpcIndex});
end

function CanPickBiaoWu(nNpcIdx)
    local nPassTime = GetCurrentTime() - GetNpcParam(nNpcIdx, 3);
    if (nPassTime >= 180) then
        return 1;
    end
    local nHashValue = String2Id(GetName());
    local nHash1 = GetNpcParam(nNpcIdx, 4);
    local nHash2 = GetNpcParam(nNpcIdx, 5);
    -- 是最后一击玩家
    if (nHashValue == nHash1 + nHash2) then
        return 1;
    end
    -- 是否和最后一击玩家在一个队伍中
    local nOldPlayerIndex = PlayerIndex;
    local nResult = nil;
    local nTeamSize = GetTeamSize();
    for i = 1, nTeamSize do
        PlayerIndex = GetTeamMember(i);
        nHashValue = String2Id(GetName());
        if (nHashValue == nHash1 + nHash2) then
            nResult = 1;
            break;
        end
    end
    PlayerIndex = nOldPlayerIndex;
    return nResult;
end
