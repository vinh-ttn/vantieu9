-- 龙门镖局活动 -- 镖车被劫后的镖物绑定脚本
IncludeLib("LEAGUE")
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\activitysys\\g_activity.lua");
Include("\\script\\dailogsys\\g_dialog.lua");

Include("\\script\\lib\\progressbar.lua");
Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\activitysys\\playerfunlib.lua");

-- 帮会贡献度处理文件
Include("\\script\\tong\\tong_award_head.lua")

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
    if GetNpcParam(nNpcIndex, 2) == 1 then
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
    -- 判断NPC是否是帮会镖物宝箱
    local nSettingIdx = GetNpcSettingIdx(nNpcIndex);
    if (nSettingIdx ~= nNpcTongBoxID) then
        Msg2Player("Nh薾 Ti猽 v藅 th蕋 b筰.");
        return 0;
    end
    -- 取出镖物等级
    local nLevel = 10;
    -- 背包空间判断
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return 0;
    end
    -- 给奖励
    local nExpTime = getExpiredTime();
    local tbItemAward = {
        { szName = "Rng Ti猽 V藅 Bang", tbProp = {6, 1, 4475, 1, 0, 0}, nBindState = -2, nExpiredTime = nExpTime,},
    }
    tbAwardTemplet:GiveAwardByList(tbItemAward, "[Long M玭 Ti猽 C鬰_竝 Ti猽 Bang] Nh苩 Rng Ti猽 V藅 Bang");
    local nCurCount = GetNpcParam(nNpcIndex, 1) + 1;
    SetNpcParam(nNpcIndex, 1, nCurCount);
    -- 发全服公告
    local szTongName = GetTongName();
    local szGlbNews = format("[%s] %s nh苩 1 揜ng Ti猽 V藅 Bang�", szTongName, GetName());
    LG_ApplyDoScript(1, "", "", "\\script\\event\\msg2allworld.lua", "battle_msg2allworld", szGlbNews , "", "");
    -- 日志埋点
    AddStatData("bhyb_download_count");
    pActivity:WriteTongYBLog("Nh苩 1 Rng Ti猽 V藅 Bang");
    -- 删除npc
    if (nCurCount >= pActivity.tbPickCountCell[nLevel][1]) then
        SetNpcParam(nNpcIndex, 2, 1);
        DelNpc(nNpcIndex);
    end
end

--入口函数
function main()
    -- 是否加入了帮会
    if CheckHasTong() ~= 1 then
        Talk(1, "", "Ch璦 v祇 bang, kh玭g th� nh苩 Rng Ti猽 Xa Bang.");
        return nil;
    end
    -- 检查入帮时间
    if pActivity:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "V祇 bang ch璦  7 ng祔, kh玭g th� nh苩 Rng Ti猽 Xa Bang.");
        return nil;
    end
    local nNpcIndex = GetLastDiagNpc();
    -- 判断保护时间(3分钟)内最后一击玩家或队伍成员可捡 超出保护时间都可捡 待完成
    if CanPickBiaoWu(nNpcIndex) ~= 1 then
        Msg2Player("Hi謓 kh玭g th� nh苩 Rng Ti猽 Xa Bang.");
        return nil;
    end
    -- 背包空间判断
    local nLevel = 10;
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return nil;
    end
    Msg2Player("B総 u nh苩 Rng Ti猽 Xa Bang.");
    --进度条
    local dwNpcIndex = GetNpcId(nNpcIndex);
    tbProgressBar:OpenByConfig(4, %_GetAward, {nNpcIndex, dwNpcIndex}, %_OnBreak, {nNpcIndex});
end

function CanPickBiaoWu(nNpcIdx)
    local nPassTime = GetCurrentTime() - GetNpcParam(nNpcIdx, 2);
    if (nPassTime >= 180) then
        return 1;
    end
    local nOwerTongId = GetNpcParam(nNpcIdx, 3) + GetNpcParam(nNpcIdx, 4);
    if nOwerTongId == 0 then
        return 1;
    end
    -- 是否是随后一击玩家的帮会成员或者押镖玩家帮会成员
    local nSrcTongId = GetNpcParam(nNpcIdx, 5) + GetNpcParam(nNpcIdx, 6);
    local szTongName, nTongId = GetTongName();
    if (nTongId == nOwerTongId or nTongId == nSrcTongId) then
        return 1;
    end
    return 0;
end
