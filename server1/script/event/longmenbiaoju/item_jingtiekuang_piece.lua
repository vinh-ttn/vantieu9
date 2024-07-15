Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

TB_DEST_ITEM = {tbProp = {6, 1, 4538, 1,0, 0}, szName="Tinh Thi’t Kho∏ng kh´ng nguy™n ch t.", nCount=1, nBindState = -2}
NEED_ROOM = 1
NEED_COUNT = 10
TB_NEED_ITEM = {tbProp = {6, 1, 4536, 1,0, 0}, szName="M∂nh Tinh Thi’t Kho∏ng"}

function main(nItemIndex)
	if PlayerFunLib:CheckFreeBagCell(NEED_ROOM, "default") ~= 1 then
		return 1
	end

	local nMaxCanCompose = GetMaxCanCompose()
	g_AskClientNumberEx(0, nMaxCanCompose, format("NhÀp sË (0-%d)", nMaxCanCompose), {InputCallBack, {}})
	return 1
end

function InputCallBack(nCount)
	local nMaxCanCompose = GetMaxCanCompose()
	if nCount > nMaxCanCompose then
		nCount = nMaxCanCompose
	end
	
	if nCount == 0 then
		return 
	end
	
	if PlayerFunLib:CheckFreeBagCell(NEED_ROOM, "default") ~= 1 then
		return 
	end
	
	local nGenre, nDetail, nParticular, nLevel = unpack(TB_NEED_ITEM.tbProp)
	local nCostItem = nCount * NEED_COUNT
	local nCostCode = ConsumeEquiproomItem(nCostItem, nGenre, nDetail, nParticular, nLevel)
	if nCostCode ~= 1 then
		Talk(1, "", format("Kh u trı Æπo cÙ:[%s] %d th t bπi!", TB_NEED_ITEM.szName, nCostItem))
		return
	end
	tbAwardTemplet:Give(TB_DEST_ITEM, nCount, {"LongMenBiaoJu", "ComposeJinTieKuang"})
end

function GetMaxCanCompose()
	local tbNeddItemConfig = TB_NEED_ITEM.tbProp
	local nGenre, nDetail, nParticular, nLevel = unpack(tbNeddItemConfig)
	local nRoomPos = 3
	local nCurCount = CalcItemCount(nRoomPos,  nGenre, nDetail, nParticular, nLevel)
	local nMaxCanCompose = floor(nCurCount / NEED_COUNT)
	return nMaxCanCompose
end
