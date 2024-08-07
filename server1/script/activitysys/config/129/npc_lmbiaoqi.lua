-- 龙门镖局活动 -- 镖旗绑定脚本
Include("\\script\\activitysys\\config\\129\\head.lua")
Include("\\script\\activitysys\\config\\129\\config.lua")
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\activitysys\\playerfunlib.lua");

-- clear npc
function OnTimer(nNpcIndex, nTimeOut)
    DelNpc(nNpcIndex);
end

--入口函数
function main()
    --等级判断
    if PlayerFunLib:CheckTotalLevel(150, "Ch璦 t c蕄 150 v� ch璦 chuy觧 sinh kh玭g th� nh苩.", ">=") ~= 1 then
	    return nil;
    end
    -- 取出镖旗信息
    local nNpcIndex = GetLastDiagNpc();
    local nSaveHash = GetNpcParam(nNpcIndex, 2) + GetNpcParam(nNpcIndex, 3);
    local nTaskTime = GetNpcParam(nNpcIndex, 4);
    local nHashValue = String2Id(GetName());
    local nCurTaskTime = GetTask(TSK_LMBJTaskTime);
    if (GetNpcParam(nNpcIndex, 5) == 1) then
        return nil;
    end
    -- 镖旗是否属于该玩家
    if (nHashValue ~= nSaveHash ) then
        Msg2Player("Ngi kh玭g th� nh薾 Ti猽 K� c馻 ngi kh竎");
        return nil;
    end
    if (nTaskTime ~= nCurTaskTime) then
        SetNpcParam(nNpcIndex, 5, 1);
        DelNpc(nNpcIndex);
        return nil;
    end
    -- 判断是否接任务
    if (GetTask(TSK_LMBJTaskFlag) == 0) then
        SetNpcParam(nNpcIndex, 5, 1);
        DelNpc(nNpcIndex);
        return nil;
    end
    -- 背包空间判断
    local nMincCells = 1;
    local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return nil;
    end
    local tbBiaoQiItem = {szName = "Ti猽 K�", tbProp = {6,1,4200,1,0,0}, nBindState = -2,};
    PlayerFunLib:GetItem(tbBiaoQiItem, 1, "[Ho箃 ng Long M玭 Ti猽 C鬰] Ti猽 Xa b� cp nh薾 頲 Ti猽 K�");
    SetNpcParam(nNpcIndex, 5, 1);
    DelNpc(nNpcIndex);
end
