-- ÁúÃÅïÚ¾Ö»î¶¯ -- ïÚÆì°ó¶¨½Å±¾
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\activitysys\\playerfunlib.lua");

-- clear npc
function OnTimer(nNpcIndex, nTimeOut)
    DelNpc(nNpcIndex);
end

--Èë¿Úº¯Êý
function main()
    --µÈ¼¶ÅÐ¶Ï
    if PlayerFunLib:CheckTotalLevel(150, "Ch­a ®¹t cÊp 150 vµ ch­a chuyÓn sinh kh«ng thÓ nhÆt.", ">=") ~= 1 then
	    return nil;
    end
    -- È¡³öïÚÆìÐÅÏ¢
    local nNpcIndex = GetLastDiagNpc();
    local nSaveHash = GetNpcParam(nNpcIndex, 2) + GetNpcParam(nNpcIndex, 3);
    local nTaskTime = GetNpcParam(nNpcIndex, 4);
    local nHashValue = String2Id(GetName());
    local nCurTaskTime = GetTask(TSK_LMBJTaskTime);
    if (GetNpcParam(nNpcIndex, 5) == 1) then
        return nil;
    end
    -- ïÚÆìÊÇ·ñÊôÓÚ¸ÃÍæ¼Ò
    if (nHashValue ~= nSaveHash ) then
        Msg2Player("Ng­¬i kh«ng thÓ nhËn Tiªu Kú cña ng­êi kh¸c");
        return nil;
    end
    if (nTaskTime ~= nCurTaskTime) then
        SetNpcParam(nNpcIndex, 5, 1);
        DelNpc(nNpcIndex);
        return nil;
    end
    -- ÅÐ¶ÏÊÇ·ñ½ÓÈÎÎñ
    if (GetTask(TSK_LMBJTaskFlag) == 0) then
        SetNpcParam(nNpcIndex, 5, 1);
        DelNpc(nNpcIndex);
        return nil;
    end
    -- ±³°ü¿Õ¼äÅÐ¶Ï
    local nMincCells = 1;
    local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return nil;
    end
    local tbBiaoQiItem = {szName = "Tiªu Kú", tbProp = {6,1,4200,1,0,0}, nBindState = -2,};
    PlayerFunLib:GetItem(tbBiaoQiItem, 1, "[Ho¹t ®éng Long M«n Tiªu Côc] Tiªu Xa bÞ c­íp nhËn ®­îc Tiªu Kú");
    SetNpcParam(nNpcIndex, 5, 1);
    DelNpc(nNpcIndex);
end
