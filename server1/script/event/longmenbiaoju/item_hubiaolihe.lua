Include("\\script\\activitysys\\playerfunlib.lua")

function main(nItemIndex)
	if PlayerFunLib:CheckFreeBagCell(1, "default") ~= 1 then
		return 1
	end
	local Item = {tbProp={6,1,4201,1,0,0}, nCount=20}
	PlayerFunLib:GetItem(Item, 1, "LongMenBiaoJu", "HuBiaoLiHe_award")
end