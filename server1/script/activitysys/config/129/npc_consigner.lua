-- °ó¶¨½Å±¾
IncludeLib("LEAGUE")
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\extend.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\global\\maplist.lua")
Include("\\script\\event\\longmenbiaoju\\head.lua")

pActivity.tbTongTask = {
    [80]    = {27, 28, 29, 27,},    -- ÑïÖİ
    [176]   = {30, 31, 32, 30,},    -- ÁÙ°²
    [37]    = {33, 34, 35, 36,},    -- ãê¾©
    [11]    = {37, 38, 39, 40,},    -- ³É¶¼
    [78]    = {41, 42, 41, 42,},    -- ÏåÑô
    [1]     = {44, 45, 46, 44,},    -- ·ïÏè
    [162]   = {47, 48, 49, 47,},    -- ´óÀí
}

function main()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        Talk(1, "", "Tr¸ng sÜ ch­a gia nhËp bang héi, kh«ng  thÓ tham gia ¸p tiªu");
        return nil;
    end
    pActivity:LogCurMapID();
    local nOccTongId = pActivity:GetOccupyTongId()
    if nTongId ~= nOccTongId then
        Talk(1, "", "Tiªu côc cã vËt phÈm quan träng cÇn rÊt nhiÒu ng­êi hé tèng, chóng t«i chØ tin vµo thùc lùc bang chiÕm lÜnh thµnh, kh«ng hîp t¸c víi ng­êi kh¸c, xin h·y vÒ cho.");
        return nil;
    end
    pActivity:ClickStartGuideMan();
end

-- µã»÷°ï»áÑºïÚ½ÓÒıÈË
function pActivity:ClickStartGuideMan()
    local szTitleMsg = "<npc>Tiªu côc cã vËt phÈm quan träng cÇn rÊt nhiÒu ng­êi hé tèng, chóng t«i chØ tin vµo thùc lùc cña quı bang, nÕu hé tiªu thµnh c«ng sÏ ®­îc hËu t¹! Ngoµi ra, ng­êi vËn tiªu cã thÓ dïng ®¹o cô ¸p tiªu c¸ nh©n.";
    local tbOpt = {};
    -- Ö»ÓĞ°ïÖ÷¿É¼û
    if CheckIsMaster() == 1 then
        tinsert(tbOpt, {"Më ¸p Tiªu Bang", self.OpenTongState, {self}});
    end
    -- °ïÖ÷ºÍ³¤ÀÏ¿É¼û
    if CheckIsElder() == 1 or CheckIsMaster() == 1 then
        tinsert(tbOpt, {"NhËn ¸p Tiªu Bang", self.RecvTongBiaoChe, {self}});
    end
    -- ÔËïÚÈË¿É¼û
    if self:IsTraner() == 1 then
        tinsert(tbOpt, {"Xem th«ng tin Tiªu Xa", self.ShowTongBiaoChe, {self}});
        tinsert(tbOpt, {"TruyÒn tèng ®Õn Tiªu Xa", self.GoToTongBiaoChe, {self}});
        tinsert(tbOpt, {"Tõ bá nhiÖm vô ¸p Tiªu Bang hiÖn t¹i", self.CancelTongTask, {self}});
    end
    tinsert(tbOpt, {"Rêi khái", });
    CreateNewSayEx(szTitleMsg, tbOpt);
end

function pActivity:OpenTongState()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return nil;
    end
    -- ¼ì²éÊÇ·ñÒÑ¾­¿ªÆô
    local nYaBiaoState = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE);
    if nYaBiaoState > 0 then
        Talk(1, "", "Ho¹t ®éng ¸p Tiªu cña bang trong tuÇn nµy ®· më.");
        return nil;
    end
    -- ¼ì²éÊÇ²»ÊÇÖÜÄ©
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "Kh«ng trong thêi gian më ¸p Tiªu Bang (12:00-23:00 Thø b¶y, Chñ nhËt).");
        return nil;
    end
    -- ¼ì²éÑºïÚÊ±¼ä
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Kh«ng trong thêi gian më ¸p Tiªu Bang (12:00-23:00 Thø b¶y, Chñ nhËt).");
        return nil;
    end
    -- ¼ì²éÕ¼³ÇÊıÁ¿
    local nOccCitys = self:GetTongWeekTaskValue(nTongId, TONG_TASK_OCCUPY_CITYS);
    local nCount = floor((nOccCitys+1)/2);
    if nCount <= 0 then
        Talk(1, "", "Sè thµnh chiÕm cña bang trong tuÇn kh«ng ®ñ ®Ó më ho¹t ®éng ¸p Tiªu.");
        return nil;
    end
    
    local szTitleMsg = "<npc>Sau khi më ¸p Tiªu Bang, ng­êi ch¬i trong bang tõ cÊp tr­ëng l·o trë lªn (gåm bang chñ) cã thÓ nhËn nhiÖm vô ¸p Tiªu Bang, mét khi nhËn nhiÖm vô sÏ lËp tøc më ®Õm ng­îc 30 phót.";
    local tbOpt = {};
    tinsert(tbOpt, {"§ång ı më", self.ConfirmOpenTongState, {self, nTongId, szTongName, nCount}});
    tinsert(tbOpt, {"§Ó ta suy nghÜ l¹i!",});
    CreateNewSayEx(szTitleMsg, tbOpt);
end

function pActivity:ConfirmOpenTongState(nTongId, szTongName, nCount)
    -- ¶ş´Î¼ì²éÊÇ²»ÊÇÖÜÄ©
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "Kh«ng trong thêi gian më ¸p Tiªu Bang (12:00-23:00 Thø b¶y, Chñ nhËt).");
        return nil;
    end
    -- ¶ş´Î¼ì²éÑºïÚÊ±¼ä
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Kh«ng trong thêi gian më ¸p Tiªu Bang (12:00-23:00 Thø b¶y, Chñ nhËt).");
        return nil;
    end
    -- ¶ş´ÎÈ·ÈÏÉí·İ
    if CheckIsMaster() ~= 1 then
        Talk(1, "", "ChØ bang chñ míi ®­îc më ¸p Tiªu Bang.");
        return nil;
    end
    -- ĞŞ¸Ä°ï»áÈÎÎñ±äÁ¿
    self:SetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE, 1);
    self:SetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT, nCount);
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_RAND, random(1, 4));
    local szName = GetName()
    Msg2Tong(nTongId, format("Bang chñ %s ®· më ¸p Tiªu Bang.", szName));

    -- ÈÕÖ¾
    self:WriteTongYBLog("§· më ¸p Tiªu Bang");
end

function pActivity:RecvTongBiaoChe()
    --µÈ¼¶ÅĞ¶Ï
    if PlayerFunLib:CheckTotalLevel(150, "Ch­a ®¹t cÊp 150 vµ ch­a chuyÓn sinh, kh«ng thÓ nhËn ¸p Tiªu Bang.", ">=") ~= 1 then
	    return nil;
    end
    -- ÓĞÃ»ÓĞ¿ªÆô°ï»áÑºïÚ
    local szTongName, nTongId = GetTongName();
    local nYaBiaoState = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE);
    if nYaBiaoState == 0 then
        Talk(1, "", "Bang kh«ng cã hoÆc ch­a më nhiÖm vô ¸p Tiªu cña tuÇn nµy, h·y mau liªn hÖ bang chñ ®Ó më.");
        return nil;
    end
    -- ¼ì²éÈë°ïÊ±¼ä
    if self:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "Vµo bang ch­a ®ñ 7 ngµy, kh«ng thÓ nhËn ¸p Tiªu Bang.");
        return nil;
    end
    -- ¼ì²éÊÇ²»ÊÇÖÜÄ©
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "ChØ thø b¶y hoÆc chñ nhËt trong tuÇn míi ®­îc nhËn ¸p Tiªu Bang.");
        return nil;
    end
    -- ¼ì²éÑºïÚÊ±¼ä
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Thêi gian nhËn ¸p Tiªu Bang lµ mçi cuèi tuÇn 12:00~23:00.");
        return nil;
    end
    
    -- ¼ì²éÍæ¼ÒÊÇ·ñÕıÔÚÑºïÚÈÎÎñ
    local data = LongMenBiaoJu:GetDataClass()
    if (GetTask(TSK_LMBJTaskFlag) ~= 0) or (data:GetType() ~= 0) then
        Talk(1, "", "Cã nhiÖm vô ¸p Tiªu ch­a hoµn thµnh, kh«ng thÓ nhËn ¸p Tiªu Bang.");
        return nil;
    end
    -- ¼ì²éÊÇ·ñÒÑ¾­ÓĞÈË¿ªÊ¼ÑºïÚÁË
    local nLastTime = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_TIME);
    local nNowTimes = GetCurrentTime();
    if nNowTimes - nLastTime < 1800 then
        Talk(1, "", "Bang ®· cã ng­êi nhËn nhiÖm vô ¸p Tiªu, h·y mau hç trî hé tèng Tiªu Xa.");
        return nil;
    end
    local nOccCitys = self:GetTongWeekTaskValue(nTongId, TONG_TASK_OCCUPY_CITYS);
    local nSumCount = floor((nOccCitys+1)/2);
    -- ¼ì²éµ±Ç°±¾°ï»¹ÓĞÃ»ÓĞÑºïÚÈÎÎñ
    local nCount = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT);
    if nCount <= 0 then
        Talk(1, "", format("TuÇn nµy quı bang ®· nhËn <color=yellow>%d<color> lÇn ¸p Tiªu Bang, chóng t«i ®· hÕt vËt phÈm cÇn vËn chuyÓn.", nSumCount));
        return nil;
    end
    -- ÅĞ¶ÏÍæ¼ÒÊÇ·ñÔÚÓëÆğµãNPC¶Ô»°
    local nMapID, nX, nY = GetWorldPos();
    if (GetTask(TSK_MapIDFlag) ~= nMapID) then
        return nil;
    end
    -- ÑºïÚÈÎÎñ
    local tbTask = self.tbTongTask[nMapID];
    if not tbTask then
        return nil;
    end
    local nRand = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_RAND);
    if nRand == 0 then
        nRand = random(1, 4);
        TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_RAND, nRand);
    end
    local nId = tbTask[nRand];
    local tbPath = self.tbBJPathLevel[nId][1]; -- ÑºïÚÂ·Ïß
    local nEid = tbPath[2];
    local szTitleMsg = format("<npc>TuÇn nµy quı bang ®· nhËn <color=yellow>%d/%d<color> lÇn ¸p Tiªu Bang, nhiÖm vô lÇn nµy ®Õm ng­îc 30 phót, diÓm cuèi lµ %s", nSumCount-nCount, nSumCount, self.tbBJPoints[nEid][1]);
    local tbOpt = {};
    tinsert(tbOpt, {"§ång ı nhËn", self.ConfirmRecvTongTask, {self, nTongId, nId}});
    tinsert(tbOpt, {"§Ó ta suy nghÜ l¹i!",});
    CreateNewSayEx(szTitleMsg, tbOpt);
    return 1;
end

function pActivity:ConfirmRecvTongTask(nTongId, nID)
    -- ¶ş´Î¼ì²éÊÇ²»ÊÇÖÜÄ©
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "ChØ thø b¶y hoÆc chñ nhËt trong tuÇn míi ®­îc nhËn ¸p Tiªu Bang.");
        return nil;
    end
    -- ¶ş´Î¼ì²éÈë°ïÊ±¼ä
    if self:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "Vµo bang ch­a ®ñ 7 ngµy, kh«ng thÓ nhËn ¸p Tiªu Bang.");
        return nil;
    end
    -- ¶ş´ÎÈ·ÈÏ¼ì²éÑºïÚÊ±¼ä
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Thêi gian nhËn ¸p Tiªu Bang lµ mçi cuèi tuÇn 12:00~23:00.");
        return nil;
    end
    -- ¶ş´ÎÈ·ÈÏÉí·İ
    if CheckIsElder() ~= 1 and CheckIsMaster() ~= 1 then
        Talk(1, "", "¸p Tiªu Bang ph¶i lµ tr­ëng l·o hoÆc bang chñ míi ®­îc nhËn, cÊp chøc vŞ cña b¹n ch­a ®ñ.");
        return nil;
    end
    -- ¶ş´Î¼ì²éÔÚ´ò¿ªÈ·ÈÏ¿òÆÚ¼äÊÇ·ñÒÑ¾­ÓĞÈË¿ªÊ¼ÑºïÚÁË
    local nLastTime = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_TIME);
    local nNowTimes = GetCurrentTime();
    if nNowTimes - nLastTime < 1800 then
        Talk(1, "", "Bang ®· cã ng­êi nhËn nhiÖm vô ¸p Tiªu, h·y mau hç trî hé tèng Tiªu Xa.");
        return nil;
    end
    local nOccCitys = self:GetTongWeekTaskValue(nTongId, TONG_TASK_OCCUPY_CITYS);
    local nSumCount = floor((nOccCitys+1)/2);
    -- ¶ş´Î¼ì²éµ±Ç°±¾°ï»¹ÓĞÃ»ÓĞÑºïÚÈÎÎñ
    local nCount = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT);
    if nCount <= 0 then
        Talk(1, "", format("TuÇn nµy quı bang ®· nhËn <color=yellow>%d<color> lÇn ¸p Tiªu Bang, chóng t«i ®· hÕt vËt phÈm cÇn vËn chuyÓn.", nSumCount));
        return nil;
    end
    -- ÅĞ¶ÏÍæ¼ÒÊÇ·ñÔÚÓëÆğµãNPC¶Ô»°
    local nMapID, nX, nY = GetWorldPos();
    if (GetTask(TSK_MapIDFlag) ~= nMapID) then
        return nil;
    end
    -- Ìõ¼şÅĞ¶Ï£ºÊÇ·ñÔ¶Àë°ï»áÑºïÚ½ÓÒıÈË
    local nNpcIndex = GetLastDiagNpc();
    local nX32, nY32 = GetNpcPos(nNpcIndex);
    if(abs(nX32-nX*32) > 600 or abs(nY32-nY*32) > 600) then
        Talk(1, "", "B¹n c¸ch xa TiÕp DÉn ¸p Tiªu Bang, kh«ng thÓ t¹o ra Tiªu Xa.");
        return nil;
    end
    -- ±£´æÈÎÎñ¿ªÊ¼Ê±¼äµ½°ï»áÈÎÎñ±äÁ¿
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_TIME, nNowTimes);
    -- ¸üĞÂ°ï»á±¾ÖÜÑºïÚ´ÎÊı
    self:AddTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT, -1);
    -- ¸üĞÂÏÂÒ»´Î½ÓïÚÂ·ÏßËæ»úÊı
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_RAND, random(1, 4));
    -- ¸üĞÂµ±Ç°°ï»áÑºïÚÈË½ÇÉ«ÃûHash´æµµ
    self:SetCurExecutorHash(nTongId, GetName());
    -- ¸öÈËÈÎÎñ±äÁ¿¸üĞÂ
    SetTask(TSK_LMBJTaskTime, nNowTimes);           -- ÈÎÎñ½ÓÈ¡Ê±¼ä
    SetTask(TSK_TransTongCarTime, nNowTimes);   -- ïÚ³µ´«ËÍÊ±¼ä
    SetTask(TSK_TransTongCarCD, 0);
    SetTask(TSK_ItemKMJBTime, 0);                   -- Çå³ıÊ¹ÓÃ¿ìÂí¼Ó±ŞÊ±¼ä
    SetTask(TSK_ItemJBKCTime, 0);                   -- Çå³ıÊ¹ÓÃ¼á²»¿É´İÊ±¼ä
    SetTask(TSK_ItemBCYWTime, 0);                   -- Çå³ıÊ¹ÓÃïÚ³µÒÆÎ»Ê±¼ä
    SetTask(TSK_LMBJTaskFlag, nID*10);              -- ±£´æ½ÓÈ¡µÄÑºïÚÈÎÎñ
    self:refreshBiaoChe(30*60);                     -- Ë¢³öïÚ³µ
    SetNpcParam(GetTask(TSK_LMBJCarIndex), 4, nNowTimes); -- ÉèÖÃïÚ³µµÄNPC²ÎÊı
    -- Ò»Ğ©ÌáÊ¾
    local tbPath = self.tbBJPathLevel[nID][1]; -- ÑºïÚÂ·Ïß
    local nSid, nEid = unpack(tbPath);
    local szSName = self.tbBJPoints[nSid][1];
    local szEName = self.tbBJPoints[nEid][1];
    Talk(1, "", format("Thµnh c«ng nhËn ¸p Tiªu Bang 10 Sao, ®iÓm ®Çu: %s-®iÓm cuèi %s, trong 30 phót ®Õn n¬i.", szSName, szEName));
    local szTongName = GetTongName();
    local szGlbNews = format("Bang <color=red>%s<color>-<color=green>%s<color> t¹i <color=red>%s<color> thµnh c«ng nhËn ¸p Tiªu Bang 10 Sao.", szTongName, GetName(), szSName);
    AddGlobalNews(szGlbNews);
    -- ·¢È«ÇøÈ«·ş×óÏÂ½Ç¹«¸æ
    LG_ApplyDoScript(1, "", "", "\\script\\event\\msg2allworld.lua", "battle_msg2allworld", szGlbNews , "", "");
    --°ï»á»îÔ¾¶ÈÏµÍ³ĞÂÔö£º°ï»á½ÓÈ¡°ï»áÑºïÚÈÎÎñ»ñµÃ»îÔ¾¶È
    --if nTongId > 0 then
    	--DynamicExecute("\\script\\tong\\tong_huoyuedu.lua", "tbTongHuoYueDu:BangHuiYaBiao", nTongId);
    --end
    -- ÈÕÖ¾Âñµã
    AddStatData("bhyb_accept_count");
    local szLogs = format("§· nhËn ¸p Tiªu Bang (%s#%s)", szSName, szEName);
    self:WriteTongYBLog(szLogs);
    return 1;
end

function pActivity:ShowTongBiaoChe()
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    -- ÅĞ¶Ïµ±Ç°ïÚ³µµÈ¼¶
    if nTaskFlagValue ~= 0 then
        local nId = floor(nTaskFlagValue/10);
        if self.tbBJPathLevel[nId][2] < 10 then
            Talk(1, "", "Ch­a nhËn ¸p Tiªu Bang.");
            return nil;
        end
    else
        Talk(1, "", "Ch­a nhËn ¸p Tiªu Bang.");
        return nil;
    end
    local nCurrentTime = GetCurrentTime();
    local nTaskTimeValue = GetTask(TSK_LMBJTaskTime);
    if nCurrentTime - nTaskTimeValue > 1800 then
        Talk(1, "", "NhiÖm vô ®· kÕt thóc, Tiªu Xa ®· biÕn mÊt.");
        return nil;
    end

    local handle = OB_Create();
    ObjBuffer:PushObject(handle, GetName());
    local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
    local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
    DynamicExecute(szLocalPath,
        "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetBiaoChePos", handle, 
        "pActivity:showTongBiaoCheCallBack", PlayerIndex);
    OB_Release(handle);
    return 1;
end

function pActivity:showTongBiaoCheCallBack(nParam, ResultHandle)
    local tbCurCarPos = {-1, 0, 0, 0};
    if (OB_IsEmpty(ResultHandle) ~= 1) then
        tbCurCarPos = ObjBuffer:PopObject(ResultHandle);
    end
    local nOldPlayerIndex = PlayerIndex;
    PlayerIndex = nParam;
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    local nId = floor(nTaskFlagValue/10);
    local tbPath = self.tbBJPathLevel[nId][1]; -- ÑºïÚÂ·Ïß
    local nSid, nEid = unpack(tbPath);
    local szTitleMsg = format("<npc>§· nhËn ¸p Tiªu Bang 10 Sao, %s-%s", self.tbBJPoints[nSid][1], self.tbBJPoints[nEid][1]);
    local szTempLine = "";
    -- ÈÎÎñ×´Ì¬
    if (tbCurCarPos==nil or tbCurCarPos[1]==-1) then -- ïÚ³µÏûÊ§
        szTempLine = "<enter>Tiªu Xa ®· biÕn mÊt, nhiÖm vô kÕt thóc.";
    else
        local nCurrentTime = GetCurrentTime();
        local nPassTime = nCurrentTime - GetTask(TSK_LMBJTaskTime);
        local nMapId, nX, nY = unpack(tbCurCarPos);
        local nMinTime = GetTask(TSK_TransTongCarTime) + GetTask(TSK_TransTongCarCD);
        local nTime = nMinTime - nCurrentTime;
        if nTime < 0 then
            nTime = 0;
        end
        szTempLine = format("<enter>§Õm ng­îc kho¶ng %d phót, Tiªu Xa Bang ®ang dõng t¹i %s(%d,%d)<enter>Thêi gian chê truyÒn tèng ®Õn Tiªu Xa Bang %d gi©y", 
            30-floor(nPassTime/60), tbGlobalMapId2Name[nMapId], floor(nX/8), floor(nY/16), nTime);
    end
    szTitleMsg = szTitleMsg..szTempLine;
    local tbOpt = {};
    tinsert(tbOpt, {" KÕt thóc ®èi tho¹i!", });
    CreateNewSayEx(szTitleMsg, tbOpt);
    PlayerIndex = nOldPlayerIndex;
end

function pActivity:GoToTongBiaoChe()
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    -- ÅĞ¶Ïµ±Ç°ïÚ³µµÈ¼¶
    if nTaskFlagValue ~= 0 then
        local nId = floor(nTaskFlagValue/10);
        if self.tbBJPathLevel[nId][2] < 10 then
            Talk(1, "", "Ch­a nhËn ¸p Tiªu Bang.");
            return nil;
        end
    else
        Talk(1, "", "Ch­a nhËn ¸p Tiªu Bang.");
        return nil;
    end
    local nCurrentTime = GetCurrentTime();
    local nTaskTimeValue = GetTask(TSK_LMBJTaskTime);
    if nCurrentTime - nTaskTimeValue > 1800 then
        Talk(1, "", "NhiÖm vô ®· kÕt thóc, Tiªu Xa ®· biÕn mÊt.");
        return nil;
    end
    -- ¼ì²é´«³µµÄCDÊ±¼ä
    local nCDTime = GetTask(TSK_TransTongCarCD);
    local nMinTimes = GetTask(TSK_TransTongCarTime) + nCDTime;
    if nCurrentTime < nMinTimes then
        Talk(1, "", format("VÉn ch­a v­ît qu¸ %d gi©y so víi lÇn truyÒn tèng tr­íc, ®îi mét chót.", nCDTime));
        return nil;
    end
    local handle = OB_Create();
    ObjBuffer:PushObject(handle, GetName());
    local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
    local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
    DynamicExecute(szLocalPath, 
        "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetBiaoChePos", handle, 
        "pActivity:gotoTongBiaoCheCallBack", PlayerIndex);
    OB_Release(handle);
end

function pActivity:gotoTongBiaoCheCallBack(nParam, ResultHandle)
    local tbCurCarPos = {-1, 0, 0, 0};
    if (OB_IsEmpty(ResultHandle) ~= 1) then
        tbCurCarPos = ObjBuffer:PopObject(ResultHandle);
    end
    local nOldPlayerIndex = PlayerIndex;
    PlayerIndex = nParam;
    if (tbCurCarPos==nil or tbCurCarPos[1]==-1) then
        Talk(1, "", "Tiªu Xa ®· bŞ ph¸ hñy hoÆc biÕn mÊt, kh«ng thÓ truyÒn tèng");
        PlayerIndex = nOldPlayerIndex;
        return nil;
    end
    -- ÉèÖÃ´«³µÊ±¼ä
    local nCurTime = GetCurrentTime();
    local nTaskValue = GetTask(TSK_TransTongCarTime);
    local nCDTime = GetTask(TSK_TransTongCarCD);
    if nCDTime < 60 then
        SetTask(TSK_TransTongCarCD, nCDTime+20);
    end
    SetTask(TSK_TransTongCarTime, nCurTime);
    -- ÉèÖÃÕ½¶·×´Ì¬
    SetFightState(tbCurCarPos[4]);
    NewWorld(tbCurCarPos[1], tbCurCarPos[2], tbCurCarPos[3]);
    PlayerIndex = nOldPlayerIndex;
end

-- ·ÅÆúÑºïÚÈÎÎñ
function pActivity:CancelTongTask()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return nil;
    end
    -- ¼ì²éÊÇ·ñÒÑ¾­¿ªÆô
    local nYaBiaoState = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE);
    if nYaBiaoState == 0 then
        Talk(1, "", "Ho¹t ®éng ¸p Tiªu cña bang trong tuÇn nµy ch­a më.");
        return nil;
    end
    -- ¼ì²éÑºïÚÊ±¼ä
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Kh«ng trong thêi gian më ¸p Tiªu Bang (12:00-23:00 Thø b¶y, Chñ nhËt).");
        return nil;
    end
    -- ¼ì²éÓĞÃ»ÓĞÕıÔÚ½øĞĞµÄÑºïÚÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    -- ÅĞ¶Ïµ±Ç°ïÚ³µµÈ¼¶
    if nTaskFlagValue ~= 0 then
        local nId = floor(nTaskFlagValue/10);
        if self.tbBJPathLevel[nId][2] < 10 then
            Talk(1, "", "Ch­a nhËn ¸p Tiªu Bang.");
            return nil;
        end
    else
        Talk(1, "", "Ch­a nhËn ¸p Tiªu Bang.");
        return nil;
    end
    -- ²éÑ¯ïÚ³µÎ»ÖÃ£¬ÓĞïÚ³µ²»ÄÜ·ÅÆúÈÎÎñ
    local handle = OB_Create();
    ObjBuffer:PushObject(handle, GetName());
    local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
    local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
    DynamicExecute(szLocalPath, 
        "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetBiaoChePos", handle, 
        "pActivity:CancelTongTaskCallBack", PlayerIndex);
    OB_Release(handle);
end

function pActivity:CancelTongTaskCallBack(nParam, ResultHandle)
    local tbCurCarPos = {-1, 0, 0, 0};
    if (OB_IsEmpty(ResultHandle) ~= 1) then
        tbCurCarPos = ObjBuffer:PopObject(ResultHandle);
    end
    local nOldPlayerIndex = PlayerIndex;
    PlayerIndex = nParam;
    if (tbCurCarPos==nil or tbCurCarPos[1]==-1) then
        local szTitleMsg = "Tiªu Xa Bang ®· bŞ hñy hoÆc biÕn mÊt, ®ång ı kÕt thóc nhiÖm vô ¸p Tiªu lÇn nµy?";
        local tbOpt = {};
        tinsert(tbOpt, {"§ång ı kÕt thóc nhiÖm vô", self.ConfirmCancelTongTask, {self}});
        tinsert(tbOpt, {"§Ó ta suy nghÜ l¹i!",});
        CreateNewSayEx(szTitleMsg, tbOpt);
        PlayerIndex = nOldPlayerIndex;
        return nil;
    end

    local nMapId, nX, nY = unpack(tbCurCarPos);
    szTempLine = format("Tiªu Xa Bang ®ang dõng ë %s(%d,%d), kh«ng thÓ bá nhiÖm vô ¸p Tiªu.", 
                        tbGlobalMapId2Name[nMapId], floor(nX/8), floor(nY/16));
    Talk(1, "", szTempLine);
    PlayerIndex = nOldPlayerIndex;
    return 1;
end

function pActivity:ConfirmCancelTongTask()
    local szTongName, nTongId = GetTongName();
    SetTask(TSK_LMBJTaskFlag, 0);
    if nTongId == 0 then
        return nil;
    end
    local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
    -- ÈÎÎñ»¹Ã»ÓĞ³¬¹ı30·ÖÖÓ£¬Ö±½ÓÉ¾³ıÏàÓ¦ÈÎÎñ±äÁ¿
    if nPassTime < 1800 then
        TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_TIME, 0);
    else
        local dwNameHash = String2Id(GetName());
        if self:GetCurExecutorHash(nTongId) == dwNameHash then
            TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_TIME, 0);
        end
    end
    Talk(1, "", "¸p Tiªu Bang lÇn nµy ®· hñy.");
    -- ÈÕÖ¾
    self:WriteTongYBLog("¸p Tiªu Bang ®· kÕt thóc");
end
