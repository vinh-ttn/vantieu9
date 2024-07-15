-- °ó¶¨½Å±¾

Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\extend.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\global\\maplist.lua")

function main()
    if CheckHasTong() ~= 1 then
        Talk(1, "", "HiÖp sÜ sao kh«ng vµo bang tham gia hé tiªu?");
        return nil;
    end
    pActivity:ClickEndGuideMan();
end

-- µã»÷°ï»áÑºïÚÊÕ»õÈË
function pActivity:ClickEndGuideMan()
    local szTitleMsg = "<npc>Tiªu vËt cña chóng t«i ®· an toµn ®Õn n¬i? Khi giao nhiÖm vô Tiªu Xa Bang ph¶i ë xung quanh ta. Sau khi hoµn thµnh nhiÖm vô, bang chóng hé tiªu cã thÓ ®Õn chç ta nhËn th­ëng c¸ nh©n.";
    local tbOpt = {};
    -- ÔËïÚÈË¿É¼û
    if self:IsTraner() == 1 then
        tinsert(tbOpt, {"Giao Tiªu Xa Bang", self.HandTongBiaoChe, {self}});
    end
    tinsert(tbOpt, {"NhËn phÇn th­ëng hé tiªu c¸ nh©n", self.GetConvoyAward, {self}});
    tinsert(tbOpt, {"Rêi khái", });
    CreateNewSayEx(szTitleMsg, tbOpt);
end

function pActivity:HandTongBiaoChe()
    -- ÅÐ¶ÏÓÐÃ»ÓÐ½ÓÑºïÚÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if nTaskFlagValue == 0 then
        Talk(1, "", "Ch­a nhËn nhiÖm vô ¸p Tiªu, kh«ng thÓ nhËn th­ëng.");
        return nil;
    end
    -- ÅÐ¶ÏÈÎÎñµÈ¼¶
    local nId = floor(nTaskFlagValue/10); -- ÑºïÚÂ·ÏßID
    local tbPath = self.tbBJPathLevel[nId][1]; -- ÑºïÚÂ·Ïß
    local nLevel = self.tbBJPathLevel[nId][2]; -- ÑºïÚµÈ¼¶
    if nLevel < 10 then
        Talk(1, "", "Kh«ng ph¶i Tiªu Xa Bang.");
        return nil;
    end
    local nMapId, nX, nY = GetWorldPos();
    local nEPosId = tbPath[2];                  -- ÑºïÚÂ·ÏßµÄÖÕµãID
    local tbPos = self.tbBJPoints[nEPosId][2];  -- ÖÕµãïÚÊ¦×ø±ê
    -- ÅÐ¶Ïµ±Ç°ÊÕ»õÈËÊÇ²»ÊÇÈÎÎñÖ¸¶¨ÊÕ»õÈË
    local nNpcIndex = GetLastDiagNpc();
    local nX32, nY32, nMapIdx = GetNpcPos(nNpcIndex);
    if ((nMapId) ~= tbPos[1] or (nX32 ~= tbPos[2]*32) or (nY32 ~= tbPos[3]*32)) then
        Talk(1, "", "§¹i hiÖp ®· nhÇm lÉn, xin h·y xem kü vÞ trÝ NPC ®iÓm cuèi cña ¸p Tiªu Bang.");
        return nil;
    end
    -- ÅÐ¶ÏïÚ³µÊÇ·ñ»¹ÔÚ
    if IsBiaoCheAlive() ~= 1 then
        Talk(1, "", "Quý bang ®· kh«ng thÓ b¶o vÖ Tiªu Xa, h·y cè g¾ng h¬n ë lÇn sau!");
        return nil;
    end
    -- ÅÐ¶ÏïÚ³µÊÇ·ñÔÚNPC¸½½ü
    local nPX32, nPY32, nPMapIdx = self:getCurrentCarPos();
    if (sqrt((nX32-nPX32)*(nX32-nPX32) + (nY32-nPY32)*(nY32-nPY32)) > 600) then
        Talk(1, "", "Tiªu Xa kh«ng cã ë bªn c¹nh, mau ®i t×m xem.");
        return nil;
    end
    local tbCountCell = self.tbAllCountCell[10];
    local nExpTime = getExpiredTime();
    local tbAwardList = {
        { szName = "R­¬ng Tiªu VËt Bang", tbProp = {6,1,4475,1,0,0}, nBindState = -2, nExpiredTime = nExpTime,},
    }
    -- ¼ì²é±³°ü¿Õ¼ä
    local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", tbCountCell[2]);
    if PlayerFunLib:CheckFreeBagCell(tbCountCell[2], szTips) ~= 1 then
        return nil;
    end
    -- É¾³ýïÚ³µ
    DeleteBiaoChe();
    -- ÐÞ¸ÄÑºïÚ±ê¼Ç±äÁ¿
    SetTask(TSK_LMBJTaskFlag, 0);
    local _, nTongId = GetTongName();
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_TIME, 0);
    -- ¸ø½±Àø
    tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M«n Tiªu Côc_¸p Tiªu Bang] ¸p tiªu thµnh c«ng nhËn toµn bé th­ëng.", tbCountCell[1]);
    Talk(1, "", "Quü bang dòng m·nh, thuËn lîi hoµn thµnh ¸p Tiªu Bang lÇn nµy.");
    -- ÈÕÖ¾
    AddStatData("bhyb_success_count");
    local szLogs = format("Thµnh c«ng hoµn thµnh ¸p Tiªu Bang, bang nhËn ®­îc R­¬ng Tiªu VËt Bang #%d#", tbCountCell[1]);
    self:WriteTongYBLog(szLogs);
    return 1;
end

function pActivity:getAward(nCount)
    local tbItem = {}
    if nCount < 5 then
        tbItem = { szName = "CÈm nang thay ®æi trêi ®Êt", tbProp = {6,1,2527,1,0,0}, nBindState = -2, tbParam={0}, nExpiredTime = 43200,
            CallBack = function(nItemIndex) AddStatData("bhyb_followaward1_count"); end,};
    elseif nCount >= 5 and nCount < 12 then
        tbItem = { szName = "Th­ëng TËn Trung", tbProp = {6,1,4473,1,0,0}, nBindState = -2, nExpiredTime = 10080,
            CallBack = function(nItemIndex) AddStatData("bhyb_followaward2_count"); end,};
    elseif nCount >= 12 then
        tbItem = { szName = "Th­ëng Trung Thµnh", tbProp = {6,1,4474,1,0,0}, nBindState = -2, nExpiredTime = 10080,
            CallBack = function(nItemIndex) AddStatData("bhyb_followaward3_count"); end,};
    end
    return tbItem;
end

function pActivity:GetConvoyAward()
    -- ¼ì²éÈë°ïÊ±¼ä
    if self:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "Vµo bang ch­a ®ñ 7 ngµy, kh«ng thÓ nhËn th­ëng hé tiªu c¸ nh©n.");
        return nil;
    end
    local tbAwardList = {};
    local nAward = 0;
    for i = 0, 3 do
        local nTaskValue = self:GetFollowAwardCount(TSK_WeekFollowCount + i);
        if nTaskValue > 0 then
            nAward = nAward + 1;
            tbAward = self:getAward(nTaskValue);
            tinsert(tbAwardList, tbAward);
        end
    end
    if nAward == 0 then
        Talk(1, "", "Ch­a tÝch cùc tham gia hµnh ®éng hé tiªu bang lÇn nµy, kh«ng thÓ nhËn th­ëng.");
        return nil;
    end
    -- ¼ì²é°ï»áÊÇ²»ÊÇÕýÔÚÑºïÚ
    local _, nTongId = GetTongName();
    local nLastTime = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_TIME);
    local nNowTimes = GetCurrentTime();
    if nNowTimes - nLastTime < 1800 then
        Talk(1, "", "Quý bang ch­a hoµn thµnh ¸p Tiªu Bang lÇn nµy, kh«ng thÓ nhËn th­ëng hé tiªu.");
        return nil;
    end
    -- ¼ì²é±³°ü¿Õ¼ä
    local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", nAward);
    if PlayerFunLib:CheckFreeBagCell(nAward, szTips) ~= 1 then
        return nil;
    end
    -- ÇåÈÎÎñ±äÁ¿
    self:ClearFollowAwardCount();
    -- ¸ø½±Àø
    tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M«n Tiªu Côc_¸p Tiªu Bang] §Õn NhËn Hµng ¸p Tiªu Bang ®Ó nhËn phÇn th­ëng hé tiªu");
    -- ÈÕÖ¾
    local szLogs = format("NhËn %d th­ëng c¸ nh©n ¸p Tiªu Bang", nAward);
    self:WriteTongYBLog(szLogs);
end

