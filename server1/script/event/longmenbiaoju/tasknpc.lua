Include("\\script\\event\\longmenbiaoju\\head.lua")
Include("\\script\\event\\longmenbiaoju\\lang.lua")

LongMenBiaoJu.BIAOSHI_PARAM_INDEX = 1
LongMenBiaoJu.BiaoShiPos = {
	["L©m An nam"] = {176,1448,3335,1},
	["L©m An b¾c"] = {176,1534,2974,2},
	[" Thµnh §«"] = {11,3061,4992,3},
	[" T­¬ng D­¬ng"] = {78,1537,3182,4},
	[" Ph­îng T­êng"] = {1,1597,3093,5},
	[" §¹i Lý "] = {162,1639,3215,6},
	[" BiÖn Kinh"] = {37,1690,3150,7},
	[" D­¬ng Ch©u"] = {80,1786,3037,8},
	["Giang T©n Th«n"] = {20,3516,6164,9},
	["VÜnh L¹c trÊn"] = {99,1673,3229,10},
	["Chu Tiªn trÊn"] = {100,1622,3113,11},
	["§¹o H­¬ng th«n"] = {101,1625,3209,12},
	["Th¹ch Cæ trÊn"] = {153,1677,3240,13},
	["Long TuyÒn th«n"] = {174,1596,3271,14},
}

LongMenBiaoJu.ZhangGuiPos = {
	{121,1987,4478},
}

LongMenBiaoJu.NpcList = {
	ZhangGui = {nNpcId = 2157, szName = LongMenBiaoJu.LANG.NPC_NAME_ZHANGGUI},
	BiaoShi = {nNpcId = 2145, szName = LongMenBiaoJu.LANG.NPC_NAME_BIAOSHI},
}

function LongMenBiaoJu:AddTaskNpc()
	local szScript = "\\script\\event\\longmenbiaoju\\tasknpc.lua"
	
	local tbNpc = LongMenBiaoJu.NpcList.ZhangGui
	for _, tbPos in LongMenBiaoJu.ZhangGuiPos do
		local nMapIndex = SubWorldID2Idx(tbPos[1])
		if nMapIndex >= 0 then
			local nNpcIndex = AddNpcEx(tbNpc.nNpcId, 1, 0, nMapIndex, tbPos[2]*32, tbPos[3]*32, 1, tbNpc.szName, 0)
			if nNpcIndex > 0 then
				SetNpcScript(nNpcIndex, szScript)
			end
		end
	end
	
	local tbNpc = LongMenBiaoJu.NpcList.BiaoShi
	for _, tbPos in LongMenBiaoJu.BiaoShiPos do
		local nMapIndex = SubWorldID2Idx(tbPos[1])
		if nMapIndex >= 0 then
			local nNpcIndex = AddNpcEx(tbNpc.nNpcId, 1, 0, nMapIndex, tbPos[2]*32, tbPos[3]*32, 1, tbNpc.szName, 0)
			if nNpcIndex > 0 then
				SetNpcScript(nNpcIndex, szScript)
				SetNpcParam(nNpcIndex, LongMenBiaoJu.BIAOSHI_PARAM_INDEX, tbPos[4])
			end
		end
	end
end

function main()
	local nNpcIndex = GetLastDiagNpc()
	local dlg = LongMenBiaoJu:GetDlgClass()
	dlg:OnNpcDialog(nNpcIndex)
end

AutoFunctions:Add(LongMenBiaoJu.AddTaskNpc)
