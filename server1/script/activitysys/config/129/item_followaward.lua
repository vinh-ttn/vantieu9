-- 龙门镖局（增益道具绑定脚本）
Include("\\script\\activitysys\\config\\129\\head.lua");
Include("\\script\\activitysys\\config\\129\\config.lua");
Include("\\script\\activitysys\\config\\129\\variables.lua")

Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

local tbAwardList = {
    [4473] = {
        { szName = "Ch﹏ Nguy猲 Кn (i)",  tbProp = {6,1,30229,1,0,0}, nRate = 10.0, nCount =  4, nBindState = -2,},
        { szName = "Ch﹏ Nguy猲 Кn (i)",  tbProp = {6,1,30229,1,0,0}, nRate =  1.0, nCount = 20, nBindState = -2,},
        { szName = "H� M筩h Кn",   tbProp = {6,1,3203,1,0,0}, nRate = 10.0, nCount =  20, nBindState = -2,},
        { szName = "H� M筩h Кn",   tbProp = {6,1,3203,1,0,0}, nRate =  1.0, nCount = 100, nBindState = -2,},
        { nExp_tl = 1, nCount =  20000000, nRate = 10.0, },
        { nExp_tl = 1, nCount =  50000000, nRate =  5.0, },
        { nExp_tl = 1, nCount =  100000000, nRate =  1.0, },
        { szName = "H錳 thi猲 t竔 t筼 l� bao",  tbProp = {6,1,2527,1,0,0}, nRate =  8.0, nCount = 1, nBindState = -2, nExpiredTime = 10080,},
        { szName = "H錳 thi猲 t竔 t筼 l� bao",  tbProp = {6,1,2527,1,0,0}, nRate =  4.0, nCount = 2, nBindState = -2, nExpiredTime = 10080,},
        { szName = "H錳 thi猲 t竔 t筼 l� bao",  tbProp = {6,1,2527,1,0,0}, nRate =  1.0, nCount = 3, nBindState = -2, nExpiredTime = 10080,},
        { szName = "Huy誸 Long Щng C蕄 9",  tbProp = {6,1,30289,9,0,0}, nRate = 5.0, nCount = 5, nBindState = -2,},
        { szName = "T� Ng鋍",  tbProp = {6,1,2391,1,0,0}, nRate =  3.0, nCount = 1, nBindState = -2,},
        { szName = "B筩h Ng鋍",  tbProp = {6,1,2390,1,0,0}, nRate =  5.0, nCount = 1, nBindState = -2,},
        { szName = "T骾 Dc Ph萴",  tbProp = {6,1,30557,1,0,0}, nRate = 15.0, nCount = 5, nBindState = -2, nExpiredTime = 10080,},
        { szName = "T藅 C玭g Tr� L鵦 Ho祅",  tbProp = {6,1,2952,1,0,0}, nRate = 10.0, nCount = 2, nBindState = -2, nExpiredTime = 10080,},
        { szName = "Tinh Thi誸 Kho竛g",  tbProp = {6,1,3810,1,0,0}, nRate =  1.0, nCount = 1, nBindState = -2,},
        { szName = " Dng Ho箃 Huy誸 Кn",  tbProp = {6,1,2953,1,0,0}, nRate = 10.0, nCount = 1, nBindState = -2, nExpiredTime = 10080,},
    },
    [4474] = {
        { szName = "Ch﹏ Nguy猲 Кn (i)",  tbProp = {6,1,30229,1,0,0}, nRate = 10.0, nCount = 8, nBindState = -2,},
        { szName = "Ch﹏ Nguy猲 Кn (i)",  tbProp = {6,1,30229,1,0,0}, nRate = 1.0, nCount = 40, nBindState = -2,},
        { szName = "H� M筩h Кn",    tbProp = {6,1,3203,1,0,0}, nRate = 10.0, nCount = 40, nBindState = -2,},
        { szName = "H� M筩h Кn",    tbProp = {6,1,3203,1,0,0}, nRate = 1.0, nCount = 200, nBindState = -2,},
        { nExp_tl = 1, nCount =  50000000, nRate = 10.0, },
        { nExp_tl = 1, nCount =  100000000, nRate =  4.0, },
        { nExp_tl = 1, nCount =  150000000, nRate =  1.0, },
        { szName = "H錳 thi猲 t竔 t筼 l� bao",  tbProp = {6,1,2527,1,0,0}, nRate = 10.0, nCount =  2, nBindState = -2, nExpiredTime = 10080,},
        { szName = "H錳 thi猲 t竔 t筼 l� bao",  tbProp = {6,1,2527,1,0,0}, nRate = 5.0, nCount =  3, nBindState = -2, nExpiredTime = 10080,},
        { szName = "H錳 thi猲 t竔 t筼 l� bao",  tbProp = {6,1,2527,1,0,0}, nRate = 1.0, nCount =  4, nBindState = -2, nExpiredTime = 10080,},
        { szName = "Щng Long Th筩h - H�",  tbProp = {6,1,30538,1,0,0}, nRate =  2.0, nCount =  5, nBindState = -2,},
        { szName = "Tinh Thi誸 Kho竛g",  tbProp = {6,1,3810,1,0,0}, nRate =  1.0, nCount = 1, nBindState = -2,},
        { szName = "L謓h 駓 Th竎 Cao C蕄",  tbProp = {6,1,4202,1,0,0}, nRate =  5.0, nCount =  3, nBindState = -2,},
        { szName = "Huy誸 Long Щng C蕄 11",  tbProp = {6,1,30289,11,0,0}, nRate =  13.0, nCount = 5, nBindState = -2,},
        { szName = "Huy誸 Long Щng C蕄 12",  tbProp = {6,1,30289,12,0,0}, nRate =  5.0, nCount = 5, nBindState = -2,},
        { szName = "T骾 Dc Ph萴",  tbProp = {6,1,30557,1,0,0}, nRate = 20.0, nCount = 5, nBindState = -2, nExpiredTime = 10080,},
        { szName = "Ph鬾g Nguy謙 Qu� Dung", tbProp = {6,1,127,1,0,0}, nRate =  1.0, nCount = 1, nBindState = -2,},
    },
}

function main(nItemIndex)
    local _, _, nP =  GetItemProp(nItemIndex);
    local tbAward = %tbAwardList[nP];
    if not tbAward then
        return nil;
    end
    local tbMinCells = {
        [4473] = 5,
        [4474] = 5,
    }
    -- 检查背包空间
    local nMincCells = tbMinCells[nP];
    local szTips = format("T骾 kh玭g  ch�, m b秓 c� %d � tr鑞g h穣 n.", nMincCells);
    if PlayerFunLib:CheckFreeBagCell(nMincCells, szTips) ~= 1 then
        return 1;
    end
    local szLogs = format("[Long M玭 Ti猽 C鬰_竝 Ti猽 Bang] D飊g o c� h� ti猽 (%s) nh薾 thng", GetItemName(nItemIndex));
    tbAwardTemplet:GiveAwardByList(tbAward, szLogs);
    return nil;
end

