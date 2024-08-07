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

-- 帮会贡献度处理文件
Include("\\script\\tong\\tong_award_head.lua")

IncludeLib("TIMER")

pActivity.nPak = curpack();

-- 这里修改 记得同步修改 \\script\\global\\yunbiao_system.lua OnBiaoCheChangeMapNotice 中对应的 tbBiaoCheLevel
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
    -- 帮会押镖
    -- 扬州
	[27] = {{15, 16}, 10,},
	[28] = {{15, 17}, 10,},
	[29] = {{15, 18}, 10,},
    -- 临安
	[30] = {{19, 20}, 10,},
	[31] = {{19, 21}, 10,},
	[32] = {{19, 22}, 10,},
	-- 汴京
    [33] = {{23, 24}, 10,},
	[34] = {{23, 25}, 10,},
	[35] = {{23, 26}, 10,},
	[36] = {{23, 27}, 10,},
    -- 成都
    [37] = {{28, 29}, 10,},
	[38] = {{28, 30}, 10,},
	[39] = {{28, 31}, 10,},
	[40] = {{28, 32}, 10,},
    -- 襄阳
    [41] = {{33, 34}, 10,},
	[42] = {{33, 35}, 10,},
	[43] = {{33, 36}, 10,},
    -- 凤翔
	[44] = {{37, 38}, 10,},
	[45] = {{37, 39}, 10,},
	[46] = {{37, 40}, 10,},
    -- 大理
	[47] = {{41, 42}, 10,},
	[48] = {{41, 43}, 10,},
	[49] = {{41, 44}, 10,},
}
pActivity.tbAllTask = {
        {nRate = 0,        tbID = {1} },            --1星 不参与随机，占位用
        {nRate = 0.149,    tbID = {2,3,4,5,6,7,}},  --2星
        {nRate = 0.3,      tbID = {8,9,}},          --3星
        {nRate = 0.3,      tbID = {10,11,}},        --4星
        {nRate = 0.15,     tbID = {12,13,14,15,}},  --5星
        {nRate = 0.05,     tbID = {16,17,18,}},     --6星
        {nRate = 0.04,     tbID = {19,20,21,22,}},  --7星
        {nRate = 0.01,     tbID = {23,24,25,}},     --8星
        {nRate = 0.001,    tbID = {26,}},           --9星
    }

pActivity.tbBJPoints = {
	[1] = {"L﹎ An Nam (181,208)", {176, 1448, 3335},},
	[2] = {"L﹎ An B綾 (191,185)", {176, 1534, 2974},},
	[3] = {"Th祅h Й (382,312)", {11, 3061, 4992},},
	[4] = {"Th玭 Giang T﹏ (439,385)", {20, 3516, 6164},},
	[5] = {"Tng Dng (192,198)", {78, 1537, 3182},},
	[6] = {"Чo Hng Th玭 (203,200)", {101, 1625, 3209},},
	[7] = {"Dng Ch﹗ (223,189)", {80, 1786, 3037},},
	[8] = {"Чi L� (204,200)", {162, 1639, 3215},},
	[9] = {"Th筩h C� Tr蕁 (209,202)", {153, 1677, 3240},},
	[10] = {"Phng Tng (199,193)", {1, 1597, 3093},},
	[11] = {"V躰h L筩 Tr蕁 (209,201)", {99, 1673, 3229},},
	[12] = {"Bi謓 Kinh (211,196)", {37, 1690, 3150},},
	[13] = {"Chu Ti猲 Tr蕁 (202,194)", {100, 1622, 3113},},
	[14] = {"Th玭 Long Tuy襫 (199,204)", {174, 1596, 3271},},
    -- 帮会押镖
    [15] = {" Dng Ch﹗", {80,1678,3147},},
    [16] = {"Tng V﹏ чng", {116,1741,3031},},
    [17] = {"Ti課 C骳 ng", {93, 1620,3182},},
    [18] = {"Linh C鑓 ng", {94, 1638,3106},},
    
    [19] = {" L﹎ An", {176,1399,3140},},
    [20] = {"Lng Th駓 чng", {181,1627,3052},},
    [21] = {"Long Cung чng", {180,1548,3176},},
    [22] = {"Nghi謙 Long чng", {182,2107,3412},},
    
    [23] = {" Bi謓 Kinh", {37,1703,3019},},
    [24] = {"Thi猲 T﹎ ng", { 42,1642,3029},},
    [25] = {"Thi猲 Nh蒼 Gi竜", { 45,1702,3076},},
    [26] = {"Phi Thi猲 ng", {204,1621,3375},},
    [27] = {"Thi誹 L﹎ ph竔", {103,1638,2930},},
    
    [28] = {" Th祅h Й", {11,3205,5078},},
    [29] = {"Nh筺 Th筩h ng", { 10,1778,3065},},
    [30] = {"Th莕 Ti猲 ng", { 23,1854,3123},},
    [31] = {"B筩h V﹏ ng", { 22,1865,3274},},
    [32] = {"чng Kinh Ho祅g", {  5,1597,3592},},

    [33] = {" Tng Dng", {78,1569,3280},},
    [34] = {"K� Qu竛 ng", { 91,1602,2810},},
    [35] = {"Kh醓 Lang чng", { 83,1660,2924},},
    [36] = {"Dng Trung ng", {205,1587,3221},},

    [37] = {" Phng Tng", {1,1559,3258},},
    [38] = {"B╪g H� ng", {201,1736,3235},},
    [39] = {  " Hoa S琻", {  2,2406,3713},},
    [40] = {"чng Kim Quang", {  4,1672,3096},},
    
    [41] = {" Чi L� ", {162,1650,3247},},
    [42] = {"Ph鬾g Nh穘 чng", {168,1653,3138},},
    [43] = {"觤 Thng чng", {171,1494,2982},},
    [44] = {"V� Danh ng", {203,1505,3102},},
}

pActivity.nTaskGuideId = 14 --在\settings\task\taskguide.txt配置文件中的唯一id
pActivity.nTaskGuideType = 2 --在任务指南系统中属于日常任务

-- 服务器启动事件
function pActivity:ServerStartCall()

end

-- 玩家跨服登陆事件
function pActivity:PlayerExchageServerLoginInit()
    -- 检查任务变量
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        --Talk(1, "", "侠士没有接受押镖任务，怎么能领取奖励呢？");
        return nil;
    end
    -- 取标记
    if (GetTask(TSK_RefreshBiaoChe) == 0) then
        return nil;
    end
    -- 刷出镖车
    local nSuriveTime = 1800 - (GetCurrentTime() - GetTask(TSK_LMBJTaskTime));
    if (nSuriveTime <= 0) then
        return nil;
    end
    self:refreshBiaoChe(nSuriveTime);
    -- 设置镖车血量
    local nCurCarIndex = GetTask(TSK_LMBJCarIndex);
    if (nCurCarIndex <= 0) then
        return nil;
    end
    SetNpcParam(nCurCarIndex, 4, GetTask(TSK_LMBJTaskTime));
    SetNpcCurLife(nCurCarIndex, GetTask(TSK_BiaoCheLife));
    DynamicExecuteByPlayer(PlayerIndex, "\\script\\global\\yunbiao_system.lua", "OnBiaoCheChangeMapNotice");
    -- 清除跨服刷车标记
    SetTask(TSK_RefreshBiaoChe, 0);
end

-- 玩家跨服退出事件
function pActivity:PlayerExchageServerLoginOut_BeforeSaveData()
    if GetPlayerEnteringTrap() == 0 then --玩家不是踩trap跨的地图
        return nil;
    end
    -- 检查任务
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        return nil;
    end
    -- 检查镖车位置
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
    -- 保存镖车信息_血量
    local nBiaoCheNpcIndex = GetTask(TSK_LMBJCarIndex)
    if nBiaoCheNpcIndex <= 0 then
        return nil;
    end
    SetTask(TSK_BiaoCheLife, GetNpcLife(GetNpcId(nBiaoCheNpcIndex)));
    -- 设置跨服刷镖车标记
    SetTask(TSK_RefreshBiaoChe, 1);
    SetPlayerEnteringTrap(0);
    local szBiaoCheName = GetNpcName(nBiaoCheNpcIndex);
    if (DeleteBiaoChe() == 0) then
        WriteYunBiaoLog(format("T筰 %s(%d,%d) x鉧 [%s] th蕋 b筰.", tbGlobalMapId2Name[nPMapID], nPX, nPY, szBiaoCheName));
    end
end

function pActivity:PlayerExchageServerLoginOut()
--    if GetTask(TSK_RefreshBiaoChe) ~= 1 then
--        return nil;
--    end
--    -- 删除镖车
--    DeleteBiaoChe();
end

-- 日清空变量操作
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

-- 检查能否点击接受押镖任务
function pActivity:CheckReceiveTaskCondition()
    -- 条件判断：是否在押镖时段 10:00 ~ 23:00
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if (nCurTime>2300 or nCurTime<1000) then
        Talk(1, "", "Kh玭g trong th阨 gian 竝 ti猽 10:00-23:00, hi謕 s� h穣 quay l筰.");
        return nil;
    end
    -- 判断是不是白名玩家
    if (GetCamp() == 0) then
        Talk(1, "", "Sau khi gia nh藀 m玭 ph竔 h穣 n t譵 ta nh薾 nhi謒 v�.");
        return nil;
    end
    -- 条件判断：是否还有未完成的押镖任务
    local nTaskValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskValue ~= 0) then
        local nId = floor(nTaskValue/10);
        local nLevel = self.tbBJPathLevel[nId][2];
        local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
        if nLevel < 10 or nPassTime < 1800 then
            Talk(1, "", "Ngi  nh薾 nhi謒 v�, h穣 n緈 b総 th阨 gian");
            return nil;
        end
    end
    -- 条件判断：是否有未领的奖励
    if (CalcItemCount(-1, 6, 1, 4200, -1) > 0) then
        Talk(1, "", "Ngi c� ph莕 thng 竝 Ti猽 ch璦 nh薾, nh薾 xong r錳 quay l筰 y.");
        return nil;
    end

    return 1;
end

-- 处理点击接受1星押镖任务
function pActivity:ReceiveTaskLow()
    -- 条件判断：今日是否已完成3次押镖任务
    local nTaskValue = self:GetTaskDailyA(TSK_DailyTaskNum);
    if (nTaskValue >= 3) then
        Talk(1, "", "Hi謕 s� h玬 nay  ho祅 th祅h 3 l莕 竝 ti猽, ng祔 mai h穣 quay l筰.");
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
    if bFlag == 1 then -- 交换起点和终点
        nSid, nEid = nEid, nSid;
    end
    local nLevel = self.tbBJPathLevel[1][2];
    local szSName = self.tbBJPoints[nSid][1];
    local szEName = self.tbBJPoints[nEid][1];
    local szTitleMsg = format("<npc>Nhi謒 v� Ti猽 Xa 1 Sao, 甶觤 u %s-甶觤 cu鑙 %s, trong v遪g 30 ph髏 n n琲, ng �?", szSName, szEName);
    local tbOpt = {};
    tinsert(tbOpt, {"X竎 nh薾", self.onSelectProcess, {self, 1, {1,bFlag} }, });
    tinsert(tbOpt, {"R阨 kh醝", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
    return 1;
end

-- 处理点击接受随机押镖任务
function pActivity:ReceiveTaskRandom()
    -- 条件判断：今日是否已完成3次押镖任务
    local nTaskValue = self:GetTaskDailyA(TSK_DailyTaskNum);
    if (nTaskValue >= 3) then
        Talk(1, "", "Hi謕 s� h玬 nay  ho祅 th祅h 3 l莕 竝 ti猽, ng祔 mai h穣 quay l筰.");
        return nil;
    end
    local nTaskValue = GetTask(TSK_LMBJRanTskFlag);
    if (nTaskValue == 0) then
        -- 产生新的押镖路线
        local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
        local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
        DynamicExecute(szLocalPath, 
                    "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetTaskFlag", 0, 
                    "pActivity:getTaskFlagCallBack", PlayerIndex); -- 在回调函数中保存返回值
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
    local szTitleMsg = format("<npc>Nhi謒 v� Ti猽 Xa %d Sao, 甶觤 u %s-甶觤 cu鑙 %s, trong v遪g 30 ph髏 n n琲, ng �? Sau khi nh薾 kh玭g th� t筼 m韎 nhi謒 v�.", nLevel, szSName, szEName);
    local tbOpt = {};
    tinsert(tbOpt, {"Ti誴 nh薾",               self.onSelectProcess, { self, 2, {nId,bSwitch} },});
    tinsert(tbOpt, {"L祄 m韎 nhi謒 v� mi詎 ph�",       self.onSelectProcess, { self, 3, {nId,bSwitch} },});
    tinsert(tbOpt, {"D飊g Ho竛 Ti猽 Ch�  t筼 m韎 nhi謒 v�", self.onSelectProcess, { self, 4, {nId,bSwitch} },});
    tinsert(tbOpt, {"R阨 kh醝",               self.onSelectProcess, { self, 0, {nil} },});
    CreateNewSayEx(szTitleMsg, tbOpt);
end

-- 处理点击高级押镖任务
function pActivity:ReceiveTaskHigh()
    local szTitleMsg = "<npc>Ngi mu鑞 th� th竎h b秐 th﹏ nh薾 nhi謒 v� 竝 Ti猽 kh� nh蕋? Kh玭g c� th鵦 l鵦 th� kh玭g 頲, n誹 nh� ngi c� <color=red> 竝 ti猽 駓 nhi謒 tr筺g cao c蕄 <color> th� ta c� th� suy ngh� l筰.";
    local tbOpt = {};
    tinsert(tbOpt, {"S� d鬾g 竝 ti猽 駓 nhi謒 tr筺g cao c蕄", self.onSelectProcess, {self, 5, {nil}}});
    tinsert(tbOpt, {"R阨 kh醝", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
end

-- 处理点击领取押镖任务奖励
function pActivity:ReceiveAward(nNpcType)
    -- 条件判断：是否接了任务
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        local szTips = "Ngi v蒼 ch璦 nh薾 nhi謒 v� 竝 Ti猽, h穣 n Long M玭 Tr蕁 t譵 玭g ch� Y猰 M玭 甶.";
        if (nNpcType == 0) then
            szTips = "Ngi ch璦 nh薾 nhi謒 v� 竝 Ti猽.";
        end
        Talk(1, "", szTips);
        return nil;
    end
    -- 判断镖车是否出发
    if (GetTask(TSK_LMBJTaskTime) == 0) then
        Talk(1, "", "Ti猽 Xa c馻 ngi v蒼 ch璦 xu蕋 ph竧, mau 甶 n 甶觤 xu蕋 ph竧 t譵 Ti猽 S�  b総 u 甶.");
        return nil;
    end
    -- 获取押镖任务信息
    local nId = floor(nTaskFlagValue/10); -- 押镖路线ID
    local bFlag = mod(nTaskFlagValue,10); -- 是否交换起始点
    local tbPath = self.tbBJPathLevel[nId][1]; -- 押镖路线
    local nLevel = self.tbBJPathLevel[nId][2]; -- 押镖等级
    if nLevel >= 10 then
        Talk(1, "", "Hi謓 產ng nh薾 nhi謒 v� 竝 Ti猽 Bang, mau a Ti猽 Xa n Ti誴 D蒼 Ti猽 Xa Bang ch� nh.");
        return nil;
    end
    local tbCountCell = self.tbAllCountCell[nLevel];
    local tbAwardList = self.tbAward[nLevel];
    -- 是否有镖旗_有镖旗领低保
    local nBiaoQiCount = CalcItemCount(-1, 6, 1, 4200, -1);
    if nBiaoQiCount > 0 then
        tbCountCell = self.tbLowCountCell[nLevel];
        -- 检查背包空间
        local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", tbCountCell[2]);
        if PlayerFunLib:CheckFreeBagCell(tbCountCell[2], szTips) ~= 1 then
            return 0;
        end
        tongaward_longmenbiaoju();
        -- 修改押镖标记变量
        SetTask(TSK_LMBJTaskFlag, 0);
        for i = 1, nBiaoQiCount do
            ConsumeItem(-1, 1, 6, 1, 4200, -1); -- 扣除道具
        end
        DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", "yunbiao"); -- 给玩家增加活跃度
        tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M玭 Ti猽 C鬰] Ti猽 Xa b� cp nh薾 頲 ph莕 thng an 駃.", tbCountCell[1]);
        AddStatData("lmbj_task_over");
        WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] T礽 kho秐: %s, Nh﹏ v藅: %s, Ti猽 Xa b� cp nh薾 頲 ph莕 thng an 駃, ID nhi謒 v�: %d, C蕄 sao: %d", 
                                                            GetAccount(), GetName(), nId, nLevel));
        Talk(1, "", "Tuy l� Ti猽 Xa b� cp nh璶g c騨g may cp l筰 頲 Ti猽 K�, kh玭g c� c玭g c騨g c� s鴆, c� ch髏 ti襫 cho ngi mua ru h穣 nh薾 l蕐.");
        return 0;
    end
    -- 条件判断：镖车是否在玩家附近
    local nNpcIndex = GetLastDiagNpc();
    local nX32, nY32, nMapIdx = GetNpcPos(nNpcIndex);
    local nPX32, nPY32, nPMapIdx = self:getCurrentCarPos();
    if (IsBiaoCheAlive() == 1 and nMapIdx == nPMapIdx) then -- 镖车在玩家附近
        local nEPosId = tbPath[2-bFlag];            -- 押镖路线的终点ID
        local tbPos = self.tbBJPoints[nEPosId][2];  -- 终点镖师坐标
        -- 条件判断：对话NPC是不是终点NPC
        if ((nX32 ~= tbPos[2]*32) or (nY32 ~= tbPos[3]*32)) then
            Talk(1, "", "Чi hi謕 甶 sai 阯g r錳, mau ch鉵g h� t鑞g Ti猽 Xa n a 甶觤 ch輓h x竎.");
            return nil;
        end
        -- 条件判断：镖车是否在终点NPC附近600码之内
        if (sqrt((nX32-nPX32)*(nX32-nPX32) + (nY32-nPY32)*(nY32-nPY32)) > 600) then
            Talk(1, "", "Ti猽 Xa kh玭g c� � b猲 c筺h, mau 甶 t譵 xem.");
            return nil;
        end
        -- 检查背包空间
        local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", tbCountCell[2]+1);
        if PlayerFunLib:CheckFreeBagCell(tbCountCell[2]+1, szTips) ~= 1 then
            return nil;
        end
        tongaward_longmenbiaoju();
        -- 删除镖车
        DeleteBiaoChe();
        -- 修改押镖标记变量
        SetTask(TSK_LMBJTaskFlag, 0);
        -- 给奖励
        DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", "yunbiao"); -- 给玩家增加活跃度
        tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M玭 Ti猽 C鬰] 竝 ti猽 th祅h c玭g nh薾 頲 to祅 b� ph莕 thng.", tbCountCell[1]);
        local tbAwardItem = {szName = "H� Ti猽 L謓h", tbProp = {6, 1, 4203, 1, 0, 0}, nBindState = -2,};
        PlayerFunLib:GetItem(tbAwardItem, 2, "[Long M玭 Ti猽 C鬰-Nhi謒 v� 竝 Ti猽] 竝 ti猽 th祅h c玭g nh薾 頲 H� Ti猽 L謓h");
        AddStatData("lmbj_task_over");
        WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] T礽 kho秐: %s, Nh﹏ v藅: %s, 竝 ti猽 th祅h c玭g nh薾 頲 to祅 b� ph莕 thng, ID nhi謒 v�: %d, C蕄 sao: %d", 
                                                            GetAccount(), GetName(), nId, nLevel));
        return 1;
    end
    -- 镖车不在玩家附近
    local szTitleMsg = "<npc>Nhi謒 v� 竝 Ti猽 ch璦 k誸 th骳, n誹 l祄 m蕋 Ti猽 Xa v� Ti猽 K� c� th� k誸 th骳 nhi謒 v� v� nh薾 100 v筺 kinh nghi謒, n誹 Ti猽 Xa b� cp t譵 l筰 <color=red>Ti猽 K�<color> s� nh薾 頲 m閠 s� ph莕 thng.";
    local tbOpt = {};
    tinsert(tbOpt, {"K誸 th骳 nhi謒 v�, nh薾 kinh nghi謒", self.onSelectProcess, {self, 6, {nId, bFlag}}});
    tinsert(tbOpt, {"Ta 甶 t譵 l筰 xem sao", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
end

-- 处理查看押镖信息
function pActivity:ViewTaskInfor()
    local szTitleMsg = "";
    local szTempLine = "";
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    local nTaskTimeValue = GetTask(TSK_LMBJTaskTime);
    -- 接了任务并且领了镖车
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

    if (nTaskFlagValue == 0) then -- 未接任务
        szTitleMsg = "<npc><enter>Ch璦 nh薾 nhi謒 v� 竝 Ti猽.";
    else
        local nId = floor(nTaskFlagValue/10);
        local nFlag = mod(nTaskFlagValue, 10);
        local tbPath = self.tbBJPathLevel[nId][1]; -- 押镖路线
        local nSid = tbPath[1];
        local nEid = tbPath[2];
        if nFlag == 1 then
            nSid, nEid = nEid, nSid;
        end
        local nLevel = self.tbBJPathLevel[nId][2]; -- 押镖等级
        -- 押镖信息
        szTitleMsg = format("<npc><enter>L� tr譶h 竝 Ti猽: %s-%s<enter>C蕄 nhi謒 v�: %d Sao", self.tbBJPoints[nSid][1], self.tbBJPoints[nEid][1], nLevel);
        if (nTaskTimeValue == 0) then
            -- 任务状态
            szTempLine = "<enter>tr筺g th竔 nhi謒 v�: v蒼 ch璦 nh薾 Ti猽 Xa";
        end
        if (nBiaoQiCount > 0) then
            szTempLine = "<enter>Tr筺g th竔 nhi謒 v�: Ti猽 Xa b� cp";
        end
        szTitleMsg = szTitleMsg..szTempLine;
    end
    -- 今日押镖任务次数
    local nDailyTaskNum = self:GetTaskDailyA(TSK_DailyTaskNum);
    szTempLine = format("<enter>S� l莕 nhi謒 v� 竝 Ti猽 h玬 nay: %d/3", nDailyTaskNum);
    szTitleMsg = szTitleMsg..szTempLine;
    -- 今日免费刷新任务次数
    local nDailyFreeCount = self:GetTaskDailyA(TSK_DailyFreeCount);
    szTempLine = format("<enter>S� l莕 l祄 m韎 nhi謒 v� mi詎 ph� h玬 nay: %d/5", nDailyFreeCount);
    szTitleMsg = szTitleMsg..szTempLine;
    -- 创建显示面板
    local tbOpt = {};
    tinsert(tbOpt, {"R阨 kh醝", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
    return 0;
end

-- 处理点击快速传送到镖车位置
function pActivity:Transport2Dest()
    -- 判断是否接了任务
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        Talk(1, "", "Hi謕 s� ch璦 nh薾 nhi謒 v� 竝 Ti猽.");
        return nil;
    end
    -- 判断任务是否开始
    if (GetTask(TSK_LMBJTaskTime) == 0) then
        Talk(1, "", "Ti猽 Xa ch璦 xu蕋 ph竧.");
        return nil;
    end
    -- 当前任务是不是个人押镖任务
    local nId = floor(nTaskFlagValue/10);
    if self.tbBJPathLevel[nId][2] >= 10 then
        Talk(1, "", "Hi謓 nh薾 nhi謒 竝 Ti猽 Bang, Ti猽 Xa Bang kh玭g c� � ch� ta.");
        return nil;
    end
    local nMoney = GetCash();
    if (nMoney < 10000) then
        Talk(1, "", "Ng﹏ lng c馻 i hi謕 kh玭g .");
        return nil;
    end
    -- 检查传车的CD时间 30秒
    local nPassTime = GetCurrentTime() - GetTask(TSK_TransCarTime);
    if (nPassTime < 30) then
        Talk(1, "", "C竎h l莕 truy襫 t鑞g trc ch璦 n 30 gi﹜, h穣 i.");
        return nil;
    end
    -- 检查镖车是否已被摧毁或者消失
    if (CalcItemCount(-1, 6, 1, 4200, -1) > 0) then
        Talk(1, "", "Ti猽 Xa u b� ngi l祄 m蕋 h誸 r錳, kh玭g th� truy襫 t鑞g.");
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

-- 放弃押镖任务 镖车未刷出
function pActivity:AbandonTask()
    -- 条件判断：是否接到任务
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        Talk(1, "", "Ngi v蒼 ch璦 nh薾 nhi謒 v� v薾 Ti猽.");
        return nil;
    end
    -- 当前任务是不是个人押镖任务
    local nId = floor(nTaskFlagValue/10);
    if self.tbBJPathLevel[nId][2] >= 10 then
        Talk(1, "", "Hi謓 產ng nh薾 nhi謒 v� 竝 Ti猽 Bang, kh玭g th� b�.");
        return nil;
    end
    -- 判断是否生成镖车
    if GetTask(TSK_LMBJTaskTime) ~= 0 then
        Talk(1, "", "Ti猽 Xa c馻 ngi  xu蕋 ph竧 r錳, l祄 sao c� th� b� gi鱝 ch鮪g 頲!");
        return nil;
    end
    -- 7~9星镖不能放弃
    local nId = floor(nTaskFlagValue/10);
    local nLevel = self.tbBJPathLevel[nId][2]; -- 押镖等级
    if (nLevel >= 7) then
        Talk(1, "", "Ngi  nh薾 nhi謒 v� 竝 Ti猽 cao c蕄 l祄 sao c� th� b� 頲? Ta xem tr鋘g ngi!");
        return nil;
    end
    -- 放弃确认框
    local szTitleMsg = "<npc>Чi hi謕 x竎 nh l莕 n祔 kh玭g th� xu蕋 Ti猽 kh玭g?";
    local tbOpt = {};
    tinsert(tbOpt, {"X竎 nh薾", self.onConfirmProcess, { self, 5, {nId, 0} },});
    tinsert(tbOpt, {"R阨 kh醝", self.onConfirmProcess, { self, 0, {nil} },});
    CreateNewSayEx(szTitleMsg, tbOpt);
    return nil;
end

function pActivity:LogCurMapID()
    local nMapID = GetWorldPos();
    SetTask(TSK_MapIDFlag, nMapID);
    return 1;
end

-- 开始押镖
function pActivity:ReceiveBiaoChe()
    -- 条件判断：是否接到任务
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if (nTaskFlagValue == 0) then
        Talk(1, "", "Ch璦 nh薾 nhi謒 v� V薾 Ti猽, h穣 n Long M玭 Tr蕁 t譵 Chng Qu�.");
        return nil;
    end
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if (nCurTime>=2300 or nCurTime < 1000) then
        Talk(1, "", "Kh玭g trong th阨 gian 竝 ti猽 10:00-23:00, hi謕 s� h穣 quay l筰.");
        return nil;
    end
    -- 判断玩家是否在与起点NPC对话
    local nMapID, nX, nY = GetWorldPos();
    if (GetTask(TSK_MapIDFlag) ~= nMapID) then
        return nil;
    end
    -- 获取押镖任务信息
    local nId = floor(nTaskFlagValue/10); -- 押镖路线ID
    local bFlag = mod(nTaskFlagValue,10); -- 是否交换起始点
    local tbPath = self.tbBJPathLevel[nId][1]; -- 押镖路线
    local nLevel = self.tbBJPathLevel[nId][2]; -- 押镖等级
    -- 条件判断：对话NPC是否是任务的起点NPC
    local nNpcIndex = GetLastDiagNpc();
    local nX32, nY32 = GetNpcPos(nNpcIndex);
    local nEPosId = tbPath[1+bFlag];            -- 押镖路线的终点ID
    local tbPos = self.tbBJPoints[nEPosId][2];  -- 押镖路线终点坐标
    if ((nX32 ~= tbPos[2]*32) or (nY32 ~= tbPos[3]*32)) then
        Talk(1, "", "Hi謕 s� n nh莔 ch� r錳, Ti猽 Xa 產ng � 甶觤 b総 u.");
        return nil;
    end
    -- 条件判断：是否已经接过镖车
    local nLastTaskTime = GetTask(TSK_LMBJTaskTime);
    if (nLastTaskTime ~= 0) then
        Talk(1, "", "Kh玭g ph秈 Ti猽 Xa c馻 ngi  xu蕋 ph竧 t� l﹗ r錳 sao, c遪 kh玭g mau 甶 b秓 v� n誹 kh玭g s� b� k� x蕌 cp m蕋 b﹜ gi�!");
        return nil;
    end
    -- 条件判断：是否远离起点镖师
    if(abs(nX32-nX*32) > 600 or abs(nY32-nY*32) > 600) then
        Talk(1, "", "Ngi 產ng c竎h xa 甶觤 b総 u Ti猽 S�, khi Ti猽 Xa xu蕋 hi謓 kh玭g n猲 r阨 xa Ti猽 S�.");
        return nil;
    end
    -- 刷出镖车
    self:refreshBiaoChe(30*60);
    SetTask(TSK_ItemKMJBTime, 0);
    SetTask(TSK_ItemJBKCTime, 0);
    SetTask(TSK_TransCarTime, 0);
    SetTask(TSK_ItemBCYWTime, 0);
    -- 保存接任务时间
    local nCurTime = GetCurrentTime();
    SetNpcParam(GetTask(TSK_LMBJCarIndex), 4, nCurTime);
    SetTask(TSK_LMBJTaskTime, nCurTime);
    -- 数据埋点
    AddStatData(format("lmbj_car_build_%d", nLevel));
end

function pActivity:onSelectProcess(nSelId, tbParam)
    -- 离开、取消操作
    if (nSelId == 0) then
        return nil;
    end

    local szTitleMsg = "";
    local tbOpt = {};

    -- 高级押镖任务
    if (nSelId == 5) then
        szTitleMsg = "<npc>N閜 竝 ti猽 駓 nhi謒 tr筺g cao c蕄 s� ng蓇 nhi猲 xu蕋 hi謓 nhi謒 v� 竝 Ti猽 7 sao, 8 sao, 9 sao. Ngi  chu萵 b� xong ch璦?"
        tinsert(tbOpt, {"X竎 nh薾", self.onConfirmProcess, { self, 3, {nil} },});
        tinsert(tbOpt, {"R阨 kh醝", self.onConfirmProcess, { self, 0, {nil} },});
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

    -- 我把镖车和镖旗都弄丢了
    if(nSelId == 6) then
        -- 查看镖车是否已经消失
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
    if (bFlag == 1) then -- 交换起点和终点
        nSid, nEid = nEid, nSid;
    end

    -- 押镖任务确定
    if (nSelId == 1) then
        self:AddTaskDailyA(TSK_DailyTaskNum, 1);
        self:saveTask(tbParam);
        -- 传送到任务起始镖师位置
        self:transToBeginPos(tbParam);
        self:updateRelayData(nId);
        return nSelId;
    end

    -- 随机押镖任务-接受
    if (nSelId == 2) then
        local szSName = self.tbBJPoints[nSid][1];
        local szEName = self.tbBJPoints[nEid][1];
        szTitleMsg = format("<npc>Nhi謒 v� Ti猽 Xa %d Sao, 甶觤 u %s-甶觤 cu鑙 %s, trong v遪g 30 ph髏 n n琲, ng �?",nLevel, szSName, szEName);
        tbOpt = {};
        tinsert(tbOpt, {"X竎 nh薾", self.onSelectProcess, {self,1,tbParam}, });
        tinsert(tbOpt, {"R阨 kh醝", self.onSelectProcess, {self,0,{nil}}, });
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

    -- 随机押镖任务-免费刷新任务
    if (nSelId == 3) then
        -- 条件判断 : 今天是否还有免费换镖机会
        local nFreeCount = self:GetTaskDailyA(TSK_DailyFreeCount);
        szTitleMsg = "Ngi  d飊g h誸 s� l莕 l祄 m韎 mi詎 ph� c馻 ng祔 h玬 nay, mu鑞 s� d鬾g ti誴 <color=red> Ho竛 Ti猽 Ch� <color>.";
        if (nFreeCount<5) then
            szTitleMsg = "<npc>C� ph秈 l祄 m韎 nhi謒 v�?";
            tinsert(tbOpt, {"X竎 nh薾", self.onConfirmProcess, {self,1,tbParam}, });
        end
        tinsert(tbOpt, {"Tr� v�", self.CreateRandomTaskPanel, {self, tbParam[1], tbParam[2]}, });
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

    -- 随机押镖任务-换票证刷新任务
    if (nSelId == 4) then
        -- 条件判断：是否还有免费换镖机会
        if (self:GetTaskDailyA(TSK_DailyFreeCount) < 5) then
            Talk(1, "", "Hi謓 hi謕 s� c遪 s� l莕 mi詎 ph�, kh玭g c莕 d飊g Ho竛 Ti猽 Ch�.");
            return 0;
        end
        -- 条件判断：背包中是否有换票凭证
        if (CalcItemCount(3, 6, 1, 4201, -1) <= 0) then
            Talk(1, "", "Kh玭g c� Ho竛 Ti猽 Ch�, kh玭g n猲 l穘g ph� th阨 gian.");
            return 0;
        end
        szTitleMsg = "<npc>D飊g Phi誹 цi Ti猽 t筼 m韎 nhi謒 v�?";
        tinsert(tbOpt, {"X竎 nh薾", self.onConfirmProcess, { self, 2, tbParam },});
        tinsert(tbOpt, {"Tr� v�", self.CreateRandomTaskPanel, {self, tbParam[1], tbParam[2]}, });
        CreateNewSayEx(szTitleMsg, tbOpt);
        return nSelId;
    end

end

function pActivity:onConfirmProcess(nSelId, tbParam)
    if (nSelId == 0) then
        return nil;
    end

    -- 确定免费换镖
    if (nSelId == 1) then
        -- 今日的免费换镖次数+1
        self:AddTaskDailyA(TSK_DailyFreeCount, 1);
        local szTips = format("Nhi謒 v� 竝 Ti猽  t筼 m韎, c遪 %d l莕 mi詎 ph�.", 5-self:GetTaskDailyA(TSK_DailyFreeCount));
        Msg2Player(szTips);
        -- 产生新的押镖路线
        local szLocalPath = "\\script\\activitysys\\config\\129\\extend.lua";
        local szRemotePath = "\\script\\event\\longmenbiaoju\\event.lua";
        DynamicExecute(szLocalPath, 
                    "RemoteExecute", szRemotePath, "tbLMBJActivityData:g2s_GetTaskFlag", 0, 
                    "pActivity:getTaskFlagCallBack", PlayerIndex);
        return nSelId;
    end

    -- 确定使用换镖凭证换镖
    if (nSelId == 2) then
        if (ConsumeItem(3, 1, 6, 1, 4201, -1) == 1) then -- 扣除道具(换镖凭证)
            Msg2Player("Nhi謒 v� 竝 Ti猽  t筼 m韎, tr� 1 Ho竛 Ti猽 Ch�.");
            -- 重新产生押镖路线
            local nTaskValue = self:getChangeTaskFlag();
            SetTask(TSK_LMBJRanTskFlag, nTaskValue);
            WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] T礽 kho秐: %s, Nh﹏ v藅: %s d飊g Ho竛 Ti猽 Ch�", GetAccount(), GetName()));
            AddStatData("lmbj_task_refresh");
            self:CreateRandomTaskPanel(floor(nTaskValue/10), mod(nTaskValue,10));
        else
            Msg2Player("Kh蕌 tr� o c� th蕋 b筰, h穣 t Ho竛 Ti猽 Ch� v祇 trong T骾.");
        end
        return nSelId;
    end

    -- 确定接受高级押镖任务
    if (nSelId == 3) then
        if (ConsumeItem(3, 1, 6, 1, 4202, -1) ~= 1) then -- 扣除道具(换镖凭证)
            Talk(1, "", "Ngi kh玭g c� 竝 ti猽 駓 nhi謒 tr筺g cao c蕄, ng ph� th阨 gian n鱝.");
            return nil;
        end
        local nLevel = 8;
        local nRandValue = random(1, 100);
        if (nRandValue <= 60) then -- 60%的概率7星镖车
            nLevel = 7;
        elseif (nRandValue >90) then-- 10%的概率9星镖车
            nLevel = 9;
        end
        local tbAllId = self.tbAllTask[nLevel].tbID;
        local nId = tbAllId[random(1, getn(tbAllId))];
        local bSwitchSE = random(0, 1);
        self:saveTask({nId, bSwitchSE});
        Msg2Player("Х nh薾 1 nhi謒 v� 竝 Ti猽 c蕄 cao, ki課 ngh� t� i h� ti猽.");
        WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰]  T礽 kho秐: %s, Nh﹏ v藅: %s d飊g 竝 Ti猽 駓 Tr筺g Nhi謒 V� Cao C蕄, ID nhi謒 v�: %d, C蕄 sao: %d", GetAccount(), GetName(), nId, nLevel));
        AddStatData("lmbj_task_highbook");
        self:transToBeginPos({nId, bSwitchSE});
        return nSelId;
    end

    -- 镖车、镖旗都没有结束本次任务，给经验
    local nId = tbParam[1];
    local nLevel = self.tbBJPathLevel[nId][2];
    if (nSelId == 4) then
        SetTask(TSK_LMBJTaskFlag, 0);
--        DynamicExecuteByPlayer(PlayerIndex, "\\script\\huoyuedu\\huoyuedu.lua", "tbHuoYueDu:AddHuoYueDu", 32); -- 给玩家增加活跃度
        PlayerFunLib:AddExp(1000000, 1, "[Long M玭 Ti猽 C鬰] Ti猽 Xa bi課 m蕋, kh玭g c� ph莕 thng kinh nghi謒 d飊g Ti猽 K� k誸 th骳 nhi謒 v�");
        AddStatData("lmbj_task_over");
        WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] T礽 kho秐: %s, Nh﹏ v藅: %s, ID nhi謒 v� k誸 th骳: %d, C蕄 sao: %d", GetAccount(), GetName(), nId, nLevel));
        Msg2Player("Х k誸 th骳 nhi謒 v� 竝 Ti猽 l莕 n祔.");
    end
    -- 确定放弃任务 还未刷出镖车
    if (nSelId == 5) then
        SetTask(TSK_LMBJTaskFlag, 0);
        Msg2Player("Х b� nhi謒 v� 竝 Ti猽 l莕 n祔.");
        WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] T礽 kho秐: %s, Nh﹏ v藅: %s, ID nhi謒 v� t� b�: %d, C蕄 sao: %d", GetAccount(), GetName(), nId, nLevel));
    end
end

function pActivity:saveTask(tbParam)
    local nId = tbParam[1];
    local bSwitch = tbParam[2];
    if (nId == nil or bSwitch == nil) then
        Msg2Player("Nh薾 ti猽 th蕋 b筰");
        return nil;
    end
    SetTask(TSK_LMBJTaskFlag, nId*10+bSwitch);
    Msg2Player(format("Th祅h c玭g nh薾 nhi謒 v� 竝 Ti猽 %d Sao", self.tbBJPathLevel[nId][2]));
    AddStatData("lmbj_task_start");
    WriteYunBiaoLog(format("[Long M玭 Ti猽 C鬰] T礽 kho秐: %s, Nh﹏ v藅: %s, C蕄 sao nhi謒 v� 竝 Ti猽 nh薾: %d", GetAccount(), GetName(), self.tbBJPathLevel[nId][2]));
    -- 清空1星、随机押镖任务
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
        Talk(1, "", "Ti猽 Xa  b� ph� h駓 ho芻 bi課 m蕋, kh玭g th� truy襫 t鑞g");
        PlayerIndex = nOldPlayerIndex;
        return nil;
    end
    -- 设置本次传车时间
    SetTask(TSK_TransCarTime, GetCurrentTime());
    -- 扣钱
    Pay(10000);
    -- 传送到镖车位置
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
    -- 获取押镖任务信息
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    local nId = floor(nTaskFlagValue/10); -- 押镖路线ID
    local bFlag = mod(nTaskFlagValue,10); -- 是否交换起始点
    local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
    local szTitleMsg = "";
    local tbOpt = {};
    if (tbCurCarPos[1] == -1 or nPassTime >= 1800) then
        szTitleMsg = "<npc>Ti猽 Xa c馻 ngi  bi課 m蕋 ho芻 b� ph� h駓, c� ph秈 k誸 th骳 nhi謒 v� l莕 n祔?";
        tinsert(tbOpt, {"X竎 nh薾", self.onConfirmProcess, { self, 4, {nId, bFlag} },});
    else
        szTitleMsg = format("<npc>Ti猽 Xa c馻 b筺 產ng d鮪g � b秐  %s(%s/%s).", tbGlobalMapId2Name[tbCurCarPos[1]], floor(tbCurCarPos[2]/8), floor(tbCurCarPos[3]/16));
    end
    tinsert(tbOpt, {"R阨 kh醝", self.onConfirmProcess, { self, 0, {nil} },});
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
    local tbPath = self.tbBJPathLevel[nId][1]; -- 押镖路线
    local nLevel = self.tbBJPathLevel[nId][2]; -- 押镖等级
    local nSid = tbPath[1];
    local nEid = tbPath[2];
    if nFlag == 1 then
        nSid, nEid = nEid, nSid;
    end
    -- 押镖信息
    local szTitleMsg = format("<npc><enter>L� tr譶h 竝 Ti猽: %s-%s<enter>C蕄 nhi謒 v�: %d Sao", self.tbBJPoints[nSid][1], self.tbBJPoints[nEid][1], nLevel);
    local szTempLine = "";
    -- 任务状态
    if (tbCurCarPos==nil or tbCurCarPos[1]==-1) then -- 镖车消失
        szTempLine = "<enter>Tr筺g th竔 nhi謒 v�: Ti猽 Xa  bi課 m蕋, nhi謒 v� k誸 th骳.";
    else
        local nPassTime =  GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
        szTempLine = format("<enter>Tr筺g th竔 nhi謒 v�: дm ngc kho秐g %d ph髏", 30-floor(nPassTime/60));
    end
    local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
    if ( nPassTime >= 1800) then -- 检查镖服务器宕机镖车一直存在超时终止
        szTempLine = "<enter>Tr筺g th竔 nhi謒 v�: Ti猽 Xa  bi課 m蕋, nhi謒 v� k誸 th骳.";
    end
    szTitleMsg = szTitleMsg..szTempLine;
    -- 今日押镖任务次数
    local nDailyTaskNum = self:GetTaskDailyA(TSK_DailyTaskNum);
    szTempLine = format("<enter>S� l莕 nhi謒 v� 竝 Ti猽 h玬 nay: %d/3", nDailyTaskNum);
    szTitleMsg = szTitleMsg..szTempLine;
    -- 今日免费刷新任务次数
    local nDailyFreeCount = self:GetTaskDailyA(TSK_DailyFreeCount);
    szTempLine = format("<enter>S� l莕 l祄 m韎 nhi謒 v� mi詎 ph� h玬 nay: %d/5", nDailyFreeCount);
    szTitleMsg = szTitleMsg..szTempLine;
    local tbOpt = {};
    tinsert(tbOpt, {"R阨 kh醝", self.onSelectProcess, {self, 0, nil}, });
    CreateNewSayEx(szTitleMsg, tbOpt);
    PlayerIndex = nOldPlayerIndex;
end

-- 传送到押镖
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

-- 要实现车人不在同一台GS下获取车的位置
function pActivity:getCurrentCarPos()
    -- 车、人在同一台GS下
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
    -- 获取押镖任务信息
    local nId = floor(nTaskFlagValue/10);       -- 押镖路线ID
    local nLevel = self.tbBJPathLevel[nId][2];  -- 押镖等级
    -- 获取镖车信息
    local nNpcSettingID = self:getBiaoCheNpcSettingId(nLevel);
    local szPlayerName = GetName();
    local szCarName = format("%s-Ti猽 Xa %d Sao", szPlayerName, nLevel);
    local szScriptPath = "\\script\\activitysys\\config\\129\\npc_lmbiaoche.lua";
    if nLevel >= 10 then
        szCarName = format("Ti猽 Xa bang c馻 [%s]%s", szTongName, szPlayerName);
        szScriptPath = "\\script\\activitysys\\config\\129\\npc_lmbiaoche.lua";
    end
    local nNpcIndex = CreateBiaoChe(random(1,4), nNpcSettingID, 95, szCarName, nSuriveTime*18);
    SetNpcParam(nNpcIndex, 1, nLevel);
    local nHashValue = String2Id(szPlayerName); -- 将玩家角色名的Hash值保存
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
    SetTask(TSK_LMBJCarIndex, nNpcIndex); --设置镖车Index
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

--------------------------------------------帮会押镖任务接口--------------------------------------------
function pActivity:GetOccupyTongId()
    local tbMainCity = {
        [1]     = 1,    -- 凤翔
        [11]    = 2,    -- 成都
        [162]   = 3,    -- 大理
        [37]    = 4,    -- 汴京
        [78]    = 5,    -- 襄阳
        [80]    = 6,    -- 扬州
        [176]   = 7,    -- 临安
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

-- 帮会押镖日志
function pActivity:WriteTongYBLog(szLog)
    if not szLog then
        WriteYunBiaoLog("!!!!!!!!!!!!!!!Log tr鑞g!!!!!!!!!!!!!!!");
        return 0;
    end
    local szWriteLog = "";
    if PlayerIndex and PlayerIndex > 0 then
        local szTongName = GetTongName();
        szWriteLog = format("[Long M玭 Ti猽 C鬰_竝 Ti猽 Bang] Bang: %s, T礽 kho秐: %s, T猲 nh﹏ v藅: %s, Ch鴆 v�: %s %s", szTongName, GetAccount(), GetName(), GetTongFigureStr(), szLog);
    else
        szWriteLog = format("[Long M玭 Ti猽 C鬰_竝 Ti猽 Bang] Bang: !!! T礽 kho秐: !!! T猲 nh﹏ v藅: !!! Ch鴆 v�: !!! %s", szLog);
    end
    WriteYunBiaoLog(szWriteLog);
end

-- 检查是不是押镖人
function pActivity:IsTraner()
    local szTongName, nTongId = GetTongName()
    if nTongId == 0 then
        return nil;
    end
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    if nTaskFlagValue == 0 then
        return nil;
    end
    local nId = floor(nTaskFlagValue/10); -- 押镖路线ID
    local nLevel = self.tbBJPathLevel[nId][2];  -- 押镖等级
    if nLevel < 10 then
        return nil;
    end
    return 1;
end

-- 检查入帮天数
function pActivity:CheckJoinTongDays(nDay)
    local nDayTime = nDay * 24 * 60;
    local nJoinTime = GetJoinTongTime();

    if nJoinTime >= nDayTime then
        return 1
    end
    return nil;
end

-- 检查帮主能否退位
function pActivity:CheckCanChangeMaster()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return 0;
    end
    if self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE) == 1 then
        Talk(1, "", "Х m� ho箃 ng 竝 Ti猽 Bang tu莕 n祔, kh玭g th� ch蕄 h祅h bang ch� tho竔 v�.");
        return 0;
    end
    return 1;
end

-- 检查能否踢出nTongId帮的szKickName
function pActivity:CheckCanKick(nTongId, szKickName)
    local nPassTime = GetCurrentTime() - TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_TIME);
    if nPassTime >= 1800 then
        return 1;
    end
    local dwKickHash = String2Id(szKickName);
    if self:GetCurExecutorHash(nTongId) == dwKickHash and nPassTime < 1800 then
        --Talk(1, "", format("<color=red>%s<color>已接取的贵帮的帮会押镖任务，不能对他执行踢出帮会操作。", szKickName));
        Talk(1, "", format("<color=red>%s<color>  nh薾 nhi謒 v� 竝 ti猽 bang h閕 c馻 qu� bang, kh玭g th� ph秐 b閕 bang h閕.", szKickName));
        return 0;
    end
    return 1;
end

-- 检查能否退帮
function pActivity:CheckCanLeaveTong()
    local nTaskValue = GetTask(TSK_LMBJTaskFlag);
    if nTaskValue == 0 then
        return 1;
    end
    local nID = floor(nTaskValue/10);
    local nLevel = self.tbBJPathLevel[nID][2]; -- 押镖等级
    local nPassTime = GetCurrentTime() - GetTask(TSK_LMBJTaskTime);
    if nLevel >= 10 and nPassTime < 1800 then
        Talk(1, "", "Х nh薾 nhi謒 v� 竝 Ti猽 Bang, kh玭g th� r阨 bang.");
        return 0;
    end
    return 1;
end

-- 获取周清空帮会任务变量值
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
    if nWeekIdx == nCurWeekIdx then  -- 周次一样，值有效返回nCount
        return nCount;
    end
    local nCurWeek = tonumber(date("%w"));
    if nCurWeek > 0 and nCurWeek < 6 then -- 周次不一样，在星期一 ~ 星期五之间 
        if nWeekIdx + 1 == nCurWeekIdx or nCurWeekIdx < nWeekIdx then -- 周次相差1或者跨年值有效
            return nCount;
        end
    end
    -- 其他情况值无效 返回 0
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

-- 领取帮会押镖团体奖励
function pActivity:GetTongAward()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return nil;
    end
    local nAwardCount = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_AWARD);
    if nAwardCount <= 0 then
        Talk(1, "", "Rng 竝 Ti猽 Bang l� 0, kh玭g c� ph莕 thng c� th� nh薾");
        return nil;
    end
    if nAwardCount > 50 then
        nAwardCount = 50;
    end
    g_AskClientNumberEx(1, nAwardCount, "S� lng nh藀: ", {self.GetTongAwardCallBack, {self, 1, nAwardCount, szTongName, nTongId, TONG_TASK_YABIAO_AWARD}} );
    return 1;
end
function pActivity:GetTongAwardCallBack(nMin, nMax, szTongName, nTongId, nTongTaskId, nCount)
    -- 检查输入
    if (nCount < nMin or nCount > nMax) then
        Msg2Player("S� lng nh藀 v� hi謚, h穣 nh藀 l筰!");
        return nil;
    end
    -- 二次检查是不是帮主
    if CheckIsMaster() ~= 1 then
        return nil;
    end
    -- 判断背包空间
    local nMinCells = nCount * 5;
    local szErrorTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", nMinCells);
    if PlayerFunLib:CheckFreeBagCell(nMinCells, szErrorTips) ~= 1 then
        return nil;
    end
    TONG_ApplyAddTaskValue(nTongId, nTongTaskId, -nCount);
    -- 给帮会资金
    local nNum = 0;
    for i = 1, nCount do
        --AddTongMoney(szTongName, 60000000);
        if random(1,100) > 50 then
            nNum = nNum + 1;
        end
    end
    --local szTongMsg = format("恭喜贵帮获得:%d个朝廷赦书, %d个兄弟情深, %sW帮会资金。", nCount, nCount*5, nCount*6000);
    local tbAwardList = self.tbAward["tongaward"][2];
    --if nNum > 0 then
        --local tbItem = self.tbAward["tongaward"][1];
        --local nNumber = 65535;
        --local nTongHash1 = mod(nTongId, nNumber);
        --local nTongHash2 = floor(nTongId/nNumber);
        --tbItem[1].tbParam = {nTongHash1, nTongHash2, nNumber};
        --tbItem[1].nCount = nNum;
        --tbAwardTemplet:GiveAwardByList(tbItem, "[龙门镖局_帮会押镖] 帮主领取押镖奖励_阵营更换福利书");
        --szTongMsg = format("恭喜贵帮获得:%d个朝廷赦书, %d个阵营更换福利书, %d个兄弟情深, %sW帮会资金。", nCount, nNum, nCount*5, nCount*6000);
    --end
    tbAwardTemplet:GiveAwardByList(tbAwardList, "[Long M玭 Ti猽 C鬰_竝 Ti猽 Bang] Bang ch� nh薾 ph莕 thng 竝 Ti猽", nCount);
    --Msg2Tong(nTongId, szTongMsg);
    --Msg2Tong(nTongId, "大量帮会资金正在运送途中,将会在10分钟内增加到帮会账目,请稍等。");
    -- 日志
    local szLogs = format("Nh薾 %d ph莕 thng nh鉳 竝 Ti猽 Bang", nCount);
    self:WriteTongYBLog(szLogs);
end

-- 给护送镖车经验
function pActivity:AddFollowExp(nTongId)
    local szTongName, nMyTongId = GetTongName();
    -- 没有入帮的不给
    if nMyTongId == 0 then
        return nil;
    end
    -- 不属于镖车所在帮会的不给
    if nMyTongId ~= nTongId then
        return nil;
    end
    -- 检查入帮时间
    if self:CheckJoinTongDays(7) ~= 1 then
        return nil;
    end
    
    --非战斗状态不给
    if GetFightState() == 0 then
    	return
    end
    -- 给经验
    PlayerFunLib:AddExp(4000000, 1, "[Long M玭 Ti猽 C鬰_竝 Ti猽 Bang] H� t鑞g Ti猽 Xa nh薾 kinh nghi謒.");
    self:AddFollowAwardCount(nTongId);
end

function pActivity:HandInBiaoCheBox()
    -- 检查是否入帮
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        Talk(1, "", "Ch璦 v祇 bang, kh玭g th� n閜 Rng Ti猽 Xa Bang.");
        return nil;
    end
    -- 检查入帮时间
    if self:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "Чi hi謕 v祇 bang ch璦  7 ng祔, kh玭g th� n閜 Rng Ti猽 Xa Bang.");
        return nil;
    end

    g_GiveItemUI("N閜 Rng Ti猽 Xa Bang", "t v祇 Rng Ti猽 Xa Bang", {self.PutBiaoCheBox, {self, TONG_TASK_YABIAO_AWARD}}, {}, 1);
end

function pActivity:PutBiaoCheBox(nTongTaskId, nCount)
    if nCount < 1 then
        Msg2Player("H穣 t v祇 Rng Ti猽 Xa Bang mu鑞 n閜.");
        return nil;
    end
    -- 检查入帮时间
    if self:CheckJoinTongDays(7) ~= 1 then
        Msg2Player("N閜 Rng Bang th蕋 b筰, h穣 th� l筰.");
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
        Talk(1, "", "Ch� c� th� n閜 Rng Ti猽 Xa Bang, kh玭g t v藅 ph萴 kh竎.");
        return nil;
    end
    -- 检查道具合法性
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
    -- 记帮会任务变量
    local szTongName, nTongId = GetTongName();
    TONG_ApplyAddTaskValue(nTongId, nTongTaskId, nSuccess);
    local szTips = format("Th祅h c玭g n閜 Rng 竝 Ti猽 Bang �%s� %d c竔, qu� h筺 x鉧 %d c竔.", szTongName, nSuccess, nExpired);
    Talk(1, "", szTips);
    -- 日志埋点
    AddStatData("bhyb_upload_count", nSuccess);
    local szLogs = format("N閜 Rng 竝 Ti猽: %d c竔, qu� h筺 x鉧 %d c竔", nSuccess, nExpired);
    self:WriteTongYBLog(szLogs);
end

