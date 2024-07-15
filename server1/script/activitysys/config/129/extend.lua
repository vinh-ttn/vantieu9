-- Include Files
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\global\\maplist.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\objbuffer_head.lua")
Include("\\script\\dailogsys\\dailogsay.lua")

Include("\\script\\activitysys\\npcfunlib.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

-- °ï»á¹±Ï×¶È´¦ÀíÎÄ¼þ
Include("\\script\\tong\\tong_award_head.lua")

IncludeLib("TIMER")

pActivity.nPak = curpack();

-- ÕâÀïÐÞ¸Ä ¼ÇµÃÍ¬²½ÐÞ¸Ä \\script\\global\\yunbiao_system.lua OnBiaoCheChangeMapNotice ÖÐ¶ÔÓ¦µÄ tbBiaoCheLevel
pActivity.tbBJPathLevel = {
	[1] = {{ 1, 2}, 1,},
	[2] = {{ 3, 4}, 2,},
	[3] = {{ 5, 6}, 2,},
	[4] = {{ 7, 6}, 2,},
	[5] = {{ 8, 9}, 2,},
	[6] = {{10,11}, 2,},
	[7] = {{12,13}, 2,},
	[8] = {{ 7, 5}, 3,},
	[9] = {{ 1,14}, 3,},
	[10] = {{12, 5}, 4,},
	[11] = {{12, 6}, 4,},
	[12] = {{12, 5}, 5,},
	[13] = {{12, 6}, 5,},
	[14] = {{10, 3}, 5,},
	[15] = {{ 5,13}, 5,},
	[16] = {{ 5,13}, 6,},
	[17] = {{10, 4}, 6,},
	[18] = {{ 3,11}, 6,},
	[19] = {{10, 4}, 7,},
	[20] = {{ 3,11}, 7,},
	[21] = {{ 7,12}, 7,},
	[22] = {{ 6,13}, 7,},
	[23] = {{ 7,12}, 8,},
	[24] = {{ 6,13}, 8,},
	[25] = {{10, 5}, 8,},
	[26] = {{10, 5}, 9,},
    -- °ï»áÑºïÚ
    -- ÑïÖÝ
	[27] = {{15, 16}, 10,},
	[28] = {{15, 17}, 10,},
	[29] = {{15, 18}, 10,},
    -- ÁÙ°²
	[30] = {{19, 20}, 10,},
	[31] = {{19, 21}, 10,},
	[32] = {{19, 22}, 10,},
	-- ãê¾©
    [33] = {{23, 24}, 10,},
	[34] = {{23, 25}, 10,},
	[35] = {{23, 26}, 10,},
	[36] = {{23, 27}, 10,},
    -- ³É¶¼
    [37] = {{28, 29}, 10,},
	[38] = {{28, 30}, 10,},
	[39] = {{28, 31}, 10,},
	[40] = {{28, 32}, 10,},
    -- ÏåÑô
    [41] = {{33, 34}, 10,},
	[42] = {{33, 35}, 10,},
	[43] = {{33, 36}, 10,},
    -- ·ïÏè
	[44] = {{37, 38}, 10,},
	[45] = {{37, 39}, 10,},
	[46] = {{37, 40}, 10,},
    -- ´óÀí
	[47] = {{41, 42}, 10,},
	[48] = {{41, 43}, 10,},
	[49] = {{41, 44}, 10,},
}
pActivity.tbAllTask = {
        {nRate = 0,        tbID = {1} },            --1ÐÇ ²»²ÎÓëËæ»ú£¬Õ¼Î»ÓÃ
        {nRate = 0.149,    tbID = {2,3,4,5,6,7,}},  --2ÐÇ
        {nRate = 0.3,      tbID = {8,9,}},          --3ÐÇ
        {nRate = 0.3,      tbID = {10,11,}},        --4ÐÇ
        {nRate = 0.15,     tbID = {12,13,14,15,}},  --5ÐÇ
        {nRate = 0.05,     tbID = {16,17,18,}},     --6ÐÇ
        {nRate = 0.04,     tbID = {19,20,21,22,}},  --7ÐÇ
        {nRate = 0.01,     tbID = {23,24,25,}},     --8ÐÇ
        {nRate = 0.001,    tbID = {26,}},           --9ÐÇ
    }

pActivity.tbBJPoints = {
	[1] = {"L©m An Nam (181,208)", {176, 1448, 3335},},
	[2] = {"L©m An B¾c (191,185)", {176, 1534, 2974},},
	[3] = {"Thµnh §« (382,312)", {11, 3061, 4992},},
	[4] = {"Th«n Giang T©n (439,385)", {20, 3516, 6164},},
	[5] = {"T­¬ng D­¬ng (192,198)", {78, 1537, 3182},},
	[6] = {"§¹o H­¬ng Th«n (203,200)", {101, 1625, 3209},},
	[7] = {"D­¬ng Ch©u (223,189)", {80, 1786, 3037},},
	[8] = {"§¹i Lý (204,200)", {162, 1639, 3215},},
	[9] = {"Th¹ch Cæ TrÊn (209,202)", {153, 1677, 3240},},
	[10] = {"Ph­îng T­êng (199,193)", {1, 1597, 3093},},
	[11] = {"VÜnh L¹c TrÊn (209,201)", {99, 1673, 3229},},
	[12] = {"BiÖn Kinh (211,196)", {37, 1690, 3150},},
	[13] = {"Chu Tiªn TrÊn (202,194)", {100, 1622, 3113},},
	[14] = {"Th«n Long TuyÒn (199,204)", {174, 1596, 3271},},
    -- °ï»áÑºïÚ
    [15] = {" D­¬ng Ch©u", {80,1678,3147},},
    [16] = {"T­êng V©n §éng", {116,1741,3031},},
    [17] = {"TiÕn Cóc ®éng", {93, 1620,3182},},
    [18] = {"Linh Cèc ®éng", {94, 1638,3106},},
    
    [19] = {" L©m An", {176,1399,3140},},
    [20] = {"L­ìng Thñy §éng", {181,1627,3052},},
    [21] = {"Long Cung §éng", {180,1548,3176},},
    [22] = {"NghiÖt Long §éng", {182,2107,3412},},
    
    [23] = {" BiÖn Kinh", {37,1703,3019},},
    [24] = {"Thiªn T©m ®éng", { 42,1642,3029},},
    [25] = {"Thiªn NhÉn Gi¸o", { 45,1702,3076},},
    [26] = {"Phi Thiªn ®éng", {204,1621,3375},},
    [27] = {"ThiÕu L©m ph¸i", {103,1638,2930},},
    
    [28] = {" Thµnh §«", {11,3205,5078},},
    [29] = {"Nh¹n Th¹ch ®éng", { 10,1778,3065},},
    [30] = {"ThÇn Tiªn ®éng", { 23,1854,3123},},
    [31] = {"B¹ch V©n ®éng", { 22,1865,3274},},
    [32] = {"§éng Kinh Hoµng", {  5,1597,3592},},

    [33] = {" T­¬ng D­¬ng", {78,1569,3280},},
    [34] = {"Kª Qu¸n ®éng", { 91,1602,2810},},
    [35] = {"Kháa Lang §éng", { 83,1660,2924},},
    [36] = {"D­¬ng Trung ®éng", {205,1587,3221},},

    [37] = {" Ph­îng T­êng", {1,1559,3258},},
    [38] = {"B¨ng Hµ ®éng", {201,1736,3235},},
    [39] = {  " Hoa S¬n", {  2,2406,3713},},
    [40] = {"§éng Kim Quang", {  4,1672,3096},},
    
    [41] = {" §¹i Lý ", {162,1650,3247},},
    [42] = {"Phông Nh·n §éng", {168,1653,3138},},
    [43] = {"§iÓm Th­¬ng §éng", {171,1494,2982},},
    [44] = {"V« Danh ®éng", {203,1505,3102},},
}

pActivity.nTaskGuideId = 14 --ÔÚ\settings\task\taskguide.txtÅäÖÃÎÄ¼þÖÐµÄÎ¨Ò»id
pActivity.nTaskGuideType = 2 --ÔÚÈÎÎñÖ¸ÄÏÏµÍ³ÖÐÊôÓÚÈÕ³£ÈÎÎñ

-- ·þÎñÆ÷Æô¶¯ÊÂ¼þ
function pActivity:ServerStartCall()

end

-- Íæ¼Ò¿ç·þµÇÂ½ÊÂ¼þ
function pActivity:PlayerExchageServerLoginInit()
    -- ¼ì²éÈÎÎñ±äÁ¿
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        --Talk(1, "", "ÏÀÊ¿Ã»ÓÐ½ÓÊÜÑºïÚÈÎÎñ£¬ÔõÃ´ÄÜÁìÈ¡½±ÀøÄØ£¿");
        return nil;
    end
    -- È¡±ê¼Ç
    if (GetTask(TSK_RefreshBiaoChe) == 0) then
        return nil;
    end
    -- Ë¢³öïÚ³µ
    local nSuriveTime = 1800 - (GetCurrentTime() - GetTask(TSK_LMBJTaskTime));
    if (nSuriveTime <= 0) then
        return nil;
    end
    self:refreshBiaoChe(nSuriveTime);
    -- ÉèÖÃïÚ³µÑªÁ¿
    local nCurCarIndex = GetTask(TSK_LMBJCarIndex);
    if (nCurCarIndex <= 0) then
        return nil;
    end
    SetNpcParam(nCurCarIndex, 4, GetTask(TSK_LMBJTaskTime));
    SetNpcCurLife(nCurCarIndex, GetTask(TSK_BiaoCheLife));
    DynamicExecuteByPlayer(PlayerIndex, "\\script\\global\\yunbiao_system.lua", "OnBiaoCheChangeMapNotice");
    -- Çå³ý¿ç·þË¢³µ±ê¼Ç
    SetTask(TSK_RefreshBiaoChe, 0);
end

-- Íæ¼Ò¿ç·þÍË³öÊÂ¼þ
function pActivity:PlayerExchageServerLoginOut_BeforeSaveData()
    if GetPlayerEnteringTrap() == 0 then --Íæ¼Ò²»ÊÇ²Ètrap¿çµÄµØÍ¼
        return nil;
    end
    -- ¼ì²éÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        return nil;
    end
    -- ¼ì²éïÚ³µÎ»ÖÃ
    local nX32, nY32, nMapIdx = self:getCurrentCarPos();
    if (nMapID == -1) then
        return nil;
    end
    local nPMapID, nPX, nPY = GetWorldPos();
    if (nMapIdx ~= SubWorldID2Idx(nPMapID)) then
        return nil;
    end
    if (sqrt((nX32-nPX*32)*(nX32-nPX*32) + (nY32-nPY*32)*(nY32-nPY*32)) > 600) then
        return nil;
    end
    if (IsBiaoCheAlive() == 0) then
        return nil;
    end
    -- ±£´æïÚ³µÐÅÏ¢_ÑªÁ¿
    local nBiaoCheNpcIndex = GetTask(TSK_LMBJCarIndex)
    if nBiaoCheNpcIndex <= 0 then
        return nil;
    end
    SetTask(TSK_BiaoCheLife, GetNpcLife(GetNpcId(nBiaoCheNpcIndex)));
    -- ÉèÖÃ¿ç·þË¢ïÚ³µ±ê¼Ç
    SetTask(TSK_RefreshBiaoChe, 1);
    SetPlayerEnteringTrap(0);
    local szBiaoCheName = GetNpcName(nBiaoCheNpcIndex);
    if (DeleteBiaoChe() == 0) then
        WriteYunBiaoLog(format("T¹i %s(%d,%d) xãa [%s] thÊt b¹i.", tbGlobalMapId2Name[nPMapID], nPX, nPY, szBiaoCheName));
    end
end

function pActivity:PlayerExchageServerLoginOut()
--    if GetTask(TSK_RefreshBiaoChe) ~= 1 then
--        return nil;
--    end
--    -- É¾³ýïÚ³µ
--    DeleteBiaoChe();
end

-- ÈÕÇå¿Õ±äÁ¿²Ù×÷
function pActivity:AddTaskDailyA(nTskID, nValue)
    local nCurDate = tonumber(GetLocalDate("%y%m%d"));
    local nTaskValue = GetTask(nTskID);
    if floor(nTaskValue/256) ~= nCurDate then
        nTaskValue = nCurDate*256;
    end
    SetTask(nTskID, nTaskValue+nValue);
end

function pActivity:GetTaskDailyA(nTskID)
    local nCurDate = tonumber(GetLocalDate("%y%m%d"));
    local nTaskValue = GetTask(nTskID);

    if floor(nTaskValue/256) ~= nCurDate then
        nTaskValue = nCurDate * 256;
        SetTask(nTskID, nTaskValue);
    end
    return mod(nTaskValue, 256);
end

function pActivity:CheckHasTask()
    local nTaskValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskValue ~= 0) then
        local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
        if nPassTime < 1800 then
            return 1;
        end
    end
    return 0;
end

-- ¼ì²éÄÜ·ñµã»÷½ÓÊÜÑºïÚÈÎÎñ
function pActivity:CheckReceiveTaskCondition()
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñÔÚÑºïÚÊ±¶Î 10:00 ~ 23:00
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if (nCurTime>2300 or nCurTime<1000) then
        Talk(1, "", "Kh«ng trong thêi gian ¸p tiªu 10:00-23:00, hiÖp sÜ h·y quay l¹i.");
        return nil;
    end
    -- ÅÐ¶ÏÊÇ²»ÊÇ°×ÃûÍæ¼Ò
    if (GetCamp() == 0) then
        Talk(1, "", "Sau khi gia nhËp m«n ph¸i h·y ®Õn t×m ta nhËn nhiÖm vô.");
        return nil;
    end
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñ»¹ÓÐÎ´Íê³ÉµÄÑºïÚÈÎÎñ
    local nTaskValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskValue ~= 0) then
        local nId = floor(nTaskValue/10);
        local nLevel = self.tbBJPathLevel[nId][2];
        local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
        if nLevel < 10 or nPassTime < 1800 then
            Talk(1, "", "Ng­¬i ®· nhËn nhiÖm vô, h·y n¾m b¾t thêi gian");
            return nil;
        end
    end
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñÓÐÎ´ÁìµÄ½±Àø
    if (CalcItemCount(-1, 6, 1, 4200, -1) > 0) then
        Talk(1, "", "Ng­¬i cã phÇn th­ëng ¸p Tiªu ch­a nhËn, nhËn xong råi quay l¹i ®©y.");
        return nil;
    end

    return 1;
end

-- ´¦Àíµã»÷½ÓÊÜ1ÐÇÑºïÚÈÎÎñ
function pActivity:ReceiveTaskLow()
    -- Ìõ¼þÅÐ¶Ï£º½ñÈÕÊÇ·ñÒÑÍê³É3´ÎÑºïÚÈÎÎñ
    local nTaskValue = self:GetTaskDailyA(TSK_DailyTaskNum);
    if (nTaskValue >= 3) then
        Talk(1, "", "HiÖp sÜ h«m nay ®· hoµn thµnh 3 lÇn ¸p tiªu, ngµy mai h·y quay l¹i.");
        return nil;
    end
    local nTaskValue = GetTask(TSK_LMBJLowTskFlag);
    if (nTaskValue == 0) then
        nTaskValue = 1*10 + random(0, 1);
        SetTask(TSK_LMBJLowTskFlag, nTaskValue);
    end
    local tbPath = self.tbBJPathLevel[1][1];
    local nSid = tbPath[1];
    local nEid = tbPath[2];
    local bFlag = mod(nTaskValue, 10);
    if bFlag == 1 then -- ½»»»ÆðµãºÍÖÕµã
        nSid, nEid = nEid, nSid;
    end
    local nLevel = self.tbBJPathLevel[1][2];
    local szSName = self.tbBJPoints[nSid][1];
    local szEName = self.tbBJPoints[nEid][1];
    local szTitleMsg = format("<npc>NhiÖm vô Tiªu Xa 1 Sao, ®iÓm ®Çu %s-®iÓm cuèi %s, trong vßng 30 phót ®Õn n¬i, ®ång ý?", szSName, szEName);
    local tbOpt = {};
    tinsert(tbOpt, {"X¸c nhËn", self.onSelectProcess, {self, 1, {1,bFlag} }, });
    tinsert(tbOpt, {"Rêi khái", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
    return 1;
end

-- ´¦Àíµã»÷½ÓÊÜËæ»úÑºïÚÈÎÎñ
function pActivity:ReceiveTaskRandom()
    -- Ìõ¼þÅÐ¶Ï£º½ñÈÕÊÇ·ñÒÑÍê³É3´ÎÑºïÚÈÎÎñ
    local nTaskValue = self:GetTaskDailyA(TSK_DailyTaskNum);
    if (nTaskValue >= 3) then
        Talk(1, "", "HiÖp sÜ h«m nay ®· hoµn thµnh 3 lÇn ¸p tiªu, ngµy mai h·y quay l¹i.");
        return nil;
    end
    local nTaskValue = GetTask(TSK_LMBJRanTskFlag);
    if (nTaskValue == 0) then
        -- ²úÉúÐÂµÄÑºïÚÂ·Ïß
        local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
        local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
        DynamicExecute(szLocalPath, 
                    "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetTaskFlag", 0, 
                    "pActivity:getTaskFlagCallBack", PlayerIndex); -- ÔÚ»Øµ÷º¯ÊýÖÐ±£´æ·µ»ØÖµ
        return 0;
    end
    self:CreateRandomTaskPanel(floor(nTaskValue/10), mod(nTaskValue,10));
    return 1;
end

function pActivity:CreateRandomTaskPanel(nId, bSwitch)
    local tbPath = self.tbBJPathLevel[nId][1];
    local nSid = tbPath[1];
    local nEid = tbPath[2];
    if bSwitch == 1 then
        nSid, nEid = nEid, nSid;
    end
    local nLevel = self.tbBJPathLevel[nId][2];
    local szSName = self.tbBJPoints[nSid][1];
    local szEName = self.tbBJPoints[nEid][1];
    local szTitleMsg = format("<npc>NhiÖm vô Tiªu Xa %d Sao, ®iÓm ®Çu %s-®iÓm cuèi %s, trong vßng 30 phót ®Õn n¬i, ®ång ý? Sau khi nhËn kh«ng thÓ t¹o míi nhiÖm vô.", nLevel, szSName, szEName);
    local tbOpt = {};
    tinsert(tbOpt, {"TiÕp nhËn",               self.onSelectProcess, { self, 2, {nId,bSwitch} },});
    tinsert(tbOpt, {"Lµm míi nhiÖm vô miÔn phÝ",       self.onSelectProcess, { self, 3, {nId,bSwitch} },});
    tinsert(tbOpt, {"Dïng Ho¸n Tiªu ChØ ®Ó t¹o míi nhiÖm vô", self.onSelectProcess, { self, 4, {nId,bSwitch} },});
    tinsert(tbOpt, {"Rêi khái",               self.onSelectProcess, { self, 0, {nil} },});
    CreateNewSayEx(szTitleMsg, tbOpt);
end

-- ´¦Àíµã»÷¸ß¼¶ÑºïÚÈÎÎñ
function pActivity:ReceiveTaskHigh()
    local szTitleMsg = "<npc>Ng­¬i muèn thö th¸ch b¶n th©n nhËn nhiÖm vô ¸p Tiªu khã nhÊt? Kh«ng cã thùc lùc th× kh«ng ®­îc, nÕu nh­ ng­¬i cã <color=red> ¸p tiªu ñy nhiÖm tr¹ng cao cÊp <color> th× ta cã thÓ suy nghÜ l¹i.";
    local tbOpt = {};
    tinsert(tbOpt, {"Sö dông ¸p tiªu ñy nhiÖm tr¹ng cao cÊp", self.onSelectProcess, {self, 5, {nil}}});
    tinsert(tbOpt, {"Rêi khái", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
end

-- ´¦Àíµã»÷ÁìÈ¡ÑºïÚÈÎÎñ½±Àø
function pActivity:ReceiveAward(nNpcType)
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñ½ÓÁËÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        local szTips = "Ng­¬i vÉn ch­a nhËn nhiÖm vô ¸p Tiªu, h·y ®Õn Long M«n TrÊn t×m «ng chñ Yªm M«n ®i.";
        if (nNpcType == 0) then
            szTips = "Ng­¬i ch­a nhËn nhiÖm vô ¸p Tiªu.";
        end
        Talk(1, "", szTips);
        return nil;
    end
    -- ÅÐ¶ÏïÚ³µÊÇ·ñ³ö·¢
    if (GetTask(TSK_LMBJTaskTime) == 0) then
        Talk(1, "", "Tiªu Xa cña ng­¬i vÉn ch­a xuÊt ph¸t, mau ®i ®Õn ®iÓm xuÊt ph¸t t×m Tiªu S­ ®Ó b¾t ®Çu ®i.");
        return nil;
    end
    -- »ñÈ¡ÑºïÚÈÎÎñÐÅÏ¢
    local nId = floor(nTaskFlagValue/10); -- ÑºïÚÂ·ÏßID
    local bFlag = mod(nTaskFlagValue,10); -- ÊÇ·ñ½»»»ÆðÊ¼µã
    local tbPath = self.tbBJPathLevel[nId][1]; -- ÑºïÚÂ·Ïß
    local nLevel = self.tbBJPathLevel[nId][2]; -- ÑºïÚµÈ¼¶
    if nLevel >= 10 then
        Talk(1, "", "HiÖn ®ang nhËn nhiÖm vô ¸p Tiªu Bang, mau ®­a Tiªu Xa ®Õn TiÕp DÉn Tiªu Xa Bang chØ ®Þnh.");
        return nil;
    end
    local tbCountCell = self.tbAllCountCell[nLevel];
    local tbAwardList = self.tbAward[nLevel];
    -- ÊÇ·ñÓÐïÚÆì_ÓÐïÚÆìÁìµÍ±£
    local nBiaoQiCount = CalcItemCount(-1, 6, 1, 4200, -1);
    if nBiaoQiCount > 0 then
        tbCountCell = self.tbLowCountCell[nLevel];
        -- ¼ì²é±³°ü¿Õ¼ä
        local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", tbCountCell[2]);
        if PlayerFunLib:CheckFreeBagCell(tbCountCell[2], szTips) ~= 1 then
            return 0;
        end
        tongaward_longmenbiaoju();
        -- ÐÞ¸ÄÑºïÚ±ê¼Ç±äÁ¿
        SetTask(TSK_LMBJTaskFlag, 0);
        for i = 1, nBiaoQiCount do
            ConsumeItem(-1, 1, 6, 1, 4200, -1); -- ¿Û³ýµÀ¾ß
        end
        DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", "yunbiao"); -- ¸øÍæ¼ÒÔö¼Ó»îÔ¾¶È
        tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M«n Tiªu Côc] Tiªu Xa bÞ c­íp nhËn ®­îc phÇn th­ëng an ñi.", tbCountCell[1]);
        AddStatData("lmbj_task_over");
        WriteYunBiaoLog(format("[Long M«n Tiªu Côc] Tµi kho¶n: %s, Nh©n vËt: %s, Tiªu Xa bÞ c­íp nhËn ®­îc phÇn th­ëng an ñi, ID nhiÖm vô: %d, CÊp sao: %d", 
                                                            GetAccount(), GetName(), nId, nLevel));
        Talk(1, "", "Tuy lµ Tiªu Xa bÞ c­íp nh­ng còng may c­íp l¹i ®­îc Tiªu Kú, kh«ng cã c«ng còng cã søc, cã chót tiÒn cho ng­¬i mua r­îu h·y nhËn lÊy.");
        return 0;
    end
    -- Ìõ¼þÅÐ¶Ï£ºïÚ³µÊÇ·ñÔÚÍæ¼Ò¸½½ü
    local nNpcIndex = GetLastDiagNpc();
    local nX32, nY32, nMapIdx = GetNpcPos(nNpcIndex);
    local nPX32, nPY32, nPMapIdx = self:getCurrentCarPos();
    if (IsBiaoCheAlive() == 1 and nMapIdx == nPMapIdx) then -- ïÚ³µÔÚÍæ¼Ò¸½½ü
        local nEPosId = tbPath[2-bFlag];            -- ÑºïÚÂ·ÏßµÄÖÕµãID
        local tbPos = self.tbBJPoints[nEPosId][2];  -- ÖÕµãïÚÊ¦×ø±ê
        -- Ìõ¼þÅÐ¶Ï£º¶Ô»°NPCÊÇ²»ÊÇÖÕµãNPC
        if ((nX32 ~= tbPos[2]*32) or (nY32 ~= tbPos[3]*32)) then
            Talk(1, "", "§¹i hiÖp ®i sai ®­êng råi, mau chãng hé tèng Tiªu Xa ®Õn ®Þa ®iÓm chÝnh x¸c.");
            return nil;
        end
        -- Ìõ¼þÅÐ¶Ï£ºïÚ³µÊÇ·ñÔÚÖÕµãNPC¸½½ü600ÂëÖ®ÄÚ
        if (sqrt((nX32-nPX32)*(nX32-nPX32) + (nY32-nPY32)*(nY32-nPY32)) > 600) then
            Talk(1, "", "Tiªu Xa kh«ng cã ë bªn c¹nh, mau ®i t×m xem.");
            return nil;
        end
        -- ¼ì²é±³°ü¿Õ¼ä
        local szTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", tbCountCell[2]+1);
        if PlayerFunLib:CheckFreeBagCell(tbCountCell[2]+1, szTips) ~= 1 then
            return nil;
        end
        tongaward_longmenbiaoju();
        -- É¾³ýïÚ³µ
        DeleteBiaoChe();
        -- ÐÞ¸ÄÑºïÚ±ê¼Ç±äÁ¿
        SetTask(TSK_LMBJTaskFlag, 0);
        -- ¸ø½±Àø
        DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", "yunbiao"); -- ¸øÍæ¼ÒÔö¼Ó»îÔ¾¶È
        tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M«n Tiªu Côc] ¸p tiªu thµnh c«ng nhËn ®­îc toµn bé phÇn th­ëng.", tbCountCell[1]);
        local tbAwardItem = {szName = "Hé Tiªu LÖnh", tbProp = {6, 1, 4203, 1, 0, 0}, nBindState = -2,};
        PlayerFunLib:GetItem(tbAwardItem, 2, "[Long M«n Tiªu Côc-NhiÖm vô ¸p Tiªu] ¸p tiªu thµnh c«ng nhËn ®­îc Hé Tiªu LÖnh");
        AddStatData("lmbj_task_over");
        WriteYunBiaoLog(format("[Long M«n Tiªu Côc] Tµi kho¶n: %s, Nh©n vËt: %s, ¸p tiªu thµnh c«ng nhËn ®­îc toµn bé phÇn th­ëng, ID nhiÖm vô: %d, CÊp sao: %d", 
                                                            GetAccount(), GetName(), nId, nLevel));
        return 1;
    end
    -- ïÚ³µ²»ÔÚÍæ¼Ò¸½½ü
    local szTitleMsg = "<npc>NhiÖm vô ¸p Tiªu ch­a kÕt thóc, nÕu lµm mÊt Tiªu Xa vµ Tiªu Kú cã thÓ kÕt thóc nhiÖm vô vµ nhËn 100 v¹n kinh nghiÖm, nÕu Tiªu Xa bÞ c­íp t×m l¹i <color=red>Tiªu Kú<color> sÏ nhËn ®­îc mét sè phÇn th­ëng.";
    local tbOpt = {};
    tinsert(tbOpt, {"KÕt thóc nhiÖm vô, nhËn kinh nghiÖm", self.onSelectProcess, {self, 6, {nId, bFlag}}});
    tinsert(tbOpt, {"Ta ®i t×m l¹i xem sao", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
end

-- ´¦Àí²é¿´ÑºïÚÐÅÏ¢
function pActivity:ViewTaskInfor()
    local szTitleMsg = "";
    local szTempLine = "";
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    local nTaskTimeValue = GetTask(TSK_LMBJTaskTime);
    -- ½ÓÁËÈÎÎñ²¢ÇÒÁìÁËïÚ³µ
    local nBiaoQiCount = CalcItemCount(-1, 6, 1, 4200, -1);
    if (nTaskFlagValue ~= 0 and nTaskTimeValue ~= 0 and nBiaoQiCount <= 0) then
        local handle = OB_Create();
        ObjBuffer:PushObject(handle, GetName());
        local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
        local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
        DynamicExecute(szLocalPath,
            "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetBiaoChePos", handle, 
            "pActivity:viewTaskInforCallBack", PlayerIndex);
        OB_Release(handle);
        return 1;
    end

    if (nTaskFlagValue == 0) then -- Î´½ÓÈÎÎñ
        szTitleMsg = "<npc><enter>Ch­a nhËn nhiÖm vô ¸p Tiªu.";
    else
        local nId = floor(nTaskFlagValue/10);
        local nFlag = mod(nTaskFlagValue, 10);
        local tbPath = self.tbBJPathLevel[nId][1]; -- ÑºïÚÂ·Ïß
        local nSid = tbPath[1];
        local nEid = tbPath[2];
        if nFlag == 1 then
            nSid, nEid = nEid, nSid;
        end
        local nLevel = self.tbBJPathLevel[nId][2]; -- ÑºïÚµÈ¼¶
        -- ÑºïÚÐÅÏ¢
        szTitleMsg = format("<npc><enter>Lé tr×nh ¸p Tiªu: %s-%s<enter>CÊp nhiÖm vô: %d Sao", self.tbBJPoints[nSid][1], self.tbBJPoints[nEid][1], nLevel);
        if (nTaskTimeValue == 0) then
            -- ÈÎÎñ×´Ì¬
            szTempLine = "<enter>tr¹ng th¸i nhiÖm vô: vÉn ch­a nhËn Tiªu Xa";
        end
        if (nBiaoQiCount > 0) then
            szTempLine = "<enter>Tr¹ng th¸i nhiÖm vô: Tiªu Xa bÞ c­íp";
        end
        szTitleMsg = szTitleMsg..szTempLine;
    end
    -- ½ñÈÕÑºïÚÈÎÎñ´ÎÊý
    local nDailyTaskNum = self:GetTaskDailyA(TSK_DailyTaskNum);
    szTempLine = format("<enter>Sè lÇn nhiÖm vô ¸p Tiªu h«m nay: %d/3", nDailyTaskNum);
    szTitleMsg = szTitleMsg..szTempLine;
    -- ½ñÈÕÃâ·ÑË¢ÐÂÈÎÎñ´ÎÊý
    local nDailyFreeCount = self:GetTaskDailyA(TSK_DailyFreeCount);
    szTempLine = format("<enter>Sè lÇn lµm míi nhiÖm vô miÔn phÝ h«m nay: %d/5", nDailyFreeCount);
    szTitleMsg = szTitleMsg..szTempLine;
    -- ´´½¨ÏÔÊ¾Ãæ°å
    local tbOpt = {};
    tinsert(tbOpt, {"Rêi khái", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
    return 0;
end

-- ´¦Àíµã»÷¿ìËÙ´«ËÍµ½ïÚ³µÎ»ÖÃ
function pActivity:Transport2Dest()
    -- ÅÐ¶ÏÊÇ·ñ½ÓÁËÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        Talk(1, "", "HiÖp sÜ ch­a nhËn nhiÖm vô ¸p Tiªu.");
        return nil;
    end
    -- ÅÐ¶ÏÈÎÎñÊÇ·ñ¿ªÊ¼
    if (GetTask(TSK_LMBJTaskTime) == 0) then
        Talk(1, "", "Tiªu Xa ch­a xuÊt ph¸t.");
        return nil;
    end
    -- µ±Ç°ÈÎÎñÊÇ²»ÊÇ¸öÈËÑºïÚÈÎÎñ
    local nId = floor(nTaskFlagValue/10);
    if self.tbBJPathLevel[nId][2] >= 10 then
        Talk(1, "", "HiÖn nhËn nhiÖm ¸p Tiªu Bang, Tiªu Xa Bang kh«ng cã ë chç ta.");
        return nil;
    end
    local nMoney = GetCash();
    if (nMoney < 10000) then
        Talk(1, "", "Ng©n l­îng cña ®¹i hiÖp kh«ng ®ñ.");
        return nil;
    end
    -- ¼ì²é´«³µµÄCDÊ±¼ä 30Ãë
    local nPassTime = GetCurrentTime() - GetTask(TSK_TransCarTime);
    if (nPassTime < 30) then
        Talk(1, "", "C¸ch lÇn truyÒn tèng tr­íc ch­a ®Õn 30 gi©y, h·y ®îi.");
        return nil;
    end
    -- ¼ì²éïÚ³µÊÇ·ñÒÑ±»´Ý»Ù»òÕßÏûÊ§
    if (CalcItemCount(-1, 6, 1, 4200, -1) > 0) then
        Talk(1, "", "Tiªu Xa ®Òu bÞ ng­¬i lµm mÊt hÕt råi, kh«ng thÓ truyÒn tèng.");
        return nil;
    end
    local handle = OB_Create();
    ObjBuffer:PushObject(handle, GetName());
    local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
    local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
    DynamicExecute(szLocalPath, 
        "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetBiaoChePos", handle, 
        "pActivity:getBiaoChePosCallBack", PlayerIndex);
    OB_Release(handle);
end

-- ·ÅÆúÑºïÚÈÎÎñ ïÚ³µÎ´Ë¢³ö
function pActivity:AbandonTask()
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñ½Óµ½ÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        Talk(1, "", "Ng­¬i vÉn ch­a nhËn nhiÖm vô vËn Tiªu.");
        return nil;
    end
    -- µ±Ç°ÈÎÎñÊÇ²»ÊÇ¸öÈËÑºïÚÈÎÎñ
    local nId = floor(nTaskFlagValue/10);
    if self.tbBJPathLevel[nId][2] >= 10 then
        Talk(1, "", "HiÖn ®ang nhËn nhiÖm vô ¸p Tiªu Bang, kh«ng thÓ bá.");
        return nil;
    end
    -- ÅÐ¶ÏÊÇ·ñÉú³ÉïÚ³µ
    if GetTask(TSK_LMBJTaskTime) ~= 0 then
        Talk(1, "", "Tiªu Xa cña ng­¬i ®· xuÊt ph¸t råi, lµm sao cã thÓ bá gi÷a chõng ®­îc!");
        return nil;
    end
    -- 7~9ÐÇïÚ²»ÄÜ·ÅÆú
    local nId = floor(nTaskFlagValue/10);
    local nLevel = self.tbBJPathLevel[nId][2]; -- ÑºïÚµÈ¼¶
    if (nLevel >= 7) then
        Talk(1, "", "Ng­¬i ®· nhËn nhiÖm vô ¸p Tiªu cao cÊp lµm sao cã thÓ bá ®­îc? Ta xem träng ng­¬i!");
        return nil;
    end
    -- ·ÅÆúÈ·ÈÏ¿ò
    local szTitleMsg = "<npc>§¹i hiÖp x¸c ®Þnh lÇn nµy kh«ng thÓ xuÊt Tiªu kh«ng?";
    local tbOpt = {};
    tinsert(tbOpt, {"X¸c nhËn", self.onConfirmProcess, { self, 5, {nId, 0} },});
    tinsert(tbOpt, {"Rêi khái", self.onConfirmProcess, { self, 0, {nil} },});
    CreateNewSayEx(szTitleMsg, tbOpt);
    return nil;
end

function pActivity:LogCurMapID()
    local nMapID = GetWorldPos();
    SetTask(TSK_MapIDFlag, nMapID);
    return 1;
end

-- ¿ªÊ¼ÑºïÚ
function pActivity:ReceiveBiaoChe()
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñ½Óµ½ÈÎÎñ
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        Talk(1, "", "Ch­a nhËn nhiÖm vô VËn Tiªu, h·y ®Õn Long M«n TrÊn t×m Ch­ëng Quü.");
        return nil;
    end
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if (nCurTime>=2300 or nCurTime < 1000) then
        Talk(1, "", "Kh«ng trong thêi gian ¸p tiªu 10:00-23:00, hiÖp sÜ h·y quay l¹i.");
        return nil;
    end
    -- ÅÐ¶ÏÍæ¼ÒÊÇ·ñÔÚÓëÆðµãNPC¶Ô»°
    local nMapID, nX, nY = GetWorldPos();
    if (GetTask(TSK_MapIDFlag) ~= nMapID) then
        return nil;
    end
    -- »ñÈ¡ÑºïÚÈÎÎñÐÅÏ¢
    local nId = floor(nTaskFlagValue/10); -- ÑºïÚÂ·ÏßID
    local bFlag = mod(nTaskFlagValue,10); -- ÊÇ·ñ½»»»ÆðÊ¼µã
    local tbPath = self.tbBJPathLevel[nId][1]; -- ÑºïÚÂ·Ïß
    local nLevel = self.tbBJPathLevel[nId][2]; -- ÑºïÚµÈ¼¶
    -- Ìõ¼þÅÐ¶Ï£º¶Ô»°NPCÊÇ·ñÊÇÈÎÎñµÄÆðµãNPC
    local nNpcIndex = GetLastDiagNpc();
    local nX32, nY32 = GetNpcPos(nNpcIndex);
    local nEPosId = tbPath[1+bFlag];            -- ÑºïÚÂ·ÏßµÄÖÕµãID
    local tbPos = self.tbBJPoints[nEPosId][2];  -- ÑºïÚÂ·ÏßÖÕµã×ø±ê
    if ((nX32 ~= tbPos[2]*32) or (nY32 ~= tbPos[3]*32)) then
        Talk(1, "", "HiÖp sÜ ®Õn nhÇm chç råi, Tiªu Xa ®ang ë ®iÓm b¾t ®Çu.");
        return nil;
    end
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñÒÑ¾­½Ó¹ýïÚ³µ
    local nLastTaskTime = GetTask(TSK_LMBJTaskTime);
    if (nLastTaskTime ~= 0) then
        Talk(1, "", "Kh«ng ph¶i Tiªu Xa cña ng­¬i ®· xuÊt ph¸t tõ l©u råi sao, cßn kh«ng mau ®i b¶o vÖ nÕu kh«ng sÏ bÞ kÎ xÊu c­íp mÊt b©y giê!");
        return nil;
    end
    -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñÔ¶ÀëÆðµãïÚÊ¦
    if(abs(nX32-nX*32) > 600 or abs(nY32-nY*32) > 600) then
        Talk(1, "", "Ng­¬i ®ang c¸ch xa ®iÓm b¾t ®Çu Tiªu S­, khi Tiªu Xa xuÊt hiÖn kh«ng nªn rêi xa Tiªu S­.");
        return nil;
    end
    -- Ë¢³öïÚ³µ
    self:refreshBiaoChe(30*60);
    SetTask(TSK_ItemKMJBTime, 0);
    SetTask(TSK_ItemJBKCTime, 0);
    SetTask(TSK_TransCarTime, 0);
    SetTask(TSK_ItemBCYWTime, 0);
    -- ±£´æ½ÓÈÎÎñÊ±¼ä
    local nCurTime = GetCurrentTime();
    SetNpcParam(GetTask(TSK_LMBJCarIndex), 4, nCurTime);
    SetTask(TSK_LMBJTaskTime, nCurTime);
    -- Êý¾ÝÂñµã
    AddStatData(format("lmbj_car_build_%d", nLevel));
end

function pActivity:onSelectProcess(nSelId, tbParam)
    -- Àë¿ª¡¢È¡Ïû²Ù×÷
    if (nSelId == 0) then
        return nil;
    end

    local szTitleMsg = "";
    local tbOpt = {};

    -- ¸ß¼¶ÑºïÚÈÎÎñ
    if (nSelId == 5) then
        szTitleMsg = "<npc>Nép ¸p tiªu ñy nhiÖm tr¹ng cao cÊp sÏ ngÉu nhiªn xuÊt hiÖn nhiÖm vô ¸p Tiªu 7 sao, 8 sao, 9 sao. Ng­¬i ®· chuÈn bÞ xong ch­a?"
        tinsert(tbOpt, {"X¸c nhËn", self.onConfirmProcess, { self, 3, {nil} },});
        tinsert(tbOpt, {"Rêi khái", self.onConfirmProcess, { self, 0, {nil} },});
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

    -- ÎÒ°ÑïÚ³µºÍïÚÆì¶¼Åª¶ªÁË
    if(nSelId == 6) then
        -- ²é¿´ïÚ³µÊÇ·ñÒÑ¾­ÏûÊ§
        tongaward_longmenbiaoju();
        local handle = OB_Create();
        ObjBuffer:PushObject(handle, GetName());
        local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
        local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
        DynamicExecute(szLocalPath, 
            "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetBiaoChePos", handle, 
            "pActivity:getCheckBiaoCheCallBack", PlayerIndex);
        OB_Release(handle);
        return nSelId;
    end
    
    local nId   = tbParam[1];
    local bFlag = tbParam[2];
    local tbPath = self.tbBJPathLevel[nId][1];
    local nLevel = self.tbBJPathLevel[nId][2];
    local nSid = tbPath[1];
    local nEid = tbPath[2];
    if (bFlag == 1) then -- ½»»»ÆðµãºÍÖÕµã
        nSid, nEid = nEid, nSid;
    end

    -- ÑºïÚÈÎÎñÈ·¶¨
    if (nSelId == 1) then
        self:AddTaskDailyA(TSK_DailyTaskNum, 1);
        self:saveTask(tbParam);
        -- ´«ËÍµ½ÈÎÎñÆðÊ¼ïÚÊ¦Î»ÖÃ
        self:transToBeginPos(tbParam);
        self:updateRelayData(nId);
        return nSelId;
    end

    -- Ëæ»úÑºïÚÈÎÎñ-½ÓÊÜ
    if (nSelId == 2) then
        local szSName = self.tbBJPoints[nSid][1];
        local szEName = self.tbBJPoints[nEid][1];
        szTitleMsg = format("<npc>NhiÖm vô Tiªu Xa %d Sao, ®iÓm ®Çu %s-®iÓm cuèi %s, trong vßng 30 phót ®Õn n¬i, ®ång ý?",nLevel, szSName, szEName);
        tbOpt = {};
        tinsert(tbOpt, {"X¸c nhËn", self.onSelectProcess, {self,1,tbParam}, });
        tinsert(tbOpt, {"Rêi khái", self.onSelectProcess, {self,0,{nil}}, });
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

    -- Ëæ»úÑºïÚÈÎÎñ-Ãâ·ÑË¢ÐÂÈÎÎñ
    if (nSelId == 3) then
        -- Ìõ¼þÅÐ¶Ï : ½ñÌìÊÇ·ñ»¹ÓÐÃâ·Ñ»»ïÚ»ú»á
        local nFreeCount = self:GetTaskDailyA(TSK_DailyFreeCount);
        szTitleMsg = "Ng­¬i ®· dïng hÕt sè lÇn lµm míi miÔn phÝ cña ngµy h«m nay, muèn sö dông tiÕp <color=red> Ho¸n Tiªu ChØ <color>.";
        if (nFreeCount<5) then
            szTitleMsg = "<npc>Cã ph¶i lµm míi nhiÖm vô?";
            tinsert(tbOpt, {"X¸c nhËn", self.onConfirmProcess, {self,1,tbParam}, });
        end
        tinsert(tbOpt, {"Trë vÒ", self.CreateRandomTaskPanel, {self, tbParam[1], tbParam[2]}, });
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

    -- Ëæ»úÑºïÚÈÎÎñ-»»Æ±Ö¤Ë¢ÐÂÈÎÎñ
    if (nSelId == 4) then
        -- Ìõ¼þÅÐ¶Ï£ºÊÇ·ñ»¹ÓÐÃâ·Ñ»»ïÚ»ú»á
        if (self:GetTaskDailyA(TSK_DailyFreeCount) < 5) then
            Talk(1, "", "HiÖn hiÖp sÜ cßn sè lÇn miÔn phÝ, kh«ng cÇn dïng Ho¸n Tiªu ChØ.");
            return 0;
        end
        -- Ìõ¼þÅÐ¶Ï£º±³°üÖÐÊÇ·ñÓÐ»»Æ±Æ¾Ö¤
        if (CalcItemCount(3, 6, 1, 4201, -1) <= 0) then
            Talk(1, "", "Kh«ng cã Ho¸n Tiªu ChØ, kh«ng nªn l·ng phÝ thêi gian.");
            return 0;
        end
        szTitleMsg = "<npc>Dïng PhiÕu §èi Tiªu t¹o míi nhiÖm vô?";
        tinsert(tbOpt, {"X¸c nhËn", self.onConfirmProcess, { self, 2, tbParam },});
        tinsert(tbOpt, {"Trë vÒ", self.CreateRandomTaskPanel, {self, tbParam[1], tbParam[2]}, });
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

end

function pActivity:onConfirmProcess(nSelId, tbParam)
    if (nSelId == 0) then
        return nil;
    end

    -- È·¶¨Ãâ·Ñ»»ïÚ
    if (nSelId == 1) then
        -- ½ñÈÕµÄÃâ·Ñ»»ïÚ´ÎÊý+1
        self:AddTaskDailyA(TSK_DailyFreeCount, 1);
        local szTips = format("NhiÖm vô ¸p Tiªu ®· t¹o míi, cßn %d lÇn miÔn phÝ.", 5-self:GetTaskDailyA(TSK_DailyFreeCount));
        Msg2Player(szTips);
        -- ²úÉúÐÂµÄÑºïÚÂ·Ïß
        local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
        local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
        DynamicExecute(szLocalPath, 
                    "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetTaskFlag", 0, 
                    "pActivity:getTaskFlagCallBack", PlayerIndex);
        return nSelId;
    end

    -- È·¶¨Ê¹ÓÃ»»ïÚÆ¾Ö¤»»ïÚ
    if (nSelId == 2) then
        if (ConsumeItem(3, 1, 6, 1, 4201, -1) == 1) then -- ¿Û³ýµÀ¾ß(»»ïÚÆ¾Ö¤)
            Msg2Player("NhiÖm vô ¸p Tiªu ®· t¹o míi, trõ 1 Ho¸n Tiªu ChØ.");
            -- ÖØÐÂ²úÉúÑºïÚÂ·Ïß
            local nTaskValue = self:getChangeTaskFlag();
            SetTask(TSK_LMBJRanTskFlag, nTaskValue);
            WriteYunBiaoLog(format("[Long M«n Tiªu Côc] Tµi kho¶n: %s, Nh©n vËt: %s dïng Ho¸n Tiªu ChØ", GetAccount(), GetName()));
            AddStatData("lmbj_task_refresh");
            self:CreateRandomTaskPanel(floor(nTaskValue/10), mod(nTaskValue,10));
        else
            Msg2Player("KhÊu trõ ®¹o cô thÊt b¹i, h·y ®Æt Ho¸n Tiªu ChØ vµo trong Tói.");
        end
        return nSelId;
    end

    -- È·¶¨½ÓÊÜ¸ß¼¶ÑºïÚÈÎÎñ
    if (nSelId == 3) then
        if (ConsumeItem(3, 1, 6, 1, 4202, -1) ~= 1) then -- ¿Û³ýµÀ¾ß(»»ïÚÆ¾Ö¤)
            Talk(1, "", "Ng­¬i kh«ng cã ¸p tiªu ñy nhiÖm tr¹ng cao cÊp, ®õng phÝ thêi gian n÷a.");
            return nil;
        end
        local nLevel = 8;
        local nRandValue = random(1, 100);
        if (nRandValue <= 60) then -- 60%µÄ¸ÅÂÊ7ÐÇïÚ³µ
            nLevel = 7;
        elseif (nRandValue >90) then-- 10%µÄ¸ÅÂÊ9ÐÇïÚ³µ
            nLevel = 9;
        end
        local tbAllId = self.tbAllTask[nLevel].tbID;
        local nId = tbAllId[random(1, getn(tbAllId))];
        local bSwitchSE = random(0, 1);
        self:saveTask({nId, bSwitchSE});
        Msg2Player("§· nhËn 1 nhiÖm vô ¸p Tiªu cÊp cao, kiÕn nghÞ tæ ®éi hé tiªu.");
        WriteYunBiaoLog(format("[Long M«n Tiªu Côc]  Tµi kho¶n: %s, Nh©n vËt: %s dïng ¸p Tiªu ñy Tr¹ng NhiÖm Vô Cao CÊp, ID nhiÖm vô: %d, CÊp sao: %d", GetAccount(), GetName(), nId, nLevel));
        AddStatData("lmbj_task_highbook");
        self:transToBeginPos({nId, bSwitchSE});
        return nSelId;
    end

    -- ïÚ³µ¡¢ïÚÆì¶¼Ã»ÓÐ½áÊø±¾´ÎÈÎÎñ£¬¸ø¾­Ñé
    local nId = tbParam[1];
    local nLevel = self.tbBJPathLevel[nId][2];
    if (nSelId == 4) then
        SetTask(TSK_LMBJTaskFlag, 0);
--        DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", 32); -- ¸øÍæ¼ÒÔö¼Ó»îÔ¾¶È
        PlayerFunLib:AddExp(1000000, 1, "[Long M«n Tiªu Côc] Tiªu Xa biÕn mÊt, kh«ng cã phÇn th­ëng kinh nghiÖm dïng Tiªu Kú kÕt thóc nhiÖm vô");
        AddStatData("lmbj_task_over");
        WriteYunBiaoLog(format("[Long M«n Tiªu Côc] Tµi kho¶n: %s, Nh©n vËt: %s, ID nhiÖm vô kÕt thóc: %d, CÊp sao: %d", GetAccount(), GetName(), nId, nLevel));
        Msg2Player("§· kÕt thóc nhiÖm vô ¸p Tiªu lÇn nµy.");
    end
    -- È·¶¨·ÅÆúÈÎÎñ »¹Î´Ë¢³öïÚ³µ
    if (nSelId == 5) then
        SetTask(TSK_LMBJTaskFlag, 0);
        Msg2Player("§· bá nhiÖm vô ¸p Tiªu lÇn nµy.");
        WriteYunBiaoLog(format("[Long M«n Tiªu Côc] Tµi kho¶n: %s, Nh©n vËt: %s, ID nhiÖm vô tõ bá: %d, CÊp sao: %d", GetAccount(), GetName(), nId, nLevel));
    end
end

function pActivity:saveTask(tbParam)
    local nId = tbParam[1];
    local bSwitch = tbParam[2];
    if (nId == nil or bSwitch == nil) then
        Msg2Player("NhËn tiªu thÊt b¹i");
        return nil;
    end
    SetTask(TSK_LMBJTaskFlag, nId*10+bSwitch);
    Msg2Player(format("Thµnh c«ng nhËn nhiÖm vô ¸p Tiªu %d Sao", self.tbBJPathLevel[nId][2]));
    AddStatData("lmbj_task_start");
    WriteYunBiaoLog(format("[Long M«n Tiªu Côc] Tµi kho¶n: %s, Nh©n vËt: %s, CÊp sao nhiÖm vô ¸p Tiªu nhËn: %d", GetAccount(), GetName(), self.tbBJPathLevel[nId][2]));
    -- Çå¿Õ1ÐÇ¡¢Ëæ»úÑºïÚÈÎÎñ
    SetTask(TSK_LMBJLowTskFlag, 0);
    SetTask(TSK_LMBJRanTskFlag, 0);
end

function pActivity:getChangeTaskFlag()
    local nIdx = 0;
    local nRandValue = random(1, 10000)
    local nCurValue = 0;
    for i = 2, getn(self.tbAllTask) do
        nCurValue = nCurValue + self.tbAllTask[i].nRate * 10000;
        if (nRandValue <= nCurValue) then
            nIdx = i;
            break;
        end
    end
    local nID = random(1, getn(self.tbAllTask[nIdx].tbID));
    local nTskID = self.tbAllTask[nIdx].tbID[nID];
    return nTskID*10 + random(0, 1);
end

function pActivity:getTaskFlagCallBack(nParam, ResultHandle)
    local nTaskFlagValue = random(2, 18)*10 + random(0, 1);
    if (OB_IsEmpty(ResultHandle) ~= 1) then
        nTaskFlagValue = ObjBuffer:PopObject(ResultHandle);
    end
    local nOldPlayerIndex = PlayerIndex;
    PlayerIndex = nParam;
    SetTask(TSK_LMBJRanTskFlag, nTaskFlagValue);
    self:CreateRandomTaskPanel(floor(nTaskFlagValue/10), mod(nTaskFlagValue,10));
    PlayerIndex = nOldPlayerIndex;
end

function pActivity:getBiaoChePosCallBack(nParam, ResultHandle)
    local tbCurCarPos = {-1, 0, 0, 0};
    if (OB_IsEmpty(ResultHandle) ~= 1) then
        tbCurCarPos = ObjBuffer:PopObject(ResultHandle);
    end
    local nOldPlayerIndex = PlayerIndex;
    PlayerIndex = nParam;
    if (tbCurCarPos==nil or tbCurCarPos[1]==-1) then
        Talk(1, "", "Tiªu Xa ®· bÞ ph¸ hñy hoÆc biÕn mÊt, kh«ng thÓ truyÒn tèng");
        PlayerIndex = nOldPlayerIndex;
        return nil;
    end
    -- ÉèÖÃ±¾´Î´«³µÊ±¼ä
    SetTask(TSK_TransCarTime, GetCurrentTime());
    -- ¿ÛÇ®
    Pay(10000);
    -- ´«ËÍµ½ïÚ³µÎ»ÖÃ
    SetFightState(tbCurCarPos[4]);
    NewWorld(tbCurCarPos[1], tbCurCarPos[2], tbCurCarPos[3]);
    PlayerIndex = nOldPlayerIndex;
end

function pActivity:getCheckBiaoCheCallBack(nParam, ResultHandle)
    local tbCurCarPos = {-1, 0, 0, 0};
    if (OB_IsEmpty(ResultHandle) ~= 1) then
        tbCurCarPos = ObjBuffer:PopObject(ResultHandle);
    end
    local nOldPlayerIndex = PlayerIndex;
    PlayerIndex = nParam;
    -- »ñÈ¡ÑºïÚÈÎÎñÐÅÏ¢
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    local nId = floor(nTaskFlagValue/10); -- ÑºïÚÂ·ÏßID
    local bFlag = mod(nTaskFlagValue,10); -- ÊÇ·ñ½»»»ÆðÊ¼µã
    local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
    local szTitleMsg = "";
    local tbOpt = {};
    if (tbCurCarPos[1] == -1 or nPassTime >= 1800) then
        szTitleMsg = "<npc>Tiªu Xa cña ng­¬i ®· biÕn mÊt hoÆc bÞ ph¸ hñy, cã ph¶i kÕt thóc nhiÖm vô lÇn nµy?";
        tinsert(tbOpt, {"X¸c nhËn", self.onConfirmProcess, { self, 4, {nId, bFlag} },});
    else
        szTitleMsg = format("<npc>Tiªu Xa cña b¹n ®ang dõng ë b¶n ®å %s(%s/%s).", tbGlobalMapId2Name[tbCurCarPos[1]], floor(tbCurCarPos[2]/8), floor(tbCurCarPos[3]/16));
    end
    tinsert(tbOpt, {"Rêi khái", self.onConfirmProcess, { self, 0, {nil} },});
    CreateNewSayEx(szTitleMsg, tbOpt);
    PlayerIndex = nOldPlayerIndex;
end

function pActivity:viewTaskInforCallBack(nParam, ResultHandle)
    local tbCurCarPos = {-1, 0, 0, 0};
    if (OB_IsEmpty(ResultHandle) ~= 1) then
        tbCurCarPos = ObjBuffer:PopObject(ResultHandle);
    end
    local nOldPlayerIndex = PlayerIndex;
    PlayerIndex = nParam;
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    local nId = floor(nTaskFlagValue/10);
    local nFlag = mod(nTaskFlagValue, 10);
    local tbPath = self.tbBJPathLevel[nId][1]; -- ÑºïÚÂ·Ïß
    local nLevel = self.tbBJPathLevel[nId][2]; -- ÑºïÚµÈ¼¶
    local nSid = tbPath[1];
    local nEid = tbPath[2];
    if nFlag == 1 then
        nSid, nEid = nEid, nSid;
    end
    -- ÑºïÚÐÅÏ¢
    local szTitleMsg = format("<npc><enter>Lé tr×nh ¸p Tiªu: %s-%s<enter>CÊp nhiÖm vô: %d Sao", self.tbBJPoints[nSid][1], self.tbBJPoints[nEid][1], nLevel);
    local szTempLine = "";
    -- ÈÎÎñ×´Ì¬
    if (tbCurCarPos==nil or tbCurCarPos[1]==-1) then -- ïÚ³µÏûÊ§
        szTempLine = "<enter>Tr¹ng th¸i nhiÖm vô: Tiªu Xa ®· biÕn mÊt, nhiÖm vô kÕt thóc.";
    else
        local nPassTime =  GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
        szTempLine = format("<enter>Tr¹ng th¸i nhiÖm vô: §Õm ng­îc kho¶ng %d phót", 30-floor(nPassTime/60));
    end
    local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
    if ( nPassTime >= 1800) then -- ¼ì²éïÚ·þÎñÆ÷å´»úïÚ³µÒ»Ö±´æÔÚ³¬Ê±ÖÕÖ¹
        szTempLine = "<enter>Tr¹ng th¸i nhiÖm vô: Tiªu Xa ®· biÕn mÊt, nhiÖm vô kÕt thóc.";
    end
    szTitleMsg = szTitleMsg..szTempLine;
    -- ½ñÈÕÑºïÚÈÎÎñ´ÎÊý
    local nDailyTaskNum = self:GetTaskDailyA(TSK_DailyTaskNum);
    szTempLine = format("<enter>Sè lÇn nhiÖm vô ¸p Tiªu h«m nay: %d/3", nDailyTaskNum);
    szTitleMsg = szTitleMsg..szTempLine;
    -- ½ñÈÕÃâ·ÑË¢ÐÂÈÎÎñ´ÎÊý
    local nDailyFreeCount = self:GetTaskDailyA(TSK_DailyFreeCount);
    szTempLine = format("<enter>Sè lÇn lµm míi nhiÖm vô miÔn phÝ h«m nay: %d/5", nDailyFreeCount);
    szTitleMsg = szTitleMsg..szTempLine;
    local tbOpt = {};
    tinsert(tbOpt, {"Rêi khái", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
    PlayerIndex = nOldPlayerIndex;
end

-- ´«ËÍµ½ÑºïÚ
function pActivity:transToBeginPos(tbParam)
    local nId = tbParam[1];
    local bSwitch = tbParam[2];
    if (nId == nil or bSwitch == nil) then
        return nil;
    end
    local tbCurPath = self.tbBJPathLevel[nId][1];
    local nSid = tbCurPath[1+bSwitch];
    local tbPos = self.tbBJPoints[nSid][2];
    SetTask(TSK_LMBJTaskTime, 0);
    SetTask(TSK_LMBJCarIndex, 0);
    NewWorld(tbPos[1], tbPos[2], tbPos[3]);
end

-- ÒªÊµÏÖ³µÈË²»ÔÚÍ¬Ò»Ì¨GSÏÂ»ñÈ¡³µµÄÎ»ÖÃ
function pActivity:getCurrentCarPos()
    -- ³µ¡¢ÈËÔÚÍ¬Ò»Ì¨GSÏÂ
    local nX32, nY32, nMapIdx = GetBiaoChePos();
    if (nMapIdx == -1) then
        return 0, 0, -1;
    end

    return nX32, nY32, nMapIdx;
end

function pActivity:refreshBiaoChe(nSuriveTime)
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        return nil;
    end
    local szTongName, nTongId = GetTongName();
    -- »ñÈ¡ÑºïÚÈÎÎñÐÅÏ¢
    local nId = floor(nTaskFlagValue/10);       -- ÑºïÚÂ·ÏßID
    local nLevel = self.tbBJPathLevel[nId][2];  -- ÑºïÚµÈ¼¶
    -- »ñÈ¡ïÚ³µÐÅÏ¢
    local nNpcSettingID = self:getBiaoCheNpcSettingId(nLevel);
    local szPlayerName = GetName();
    local szCarName = format("%s-Tiªu Xa %d Sao", szPlayerName, nLevel);
    local szScriptPath = "\\script\\activitysys\\config\\129\\npc_lmbiaoche.lua";
    if nLevel >= 10 then
        szCarName = format("Tiªu Xa bang cña [%s]%s", szTongName, szPlayerName);
        szScriptPath = "\\script\\activitysys\\config\\129\\npc_lmbiaoche.lua";
    end
    local nNpcIndex = CreateBiaoChe(random(1,4), nNpcSettingID, 95, szCarName, nSuriveTime*18);
    SetNpcParam(nNpcIndex, 1, nLevel);
    local nHashValue = String2Id(szPlayerName); -- ½«Íæ¼Ò½ÇÉ«ÃûµÄHashÖµ±£´æ
    local nHash1 = floor(nHashValue/2);
    local nHash2 = nHashValue - nHash1;
    SetNpcParam(nNpcIndex, 2, nHash1);
    SetNpcParam(nNpcIndex, 3, nHash2);
--    SetNpcParam(nNpcIndex, 4, TaskStartTime);
    nHash1 = floor(nTongId / 2);
    nHash2 = nTongId - nHash1;
    SetNpcParam(nNpcIndex, 5, nHash1);
    SetNpcParam(nNpcIndex, 6, nHash2);
    SetNpcScript(nNpcIndex, szScriptPath);
    SetTask(TSK_LMBJCarIndex, nNpcIndex); --ÉèÖÃïÚ³µIndex
    if nLevel >= 10 then
        SetNpcTimer(nNpcIndex, 18*60);
    end
end

function pActivity:getBiaoCheNpcSettingId(nLevel)
    local tbSettingIDbyLevel = {
        [1] = 2146,
        [2] = 2146,
        [3] = 2146,
        [4] = 2147,
        [5] = 2147,
        [6] = 2147,
        [7] = 2148,
        [8] = 2148,
        [9] = 2148,
        [10] = 2233,
    }
    return tbSettingIDbyLevel[nLevel];
end

function pActivity:updateRelayData(nTskID)
    local nLevel = self.tbBJPathLevel[nTskID][2];
    if (nLevel == nil or nLevel < 7) then
        return nil;
    end
    if (self:GetTaskDailyA(TSK_DailyFreeCount) >= 5) then
        return nil;
    end
    local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
    local handle = OB_Create();
    ObjBuffer:PushObject(handle, nLevel);
    RemoteExecute(szRemotePath, "tbLMBJActivityData:g2s_SaveTaskFlag", handle);
    OB_Release(handle);
end

--------------------------------------------°ï»áÑºïÚÈÎÎñ½Ó¿Ú--------------------------------------------
function pActivity:GetOccupyTongId()
    local tbMainCity = {
        [1]     = 1,    -- ·ïÏè
        [11]    = 2,    -- ³É¶¼
        [162]   = 3,    -- ´óÀí
        [37]    = 4,    -- ãê¾©
        [78]    = 5,    -- ÏåÑô
        [80]    = 6,    -- ÑïÖÝ
        [176]   = 7,    -- ÁÙ°²
    };
    local nMapID = GetWorldPos();
    if not tbMainCity[nMapID] then
        return 0;
    end
    local szOccTongName = GetCityOwner(tbMainCity[nMapID]);
    if szOccTongName == "" then
        return 0;
    end
    return TONG_Name2ID(szOccTongName), szOccTongName;
end

-- °ï»áÑºïÚÈÕÖ¾
function pActivity:WriteTongYBLog(szLog)
    if not szLog then
        WriteYunBiaoLog("!!!!!!!!!!!!!!!Log trèng!!!!!!!!!!!!!!!");
        return 0;
    end
    local szWriteLog = "";
    if PlayerIndex and PlayerIndex > 0 then
        local szTongName = GetTongName();
        szWriteLog = format("[Long M«n Tiªu Côc_¸p Tiªu Bang] Bang: %s, Tµi kho¶n: %s, Tªn nh©n vËt: %s, Chøc vÞ: %s %s", szTongName, GetAccount(), GetName(), GetTongFigureStr(), szLog);
    else
        szWriteLog = format("[Long M«n Tiªu Côc_¸p Tiªu Bang] Bang: !!! Tµi kho¶n: !!! Tªn nh©n vËt: !!! Chøc vÞ: !!! %s", szLog);
    end
    WriteYunBiaoLog(szWriteLog);
end

-- ¼ì²éÊÇ²»ÊÇÑºïÚÈË
function pActivity:IsTraner()
    local szTongName, nTongId = GetTongName()
    if nTongId == 0 then
        return nil;
    end
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if nTaskFlagValue == 0 then
        return nil;
    end
    local nId = floor(nTaskFlagValue/10); -- ÑºïÚÂ·ÏßID
    local nLevel = self.tbBJPathLevel[nId][2];  -- ÑºïÚµÈ¼¶
    if nLevel < 10 then
        return nil;
    end
    return 1;
end

-- ¼ì²éÈë°ïÌìÊý
function pActivity:CheckJoinTongDays(nDay)
    local nDayTime = nDay * 24 * 60;
    local nJoinTime = GetJoinTongTime();

    if nJoinTime >= nDayTime then
        return 1
    end
    return nil;
end

-- ¼ì²é°ïÖ÷ÄÜ·ñÍËÎ»
function pActivity:CheckCanChangeMaster()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return 0;
    end
    if self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE) == 1 then
        Talk(1, "", "§· më ho¹t ®éng ¸p Tiªu Bang tuÇn nµy, kh«ng thÓ chÊp hµnh bang chñ tho¸i vÞ.");
        return 0;
    end
    return 1;
end

-- ¼ì²éÄÜ·ñÌß³önTongId°ïµÄszKickName
function pActivity:CheckCanKick(nTongId, szKickName)
    local nPassTime = GetCurrentTime() - TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_TIME);
    if nPassTime >= 1800 then
        return 1;
    end
    local dwKickHash = String2Id(szKickName);
    if self:GetCurExecutorHash(nTongId) == dwKickHash and nPassTime < 1800 then
        --Talk(1, "", format("<color=red>%s<color>ÒÑ½ÓÈ¡µÄ¹ó°ïµÄ°ï»áÑºïÚÈÎÎñ£¬²»ÄÜ¶ÔËûÖ´ÐÐÌß³ö°ï»á²Ù×÷¡£", szKickName));
        Talk(1, "", format("<color=red>%s<color> ®· nhËn nhiÖm vô ¸p tiªu bang héi cña quý bang, kh«ng thÓ ph¶n béi bang héi.", szKickName));
        return 0;
    end
    return 1;
end

-- ¼ì²éÄÜ·ñÍË°ï
function pActivity:CheckCanLeaveTong()
    local nTaskValue = GetTask(TSK_LMBJTaskFlag);
    if nTaskValue == 0 then
        return 1;
    end
    local nID = floor(nTaskValue/10);
    local nLevel = self.tbBJPathLevel[nID][2]; -- ÑºïÚµÈ¼¶
    local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
    if nLevel >= 10 and nPassTime < 1800 then
        Talk(1, "", "§· nhËn nhiÖm vô ¸p Tiªu Bang, kh«ng thÓ rêi bang.");
        return 0;
    end
    return 1;
end

-- »ñÈ¡ÖÜÇå¿Õ°ï»áÈÎÎñ±äÁ¿Öµ
function pActivity:GetTongWeekTaskValue(nTongId, nTaskId)
    if nTongId == 0 or nTaskId == 0 then
        return 0;
    end
    local nCurYearWeek = tonumber(GetLocalDate("%Y%W"));
    local nTaskValue = TONG_GetTaskValue(nTongId, nTaskId);
    local nMemDate = floor(nTaskValue / 100);
    local nMemValue = mod(nTaskValue, 100);
    if nMemDate ~= nCurYearWeek then
        nMemValue = 0;
        TONG_ApplySetTaskValue(nTongId, nTaskId, nCurYearWeek*100);
    end
    return nMemValue;
end

function pActivity:SetTongWeekTaskValue(nTongId, nTaskId, nValue)
    if nTongId == 0 or nTaskId == 0 then
        return nil;
    end
    local nCurYearWeek = tonumber(GetLocalDate("%Y%W"));
    local nTaskValue = nCurYearWeek*100 + mod(nValue, 100);
    TONG_ApplySetTaskValue(nTongId, nTaskId, nTaskValue);
end

function pActivity:AddTongWeekTaskValue(nTongId, nTaskId, nValue)
    if nTongId == 0 or nTaskId == 0 then
        return nil;
    end
    local nCurYearWeek = tonumber(GetLocalDate("%Y%W"));
    local nTaskValue = TONG_GetTaskValue(nTongId, nTaskId);
    local nMemDate = floor(nTaskValue / 100);
    local nMemValue = mod(nTaskValue, 100);
    if nMemDate ~= nCurYearWeek then
        nMemValue = 0;
    end
    nMemValue = nMemValue + nValue;
    if nMemValue < 0 then
        nMemValue = 0;
    end
    local nTaskValue = nCurYearWeek*100 + mod(nMemValue, 100);
    TONG_ApplySetTaskValue(nTongId, nTaskId, nTaskValue);
end

function pActivity:SetCurExecutorHash(nTongId, szExecutorName)
    local dwHashValue = String2Id(szExecutorName);
    local nHash1 = floor(dwHashValue/2);
    local nHash2 = dwHashValue - nHash1;
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_MEMBER_HASH1, nHash1);
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_MEMBER_HASH2, nHash2);
end

function pActivity:GetCurExecutorHash(nTongId)
    if nTongId == 0 then
        return 0;
    end
    local nHash1 = TONG_GetTaskValue(nTongId, TONG_TASK_MEMBER_HASH1);
    local nHash2 = TONG_GetTaskValue(nTongId, TONG_TASK_MEMBER_HASH2);
    return (nHash1+nHash2);
end

function pActivity:GetFollowAwardCount(nTaskIndex)
    local nTaskValue = GetTask(nTaskIndex);
    local nWeekIdx = floor(nTaskValue/1000);
    local nCount = mod(nTaskValue, 1000);
    local nCurWeekIdx = tonumber(date("%W"));
    if nWeekIdx == nCurWeekIdx then  -- ÖÜ´ÎÒ»Ñù£¬ÖµÓÐÐ§·µ»ØnCount
        return nCount;
    end
    local nCurWeek = tonumber(date("%w"));
    if nCurWeek > 0 and nCurWeek < 6 then -- ÖÜ´Î²»Ò»Ñù£¬ÔÚÐÇÆÚÒ» ~ ÐÇÆÚÎåÖ®¼ä 
        if nWeekIdx + 1 == nCurWeekIdx or nCurWeekIdx < nWeekIdx then -- ÖÜ´ÎÏà²î1»òÕß¿çÄêÖµÓÐÐ§
            return nCount;
        end
    end
    -- ÆäËûÇé¿öÖµÎÞÐ§ ·µ»Ø 0
    return 0;
end

function pActivity:AddFollowAwardCount(nTongId)
    local nTaskIndex = TSK_WeekFollowCount + self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT);
    local nTaskValue = GetTask(nTaskIndex);
    local nWeekIdx = floor(nTaskValue/1000);
    local nCount = mod(nTaskValue, 1000);
    local nCurWeekIdx = tonumber(date("%W"));
    if nWeekIdx ~= nCurWeekIdx and nCurWeekIdx ~= 0 then
        nCount = 0;
    end
    nCount = nCount + 1;
    SetTask(nTaskIndex, nCurWeekIdx*1000+mod(nCount, 1000));
end

function pActivity:ClearFollowAwardCount()
    for i = 0, 3 do
        SetTask(TSK_WeekFollowCount+i, 0);
    end
end

-- ÁìÈ¡°ï»áÑºïÚÍÅÌå½±Àø
function pActivity:GetTongAward()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return nil;
    end
    local nAwardCount = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_AWARD);
    if nAwardCount <= 0 then
        Talk(1, "", "R­¬ng ¸p Tiªu Bang lµ 0, kh«ng cã phÇn th­ëng cã thÓ nhËn");
        return nil;
    end
    if nAwardCount > 50 then
        nAwardCount = 50;
    end
    g_AskClientNumberEx(1, nAwardCount, "Sè l­îng nhËp: ", {self.GetTongAwardCallBack, {self, 1, nAwardCount, szTongName, nTongId, TONG_TASK_YABIAO_AWARD}} );
    return 1;
end
function pActivity:GetTongAwardCallBack(nMin, nMax, szTongName, nTongId, nTongTaskId, nCount)
    -- ¼ì²éÊäÈë
    if (nCount < nMin or nCount > nMax) then
        Msg2Player("Sè l­îng nhËp v« hiÖu, h·y nhËp l¹i!");
        return nil;
    end
    -- ¶þ´Î¼ì²éÊÇ²»ÊÇ°ïÖ÷
    if CheckIsMaster() ~= 1 then
        return nil;
    end
    -- ÅÐ¶Ï±³°ü¿Õ¼ä
    local nMinCells = nCount * 5;
    local szErrorTips = format("Tói kh«ng ®ñ chç, ®¶m b¶o cã %d « trèng h·y ®Õn.", nMinCells);
    if PlayerFunLib:CheckFreeBagCell(nMinCells, szErrorTips) ~= 1 then
        return nil;
    end
    TONG_ApplyAddTaskValue(nTongId, nTongTaskId, -nCount);
    -- ¸ø°ï»á×Ê½ð
    local nNum = 0;
    for i = 1, nCount do
        --AddTongMoney(szTongName, 60000000);
        if random(1,100) > 50 then
            nNum = nNum + 1;
        end
    end
    --local szTongMsg = format("¹§Ï²¹ó°ï»ñµÃ:%d¸ö³¯Í¢ÉâÊé, %d¸öÐÖµÜÇéÉî, %sW°ï»á×Ê½ð¡£", nCount, nCount*5, nCount*6000);
    local tbAwardList = self.tbAward["tongaward"][2];
    --if nNum > 0 then
        --local tbItem = self.tbAward["tongaward"][1];
        --local nNumber = 65535;
        --local nTongHash1 = mod(nTongId, nNumber);
        --local nTongHash2 = floor(nTongId/nNumber);
        --tbItem[1].tbParam = {nTongHash1, nTongHash2, nNumber};
        --tbItem[1].nCount = nNum;
        --tbAwardTemplet:GiveAwardByList(tbItem, "[ÁúÃÅïÚ¾Ö_°ï»áÑºïÚ] °ïÖ÷ÁìÈ¡ÑºïÚ½±Àø_ÕóÓª¸ü»»¸£ÀûÊé");
        --szTongMsg = format("¹§Ï²¹ó°ï»ñµÃ:%d¸ö³¯Í¢ÉâÊé, %d¸öÕóÓª¸ü»»¸£ÀûÊé, %d¸öÐÖµÜÇéÉî, %sW°ï»á×Ê½ð¡£", nCount, nNum, nCount*5, nCount*6000);
    --end
    tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M«n Tiªu Côc_¸p Tiªu Bang] Bang chñ nhËn phÇn th­ëng ¸p Tiªu", nCount);
    --Msg2Tong(nTongId, szTongMsg);
    --Msg2Tong(nTongId, "´óÁ¿°ï»á×Ê½ðÕýÔÚÔËËÍÍ¾ÖÐ,½«»áÔÚ10·ÖÖÓÄÚÔö¼Óµ½°ï»áÕËÄ¿,ÇëÉÔµÈ¡£");
    -- ÈÕÖ¾
    local szLogs = format("NhËn %d phÇn th­ëng nhãm ¸p Tiªu Bang", nCount);
    self:WriteTongYBLog(szLogs);
end

-- ¸ø»¤ËÍïÚ³µ¾­Ñé
function pActivity:AddFollowExp(nTongId)
    local szTongName, nMyTongId = GetTongName();
    -- Ã»ÓÐÈë°ïµÄ²»¸ø
    if nMyTongId == 0 then
        return nil;
    end
    -- ²»ÊôÓÚïÚ³µËùÔÚ°ï»áµÄ²»¸ø
    if nMyTongId ~= nTongId then
        return nil;
    end
    -- ¼ì²éÈë°ïÊ±¼ä
    if self:CheckJoinTongDays(7) ~= 1 then
        return nil;
    end
    
    --·ÇÕ½¶·×´Ì¬²»¸ø
    if GetFightState() == 0 then
    	return
    end
    -- ¸ø¾­Ñé
    PlayerFunLib:AddExp(4000000, 1, "[Long M«n Tiªu Côc_¸p Tiªu Bang] Hé tèng Tiªu Xa nhËn kinh nghiÖm.");
    self:AddFollowAwardCount(nTongId);
end

function pActivity:HandInBiaoCheBox()
    -- ¼ì²éÊÇ·ñÈë°ï
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        Talk(1, "", "Ch­a vµo bang, kh«ng thÓ nép R­¬ng Tiªu Xa Bang.");
        return nil;
    end
    -- ¼ì²éÈë°ïÊ±¼ä
    if self:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "§¹i hiÖp vµo bang ch­a ®ñ 7 ngµy, kh«ng thÓ nép R­¬ng Tiªu Xa Bang.");
        return nil;
    end

    g_GiveItemUI("Nép R­¬ng Tiªu Xa Bang", "§Æt vµo R­¬ng Tiªu Xa Bang", {self.PutBiaoCheBox, {self, TONG_TASK_YABIAO_AWARD}}, {}, 1);
end

function pActivity:PutBiaoCheBox(nTongTaskId, nCount)
    if nCount < 1 then
        Msg2Player("H·y ®Æt vµo R­¬ng Tiªu Xa Bang muèn nép.");
        return nil;
    end
    -- ¼ì²éÈë°ïÊ±¼ä
    if self:CheckJoinTongDays(7) ~= 1 then
        Msg2Player("Nép R­¬ng Bang thÊt b¹i, h·y thö l¹i.");
        return nil;
    end
    local bCheckResult = 1;
    for i = 1, nCount do
        local nItemIndex = GetGiveItemUnit(i);
        local  nG, nD, nP = GetItemProp(nItemIndex);
        if nP ~= 4475 then
            bCheckResult = 0;
            break;
        end
    end
    if bCheckResult == 0 then
        Talk(1, "", "ChØ cã thÓ nép R­¬ng Tiªu Xa Bang, kh«ng ®Æt vËt phÈm kh¸c.");
        return nil;
    end
    -- ¼ì²éµÀ¾ßºÏ·¨ÐÔ
    local nCurDate = tonumber(GetLocalDate("%Y%m%d"));
    local nExpired = 0;
    local nSuccess = 0;
    for i = 1, nCount do
        local nItemIndex = GetGiveItemUnit(i);
        local nG, nD, nP = GetItemProp(nItemIndex);
        if nP == 4475 then
            local nStackCount = GetItemStackCount(nItemIndex);
            local nMemDate = self:GetItemExpiredTime(nItemIndex);
            if nCurDate >= nMemDate then
                nExpired = nExpired + nStackCount;
            else
                nSuccess = nSuccess + nStackCount;
            end
            RemoveItemByIndex(nItemIndex);
        end
    end

    if nSuccess == 0 and nExpired == 0 then
        return nil;
    end
    -- ¼Ç°ï»áÈÎÎñ±äÁ¿
    local szTongName, nTongId = GetTongName();
    TONG_ApplyAddTaskValue(nTongId, nTongTaskId, nSuccess);
    local szTips = format("Thµnh c«ng nép R­¬ng ¸p Tiªu Bang “%s” %d c¸i, qu¸ h¹n xãa %d c¸i.", szTongName, nSuccess, nExpired);
    Talk(1, "", szTips);
    -- ÈÕÖ¾Âñµã
    AddStatData("bhyb_upload_count", nSuccess);
    local szLogs = format("Nép R­¬ng ¸p Tiªu: %d c¸i, qu¸ h¹n xãa %d c¸i", nSuccess, nExpired);
    self:WriteTongYBLog(szLogs);
end

