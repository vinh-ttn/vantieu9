-- ÁúÃÅïÚ¾Ö»î¶¯ -- ïÚ³µ±»½ÙºóµÄïÚÎï°ó¶¨½Å±¾
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
	Msg2Player("Qu¸ tr×nh nhËn Tiªu vËt bÞ ®øt ®o¹n råi.");
	return 0;
end

-- process
local _GetAward = function(nNpcIndex, dwNpcID)
    local nTSK_DailyPickNum = 3501;
    if GetNpcParam(nNpcIndex, 6) == 1 then
        return nil;
    end
    -- npc index ·Ç·¨
    if nNpcIndex == nil then
        Msg2Player("NhËn Tiªu vËt thÊt b¹i.");
        return 0;
    end
    -- npc index ·Ç·¨
    if nNpcIndex <= 0 or GetNpcId(nNpcIndex) ~= dwNpcID then
        Msg2Player("NhËn Tiªu vËt thÊt b¹i.");
        return 0;
    end
    -- 
    local nSettingIdx = GetNpcSettingIdx(nNpcIndex);
    if (nSettingIdx ~= 2156) then       --%%%%
        Msg2Player("NhËn Tiªu vËt thÊt b¹i.");
        return 0;
    end
    -- È¡³öïÚÎïµÈ¼¶
    local nLevel = GetNpcParam(nNpcIndex, 1);
    -- ±³°ü¿Õ¼äÅÐ¶Ï
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return 0;
    end
    -- ¸øÎïÆ·£ºÏÈ¼ÇÈÎÎñ±äÁ¿ÔÙ¸øÎïÆ·
    pActivity:AddTaskDailyA(nTSK_DailyPickNum, 1);
    -- ¸ø½±Àø
    local tbItemAward = pActivity.tbAward[nLevel];
    tbAwardTemplet:GiveAwardByRate(tbItemAward, "[Long M«n Tiªu Côc-NhiÖm vô ¸p Tiªu] NhÆt vËt phÈm r¬i c­íp tiªu nhËn th­ëng");
    local nCurCount = GetNpcParam(nNpcIndex, 2) + 1;
    SetNpcParam(nNpcIndex, 2, nCurCount);
    WriteYunBiaoLog(format("[Long M«n Tiªu Côc] Tµi kho¶n: %s, Nh©n vËt: %s, ID nhÆt tiªu vËt [%s] r¬i: %d", 
                GetAccount(), GetName(), GetNpcName(nNpcIndex), nCurCount));
    AddStatData("lmbj_treasure_get");
    -- É¾³ýnpc
    if (nCurCount >= pActivity.tbPickCountCell[nLevel][1]) then
        SetNpcParam(nNpcIndex, 6, 1);
        DelNpc(nNpcIndex);
    end
end

--Èë¿Úº¯Êý
function main()
    --µÈ¼¶ÅÐ¶Ï
    if PlayerFunLib:CheckTotalLevel(150, "Ch­a ®¹t cÊp 150 vµ ch­a chuyÓn sinh kh«ng thÓ tiªu vËt.", ">=") ~= 1 then
	    return nil;
    end
    -- ÊÇ·ñÊÇ°×ÃûÍæ¼Ò
    if (GetCamp() == 0) then
        Talk(1, "", "§¹i hiÖp vÉn ch­a gia nhËp m«n ph¸i, kh«ng thÓ nhËn Tiªu vËt rít ra.");
        return nil;
    end
    local nNpcIndex = GetLastDiagNpc();
    -- ÅÐ¶Ï±£»¤Ê±¼ä(3·ÖÖÓ)ÄÚ×îºóÒ»»÷Íæ¼Ò»ò¶ÓÎé³ÉÔ±¿É¼ñ ³¬³ö±£»¤Ê±¼ä¶¼¿É¼ñ ´ýÍê³É
    if CanPickBiaoWu(nNpcIndex) ~= 1 then
        Msg2Player("HiÖn t¹i ng­¬i kh«ng thÓ nhËn Tiªu vËt nµy.");
        return nil;
    end
    -- ±³°ü¿Õ¼äÅÐ¶Ï
    local nLevel = GetNpcParam(nNpcIndex, 1);
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return nil;
    end
    --µ±ÈÕ²É¼¯ÊýÁ¿ÅÐ¶Ï
    if pActivity:GetTaskDailyA(TSK_DailyPickNum) >= 5 then
	    Msg2Player("Mçi hiÖp sÜ mçi ngµy tèi ®a nhÆt 5 lÇn tiªu vËt, sè lÇn nhÆt h«m nay cña hiÖp sÜ ®· ®¹t tèi ®a.")
	    return nil;
    end
    Msg2Player("B¾t ®Çu nhËn Tiªu vËt");
    --½ø¶ÈÌõ
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
    -- ÊÇ×îºóÒ»»÷Íæ¼Ò
    if (nHashValue == nHash1 + nHash2) then
        return 1;
    end
    -- ÊÇ·ñºÍ×îºóÒ»»÷Íæ¼ÒÔÚÒ»¸ö¶ÓÎéÖÐ
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
