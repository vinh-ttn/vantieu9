-- ÁúÃÅïÚ¾Ö»î¶¯ -- ïÚ³µ±»½ÙºóµÄïÚÎï°ó¶¨½Å±¾
IncludeLib("LEAGUE")
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\activitysys\\g_activity.lua");
Include("\\script\\dailogsys\\g_dialog.lua");

Include("\\script\\lib\\progressbar.lua");
Include("\\script\\lib\\awardtemplet.lua");
Include("\\script\\activitysys\\playerfunlib.lua");

-- °ï»á¹±Ï×¶È´¦ÀíÎÄ¼þ
Include("\\script\\tong\\tong_award_head.lua")

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
    if GetNpcParam(nNpcIndex, 2) == 1 then
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
    -- ÅÐ¶ÏNPCÊÇ·ñÊÇ°ï»áïÚÎï±¦Ïä
    local nSettingIdx = GetNpcSettingIdx(nNpcIndex);
    if (nSettingIdx ~= nNpcTongBoxID) then
        Msg2Player("NhËn Tiªu vËt thÊt b¹i.");
        return 0;
    end
    -- È¡³öïÚÎïµÈ¼¶
    local nLevel = 10;
    -- ±³°ü¿Õ¼äÅÐ¶Ï
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return 0;
    end
    -- ¸ø½±Àø
    local nExpTime = getExpiredTime();
    local tbItemAward = {
        { szName = "R­¬ng Tiªu VËt Bang", tbProp = {6, 1, 4475, 1, 0, 0}, nBindState = -2, nExpiredTime = nExpTime,},
    }
    tbAwardTemplet:GiveAwardByList(tbItemAward, "[Long M«n Tiªu Côc_¸p Tiªu Bang] NhÆt R­¬ng Tiªu VËt Bang");
    local nCurCount = GetNpcParam(nNpcIndex, 1) + 1;
    SetNpcParam(nNpcIndex, 1, nCurCount);
    -- ·¢È«·þ¹«¸æ
    local szTongName = GetTongName();
    local szGlbNews = format("[%s] %s nhÆt 1 “R­¬ng Tiªu VËt Bang”", szTongName, GetName());
    LG_ApplyDoScript(1, "", "", "\\script\\event\\msg2allworld.lua", "battle_msg2allworld", szGlbNews , "", "");
    -- ÈÕÖ¾Âñµã
    AddStatData("bhyb_download_count");
    pActivity:WriteTongYBLog("NhÆt 1 R­¬ng Tiªu VËt Bang");
    -- É¾³ýnpc
    if (nCurCount >= pActivity.tbPickCountCell[nLevel][1]) then
        SetNpcParam(nNpcIndex, 2, 1);
        DelNpc(nNpcIndex);
    end
end

--Èë¿Úº¯Êý
function main()
    -- ÊÇ·ñ¼ÓÈëÁË°ï»á
    if CheckHasTong() ~= 1 then
        Talk(1, "", "Ch­a vµo bang, kh«ng thÓ nhÆt R­¬ng Tiªu Xa Bang.");
        return nil;
    end
    -- ¼ì²éÈë°ïÊ±¼ä
    if pActivity:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "Vµo bang ch­a ®ñ 7 ngµy, kh«ng thÓ nhÆt R­¬ng Tiªu Xa Bang.");
        return nil;
    end
    local nNpcIndex = GetLastDiagNpc();
    -- ÅÐ¶Ï±£»¤Ê±¼ä(3·ÖÖÓ)ÄÚ×îºóÒ»»÷Íæ¼Ò»ò¶ÓÎé³ÉÔ±¿É¼ñ ³¬³ö±£»¤Ê±¼ä¶¼¿É¼ñ ´ýÍê³É
    if CanPickBiaoWu(nNpcIndex) ~= 1 then
        Msg2Player("HiÖn kh«ng thÓ nhÆt R­¬ng Tiªu Xa Bang.");
        return nil;
    end
    -- ±³°ü¿Õ¼äÅÐ¶Ï
    local nLevel = 10;
    local nMincCells = pActivity.tbPickCountCell[nLevel][2];
    local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return nil;
    end
    Msg2Player("B¾t ®Çu nhÆt R­¬ng Tiªu Xa Bang.");
    --½ø¶ÈÌõ
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
    -- ÊÇ·ñÊÇËæºóÒ»»÷Íæ¼ÒµÄ°ï»á³ÉÔ±»òÕßÑºïÚÍæ¼Ò°ï»á³ÉÔ±
    local nSrcTongId = GetNpcParam(nNpcIdx, 5) + GetNpcParam(nNpcIdx, 6);
    local szTongName, nTongId = GetTongName();
    if (nTongId == nOwerTongId or nTongId == nSrcTongId) then
        return 1;
    end
    return 0;
end
