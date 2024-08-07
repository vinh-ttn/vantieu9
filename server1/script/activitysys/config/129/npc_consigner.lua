-- 绑定脚本
IncludeLib("LEAGUE")
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\extend.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\global\\maplist.lua")
Include("\\script\\event\\longmenbiaoju\\head.lua")

pActivity.tbTongTask = {
    [80]    = {27, 28, 29, 27,},    -- 扬州
    [176]   = {30, 31, 32, 30,},    -- 临安
    [37]    = {33, 34, 35, 36,},    -- 汴京
    [11]    = {37, 38, 39, 40,},    -- 成都
    [78]    = {41, 42, 41, 42,},    -- 襄阳
    [1]     = {44, 45, 46, 44,},    -- 凤翔
    [162]   = {47, 48, 49, 47,},    -- 大理
}

function main()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        Talk(1, "", "Tr竛g s� ch璦 gia nh藀 bang h閕, kh玭g  th� tham gia 竝 ti猽");
        return nil;
    end
    pActivity:LogCurMapID();
    local nOccTongId = pActivity:GetOccupyTongId()
    if nTongId ~= nOccTongId then
        Talk(1, "", "Ti猽 c鬰 c� v藅 ph萴 quan tr鋘g c莕 r蕋 nhi襲 ngi h� t鑞g, ch髇g t玦 ch� tin v祇 th鵦 l鵦 bang chi誱 l躰h th祅h, kh玭g h頿 t竎 v韎 ngi kh竎, xin h穣 v� cho.");
        return nil;
    end
    pActivity:ClickStartGuideMan();
end

-- 点击帮会押镖接引人
function pActivity:ClickStartGuideMan()
    local szTitleMsg = "<npc>Ti猽 c鬰 c� v藅 ph萴 quan tr鋘g c莕 r蕋 nhi襲 ngi h� t鑞g, ch髇g t玦 ch� tin v祇 th鵦 l鵦 c馻 qu� bang, n誹 h� ti猽 th祅h c玭g s� 頲 h藆 t�! Ngo礽 ra, ngi v薾 ti猽 c� th� d飊g o c� 竝 ti猽 c� nh﹏.";
    local tbOpt = {};
    -- 只有帮主可见
    if CheckIsMaster() == 1 then
        tinsert(tbOpt, {"M� 竝 Ti猽 Bang", self.OpenTongState, {self}});
    end
    -- 帮主和长老可见
    if CheckIsElder() == 1 or CheckIsMaster() == 1 then
        tinsert(tbOpt, {"Nh薾 竝 Ti猽 Bang", self.RecvTongBiaoChe, {self}});
    end
    -- 运镖人可见
    if self:IsTraner() == 1 then
        tinsert(tbOpt, {"Xem th玭g tin Ti猽 Xa", self.ShowTongBiaoChe, {self}});
        tinsert(tbOpt, {"Truy襫 t鑞g n Ti猽 Xa", self.GoToTongBiaoChe, {self}});
        tinsert(tbOpt, {"T� b� nhi謒 v� 竝 Ti猽 Bang hi謓 t筰", self.CancelTongTask, {self}});
    end
    tinsert(tbOpt, {"R阨 kh醝", });
    CreateNewSayEx(szTitleMsg, tbOpt);
end

function pActivity:OpenTongState()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return nil;
    end
    -- 检查是否已经开启
    local nYaBiaoState = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE);
    if nYaBiaoState > 0 then
        Talk(1, "", "Ho箃 ng 竝 Ti猽 c馻 bang trong tu莕 n祔  m�.");
        return nil;
    end
    -- 检查是不是周末
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "Kh玭g trong th阨 gian m� 竝 Ti猽 Bang (12:00-23:00 Th� b秠, Ch� nh藅).");
        return nil;
    end
    -- 检查押镖时间
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Kh玭g trong th阨 gian m� 竝 Ti猽 Bang (12:00-23:00 Th� b秠, Ch� nh藅).");
        return nil;
    end
    -- 检查占城数量
    local nOccCitys = self:GetTongWeekTaskValue(nTongId, TONG_TASK_OCCUPY_CITYS);
    local nCount = floor((nOccCitys+1)/2);
    if nCount <= 0 then
        Talk(1, "", "S� th祅h chi誱 c馻 bang trong tu莕 kh玭g   m� ho箃 ng 竝 Ti猽.");
        return nil;
    end
    
    local szTitleMsg = "<npc>Sau khi m� 竝 Ti猽 Bang, ngi ch琲 trong bang t� c蕄 trng l穙 tr� l猲 (g錷 bang ch�) c� th� nh薾 nhi謒 v� 竝 Ti猽 Bang, m閠 khi nh薾 nhi謒 v� s� l藀 t鴆 m� m ngc 30 ph髏.";
    local tbOpt = {};
    tinsert(tbOpt, {"уng � m�", self.ConfirmOpenTongState, {self, nTongId, szTongName, nCount}});
    tinsert(tbOpt, {"в ta suy ngh� l筰!",});
    CreateNewSayEx(szTitleMsg, tbOpt);
end

function pActivity:ConfirmOpenTongState(nTongId, szTongName, nCount)
    -- 二次检查是不是周末
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "Kh玭g trong th阨 gian m� 竝 Ti猽 Bang (12:00-23:00 Th� b秠, Ch� nh藅).");
        return nil;
    end
    -- 二次检查押镖时间
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Kh玭g trong th阨 gian m� 竝 Ti猽 Bang (12:00-23:00 Th� b秠, Ch� nh藅).");
        return nil;
    end
    -- 二次确认身份
    if CheckIsMaster() ~= 1 then
        Talk(1, "", "Ch� bang ch� m韎 頲 m� 竝 Ti猽 Bang.");
        return nil;
    end
    -- 修改帮会任务变量
    self:SetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE, 1);
    self:SetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT, nCount);
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_RAND, random(1, 4));
    local szName = GetName()
    Msg2Tong(nTongId, format("Bang ch� %s  m� 竝 Ti猽 Bang.", szName));

    -- 日志
    self:WriteTongYBLog("Х m� 竝 Ti猽 Bang");
end

function pActivity:RecvTongBiaoChe()
    --等级判断
    if PlayerFunLib:CheckTotalLevel(150, "Ch璦 t c蕄 150 v� ch璦 chuy觧 sinh, kh玭g th� nh薾 竝 Ti猽 Bang.", ">=") ~= 1 then
	    return nil;
    end
    -- 有没有开启帮会押镖
    local szTongName, nTongId = GetTongName();
    local nYaBiaoState = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE);
    if nYaBiaoState == 0 then
        Talk(1, "", "Bang kh玭g c� ho芻 ch璦 m� nhi謒 v� 竝 Ti猽 c馻 tu莕 n祔, h穣 mau li猲 h� bang ch�  m�.");
        return nil;
    end
    -- 检查入帮时间
    if self:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "V祇 bang ch璦  7 ng祔, kh玭g th� nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    -- 检查是不是周末
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "Ch� th� b秠 ho芻 ch� nh藅 trong tu莕 m韎 頲 nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    -- 检查押镖时间
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Th阨 gian nh薾 竝 Ti猽 Bang l� m鏸 cu鑙 tu莕 12:00~23:00.");
        return nil;
    end
    
    -- 检查玩家是否正在押镖任务
    local data = LongMenBiaoJu:GetDataClass()
    if (GetTask(TSK_LMBJTaskFlag) ~= 0) or (data:GetType() ~= 0) then
        Talk(1, "", "C� nhi謒 v� 竝 Ti猽 ch璦 ho祅 th祅h, kh玭g th� nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    -- 检查是否已经有人开始押镖了
    local nLastTime = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_TIME);
    local nNowTimes = GetCurrentTime();
    if nNowTimes - nLastTime < 1800 then
        Talk(1, "", "Bang  c� ngi nh薾 nhi謒 v� 竝 Ti猽, h穣 mau h� tr� h� t鑞g Ti猽 Xa.");
        return nil;
    end
    local nOccCitys = self:GetTongWeekTaskValue(nTongId, TONG_TASK_OCCUPY_CITYS);
    local nSumCount = floor((nOccCitys+1)/2);
    -- 检查当前本帮还有没有押镖任务
    local nCount = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT);
    if nCount <= 0 then
        Talk(1, "", format("Tu莕 n祔 qu� bang  nh薾 <color=yellow>%d<color> l莕 竝 Ti猽 Bang, ch髇g t玦  h誸 v藅 ph萴 c莕 v薾 chuy觧.", nSumCount));
        return nil;
    end
    -- 判断玩家是否在与起点NPC对话
    local nMapID, nX, nY = GetWorldPos();
    if (GetTask(TSK_MapIDFlag) ~= nMapID) then
        return nil;
    end
    -- 押镖任务
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
    local tbPath = self.tbBJPathLevel[nId][1]; -- 押镖路线
    local nEid = tbPath[2];
    local szTitleMsg = format("<npc>Tu莕 n祔 qu� bang  nh薾 <color=yellow>%d/%d<color> l莕 竝 Ti猽 Bang, nhi謒 v� l莕 n祔 m ngc 30 ph髏, di觤 cu鑙 l� %s", nSumCount-nCount, nSumCount, self.tbBJPoints[nEid][1]);
    local tbOpt = {};
    tinsert(tbOpt, {"уng � nh薾", self.ConfirmRecvTongTask, {self, nTongId, nId}});
    tinsert(tbOpt, {"в ta suy ngh� l筰!",});
    CreateNewSayEx(szTitleMsg, tbOpt);
    return 1;
end

function pActivity:ConfirmRecvTongTask(nTongId, nID)
    -- 二次检查是不是周末
    local nWeekIdx = tonumber(GetLocalDate("%w"));
    if nWeekIdx ~= 0 and nWeekIdx ~= 6 then
        Talk(1, "", "Ch� th� b秠 ho芻 ch� nh藅 trong tu莕 m韎 頲 nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    -- 二次检查入帮时间
    if self:CheckJoinTongDays(7) ~= 1 then
        Talk(1, "", "V祇 bang ch璦  7 ng祔, kh玭g th� nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    -- 二次确认检查押镖时间
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Th阨 gian nh薾 竝 Ti猽 Bang l� m鏸 cu鑙 tu莕 12:00~23:00.");
        return nil;
    end
    -- 二次确认身份
    if CheckIsElder() ~= 1 and CheckIsMaster() ~= 1 then
        Talk(1, "", "竝 Ti猽 Bang ph秈 l� trng l穙 ho芻 bang ch� m韎 頲 nh薾, c蕄 ch鴆 v� c馻 b筺 ch璦 .");
        return nil;
    end
    -- 二次检查在打开确认框期间是否已经有人开始押镖了
    local nLastTime = TONG_GetTaskValue(nTongId, TONG_TASK_YABIAO_TIME);
    local nNowTimes = GetCurrentTime();
    if nNowTimes - nLastTime < 1800 then
        Talk(1, "", "Bang  c� ngi nh薾 nhi謒 v� 竝 Ti猽, h穣 mau h� tr� h� t鑞g Ti猽 Xa.");
        return nil;
    end
    local nOccCitys = self:GetTongWeekTaskValue(nTongId, TONG_TASK_OCCUPY_CITYS);
    local nSumCount = floor((nOccCitys+1)/2);
    -- 二次检查当前本帮还有没有押镖任务
    local nCount = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT);
    if nCount <= 0 then
        Talk(1, "", format("Tu莕 n祔 qu� bang  nh薾 <color=yellow>%d<color> l莕 竝 Ti猽 Bang, ch髇g t玦  h誸 v藅 ph萴 c莕 v薾 chuy觧.", nSumCount));
        return nil;
    end
    -- 判断玩家是否在与起点NPC对话
    local nMapID, nX, nY = GetWorldPos();
    if (GetTask(TSK_MapIDFlag) ~= nMapID) then
        return nil;
    end
    -- 条件判断：是否远离帮会押镖接引人
    local nNpcIndex = GetLastDiagNpc();
    local nX32, nY32 = GetNpcPos(nNpcIndex);
    if(abs(nX32-nX*32) > 600 or abs(nY32-nY*32) > 600) then
        Talk(1, "", "B筺 c竎h xa Ti誴 D蒼 竝 Ti猽 Bang, kh玭g th� t筼 ra Ti猽 Xa.");
        return nil;
    end
    -- 保存任务开始时间到帮会任务变量
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_TIME, nNowTimes);
    -- 更新帮会本周押镖次数
    self:AddTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_COUNT, -1);
    -- 更新下一次接镖路线随机数
    TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_RAND, random(1, 4));
    -- 更新当前帮会押镖人角色名Hash存档
    self:SetCurExecutorHash(nTongId, GetName());
    -- 个人任务变量更新
    SetTask(TSK_LMBJTaskTime, nNowTimes);           -- 任务接取时间
    SetTask(TSK_TransTongCarTime, nNowTimes);   -- 镖车传送时间
    SetTask(TSK_TransTongCarCD, 0);
    SetTask(TSK_ItemKMJBTime, 0);                   -- 清除使用快马加鞭时间
    SetTask(TSK_ItemJBKCTime, 0);                   -- 清除使用坚不可摧时间
    SetTask(TSK_ItemBCYWTime, 0);                   -- 清除使用镖车移位时间
    SetTask(TSK_LMBJTaskFlag, nID*10);              -- 保存接取的押镖任务
    self:refreshBiaoChe(30*60);                     -- 刷出镖车
    SetNpcParam(GetTask(TSK_LMBJCarIndex), 4, nNowTimes); -- 设置镖车的NPC参数
    -- 一些提示
    local tbPath = self.tbBJPathLevel[nID][1]; -- 押镖路线
    local nSid, nEid = unpack(tbPath);
    local szSName = self.tbBJPoints[nSid][1];
    local szEName = self.tbBJPoints[nEid][1];
    Talk(1, "", format("Th祅h c玭g nh薾 竝 Ti猽 Bang 10 Sao, 甶觤 u: %s-甶觤 cu鑙 %s, trong 30 ph髏 n n琲.", szSName, szEName));
    local szTongName = GetTongName();
    local szGlbNews = format("Bang <color=red>%s<color>-<color=green>%s<color> t筰 <color=red>%s<color> th祅h c玭g nh薾 竝 Ti猽 Bang 10 Sao.", szTongName, GetName(), szSName);
    AddGlobalNews(szGlbNews);
    -- 发全区全服左下角公告
    LG_ApplyDoScript(1, "", "", "\\script\\event\\msg2allworld.lua", "battle_msg2allworld", szGlbNews , "", "");
    --帮会活跃度系统新增：帮会接取帮会押镖任务获得活跃度
    --if nTongId > 0 then
    	--DynamicExecute("\\script\\tong\\tong_huoyuedu.lua", "tbTongHuoYueDu:BangHuiYaBiao", nTongId);
    --end
    -- 日志埋点
    AddStatData("bhyb_accept_count");
    local szLogs = format("Х nh薾 竝 Ti猽 Bang (%s#%s)", szSName, szEName);
    self:WriteTongYBLog(szLogs);
    return 1;
end

function pActivity:ShowTongBiaoChe()
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    -- 判断当前镖车等级
    if nTaskFlagValue ~= 0 then
        local nId = floor(nTaskFlagValue/10);
        if self.tbBJPathLevel[nId][2] < 10 then
            Talk(1, "", "Ch璦 nh薾 竝 Ti猽 Bang.");
            return nil;
        end
    else
        Talk(1, "", "Ch璦 nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    local nCurrentTime = GetCurrentTime();
    local nTaskTimeValue = GetTask(TSK_LMBJTaskTime);
    if nCurrentTime - nTaskTimeValue > 1800 then
        Talk(1, "", "Nhi謒 v�  k誸 th骳, Ti猽 Xa  bi課 m蕋.");
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
    local tbPath = self.tbBJPathLevel[nId][1]; -- 押镖路线
    local nSid, nEid = unpack(tbPath);
    local szTitleMsg = format("<npc>Х nh薾 竝 Ti猽 Bang 10 Sao, %s-%s", self.tbBJPoints[nSid][1], self.tbBJPoints[nEid][1]);
    local szTempLine = "";
    -- 任务状态
    if (tbCurCarPos==nil or tbCurCarPos[1]==-1) then -- 镖车消失
        szTempLine = "<enter>Ti猽 Xa  bi課 m蕋, nhi謒 v� k誸 th骳.";
    else
        local nCurrentTime = GetCurrentTime();
        local nPassTime = nCurrentTime - GetTask(TSK_LMBJTaskTime);
        local nMapId, nX, nY = unpack(tbCurCarPos);
        local nMinTime = GetTask(TSK_TransTongCarTime) + GetTask(TSK_TransTongCarCD);
        local nTime = nMinTime - nCurrentTime;
        if nTime < 0 then
            nTime = 0;
        end
        szTempLine = format("<enter>дm ngc kho秐g %d ph髏, Ti猽 Xa Bang 產ng d鮪g t筰 %s(%d,%d)<enter>Th阨 gian ch� truy襫 t鑞g n Ti猽 Xa Bang %d gi﹜", 
            30-floor(nPassTime/60), tbGlobalMapId2Name[nMapId], floor(nX/8), floor(nY/16), nTime);
    end
    szTitleMsg = szTitleMsg..szTempLine;
    local tbOpt = {};
    tinsert(tbOpt, {" K誸 th骳 i tho筰!", });
    CreateNewSayEx(szTitleMsg, tbOpt);
    PlayerIndex = nOldPlayerIndex;
end

function pActivity:GoToTongBiaoChe()
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    -- 判断当前镖车等级
    if nTaskFlagValue ~= 0 then
        local nId = floor(nTaskFlagValue/10);
        if self.tbBJPathLevel[nId][2] < 10 then
            Talk(1, "", "Ch璦 nh薾 竝 Ti猽 Bang.");
            return nil;
        end
    else
        Talk(1, "", "Ch璦 nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    local nCurrentTime = GetCurrentTime();
    local nTaskTimeValue = GetTask(TSK_LMBJTaskTime);
    if nCurrentTime - nTaskTimeValue > 1800 then
        Talk(1, "", "Nhi謒 v�  k誸 th骳, Ti猽 Xa  bi課 m蕋.");
        return nil;
    end
    -- 检查传车的CD时间
    local nCDTime = GetTask(TSK_TransTongCarCD);
    local nMinTimes = GetTask(TSK_TransTongCarTime) + nCDTime;
    if nCurrentTime < nMinTimes then
        Talk(1, "", format("V蒼 ch璦 vt qu� %d gi﹜ so v韎 l莕 truy襫 t鑞g trc, i m閠 ch髏.", nCDTime));
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
        Talk(1, "", "Ti猽 Xa  b� ph� h駓 ho芻 bi課 m蕋, kh玭g th� truy襫 t鑞g");
        PlayerIndex = nOldPlayerIndex;
        return nil;
    end
    -- 设置传车时间
    local nCurTime = GetCurrentTime();
    local nTaskValue = GetTask(TSK_TransTongCarTime);
    local nCDTime = GetTask(TSK_TransTongCarCD);
    if nCDTime < 60 then
        SetTask(TSK_TransTongCarCD, nCDTime+20);
    end
    SetTask(TSK_TransTongCarTime, nCurTime);
    -- 设置战斗状态
    SetFightState(tbCurCarPos[4]);
    NewWorld(tbCurCarPos[1], tbCurCarPos[2], tbCurCarPos[3]);
    PlayerIndex = nOldPlayerIndex;
end

-- 放弃押镖任务
function pActivity:CancelTongTask()
    local szTongName, nTongId = GetTongName();
    if nTongId == 0 then
        return nil;
    end
    -- 检查是否已经开启
    local nYaBiaoState = self:GetTongWeekTaskValue(nTongId, TONG_TASK_YABIAO_STATE);
    if nYaBiaoState == 0 then
        Talk(1, "", "Ho箃 ng 竝 Ti猽 c馻 bang trong tu莕 n祔 ch璦 m�.");
        return nil;
    end
    -- 检查押镖时间
    local nCurTime = tonumber(GetLocalDate("%H%M"));
    if nCurTime < 1200 or nCurTime > 2300 then
        Talk(1, "", "Kh玭g trong th阨 gian m� 竝 Ti猽 Bang (12:00-23:00 Th� b秠, Ch� nh藅).");
        return nil;
    end
    -- 检查有没有正在进行的押镖任务
    local nTaskFlagValue = GetTask(TSK_LMBJTaskFlag);
    -- 判断当前镖车等级
    if nTaskFlagValue ~= 0 then
        local nId = floor(nTaskFlagValue/10);
        if self.tbBJPathLevel[nId][2] < 10 then
            Talk(1, "", "Ch璦 nh薾 竝 Ti猽 Bang.");
            return nil;
        end
    else
        Talk(1, "", "Ch璦 nh薾 竝 Ti猽 Bang.");
        return nil;
    end
    -- 查询镖车位置，有镖车不能放弃任务
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
        local szTitleMsg = "Ti猽 Xa Bang  b� h駓 ho芻 bi課 m蕋, ng � k誸 th骳 nhi謒 v� 竝 Ti猽 l莕 n祔?";
        local tbOpt = {};
        tinsert(tbOpt, {"уng � k誸 th骳 nhi謒 v�", self.ConfirmCancelTongTask, {self}});
        tinsert(tbOpt, {"в ta suy ngh� l筰!",});
        CreateNewSayEx(szTitleMsg, tbOpt);
        PlayerIndex = nOldPlayerIndex;
        return nil;
    end

    local nMapId, nX, nY = unpack(tbCurCarPos);
    szTempLine = format("Ti猽 Xa Bang 產ng d鮪g � %s(%d,%d), kh玭g th� b� nhi謒 v� 竝 Ti猽.", 
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
    -- 任务还没有超过30分钟，直接删除相应任务变量
    if nPassTime < 1800 then
        TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_TIME, 0);
    else
        local dwNameHash = String2Id(GetName());
        if self:GetCurExecutorHash(nTongId) == dwNameHash then
            TONG_ApplySetTaskValue(nTongId, TONG_TASK_YABIAO_TIME, 0);
        end
    end
    Talk(1, "", "竝 Ti猽 Bang l莕 n祔  h駓.");
    -- 日志
    self:WriteTongYBLog("竝 Ti猽 Bang  k誸 th骳");
end
