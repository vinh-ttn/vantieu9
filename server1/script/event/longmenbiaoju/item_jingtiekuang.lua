Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

function main(nItemIndex)
	if PlayerFunLib:CheckFreeBagCell(1, "default") ~= 1 then
		return 1
	end

	local tbItem = 
	{
		{szName="Th­¬ng Long V¨n C­¬ng- Gi¸p [CÊp 1]",tbProp={8,1,1,1,0,0},nCount=1,nRate=4},
		{szName="Th­¬ng Long V¨n C­¬ng- Êt [CÊp 1]",tbProp={8,1,11,1,0,0},nCount=1,nRate=4},
		{szName="Th­¬ng Long V¨n C­¬ng- BÝnh[CÊp 1]",tbProp={8,1,21,1,0,0},nCount=1,nRate=4},
		{szName="Th­¬ng Long V¨n C­¬ng- §inh [CÊp 1]",tbProp={8,1,31,1,0,0},nCount=1,nRate=4},
		{szName="¢m Méc V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,41,1,0,0},nCount=1,nRate=4},
		{szName="¢m Méc V¨n C­¬ng#Êt  [cÊp 1 ]",tbProp={8,1,51,1,0,0},nCount=1,nRate=4},
		{szName="HuyÒn Thñy V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,61,1,0,0},nCount=1,nRate=4},
		{szName="HuyÒn Thñy V¨n C­¬ng#Êt  [cÊp 1 ]",tbProp={8,1,71,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,81,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n C­¬ng#Êt  [cÊp 1 ]",tbProp={8,1,91,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n C­¬ng#BÝnh [cÊp 1 ]",tbProp={8,1,101,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n C­¬ng#§inh  [cÊp 1 ]",tbProp={8,1,111,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,121,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n C­¬ng#Êt  [cÊp 1 ]",tbProp={8,1,131,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n C­¬ng#BÝnh [cÊp 1 ]",tbProp={8,1,141,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n C­¬ng#§inh  [cÊp 1 ]",tbProp={8,1,151,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n C­¬ng#MËu  [cÊp 1 ]",tbProp={8,1,161,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n C­¬ng#Kû  [cÊp 1 ]",tbProp={8,1,171,1,0,0},nCount=1,nRate=4},
		{szName="Bµn Long V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,181,1,0,0},nCount=1,nRate=4},
		{szName="Bµn Long V¨n C­¬ng#Êt  [cÊp 1 ]",tbProp={8,1,191,1,0,0},nCount=1,nRate=4},
		{szName="Kim Long V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,201,1,0,0},nCount=1,nRate=4},
		{szName="Thanh Méc V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,211,1,0,0},nCount=1,nRate=4},
		{szName="MÞch Thñy V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,221,1,0,0},nCount=1,nRate=4},
		{szName="XÝch Háa V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,231,1,0,0},nCount=1,nRate=4},
		{szName="L¹c L«i V¨n C­¬ng#Gi¸p [cÊp 1 ]",tbProp={8,1,241,1,0,0},nCount=1,nRate=4},		
	}
	tbAwardTemplet:Give(tbItem, 1, {"LongMenBiaoJu", "BiaoJuLibao"})
end