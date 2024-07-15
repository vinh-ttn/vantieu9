Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\activitysys\\playerfunlib.lua")

function main(nItemIndex)
	if PlayerFunLib:CheckFreeBagCell(1, "default") ~= 1 then
		return 1
	end

	local tbItem = 
	{
		{szName="Th­¬ng Long V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3560,1,0,0},nCount=1,nRate=4},
		{szName="Th­¬ng Long V¨n Tinh- Êt [CÊp 1]",tbProp={6,1,3570,1,0,0},nCount=1,nRate=4},
		{szName="Th­¬ng Long V¨n Tinh- BÝnh[CÊp 1]",tbProp={6,1,3580,1,0,0},nCount=1,nRate=4},
		{szName="Th­¬ng Long V¨n Tinh- §inh [CÊp 1]",tbProp={6,1,3590,1,0,0},nCount=1,nRate=4},
		{szName="¢m Méc V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3600,1,0,0},nCount=1,nRate=4},
		{szName="¢m Méc V¨n Tinh- Êt [CÊp 1]",tbProp={6,1,3610,1,0,0},nCount=1,nRate=4},
		{szName="HuyÒn Thñy V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3620,1,0,0},nCount=1,nRate=4},
		{szName="HuyÒn Thñy V¨n Tinh- Êt [CÊp 1]",tbProp={6,1,3630,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3640,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n Tinh- Êt [CÊp 1]",tbProp={6,1,3650,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n Tinh- BÝnh[CÊp 1]",tbProp={6,1,3660,1,0,0},nCount=1,nRate=4},
		{szName="Thiªn L«i V¨n Tinh- §inh [CÊp 1]",tbProp={6,1,3670,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3680,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n Tinh- Êt [CÊp 1]",tbProp={6,1,3690,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n Tinh- BÝnh[CÊp 1]",tbProp={6,1,3700,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n Tinh- §inh [CÊp 1]",tbProp={6,1,3710,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n Tinh- MËu[CÊp 1]",tbProp={6,1,3720,1,0,0},nCount=1,nRate=4},
		{szName="Nh­îc Thñy V¨n Tinh- Kû [CÊp 1]",tbProp={6,1,3730,1,0,0},nCount=1,nRate=4},
		{szName="Bµn Long V¨n Tinh #Gi¸p[cÊp 1 ]",tbProp={6,1,3740,1,0,0},nCount=1,nRate=4},
		{szName="Bµn Long V¨n Tinh #Êt [cÊp 1 ]",tbProp={6,1,3750,1,0,0},nCount=1,nRate=4},
		{szName="Kim Long V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3760,1,0,0},nCount=1,nRate=4},
		{szName="Thanh Méc V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3770,1,0,0},nCount=1,nRate=4},
		{szName="MÞch Thñy V¨n Tinh #Gi¸p[cÊp 1 ]",tbProp={6,1,3780,1,0,0},nCount=1,nRate=4},
		{szName="XÝch Háa V¨n Tinh- Gi¸p [CÊp 1]",tbProp={6,1,3790,1,0,0},nCount=1,nRate=4},
		{szName="L¹c L«i V¨n Tinh #Gi¸p[cÊp 1 ]",tbProp={6,1,3800,1,0,0},nCount=1,nRate=4},
	}
	tbAwardTemplet:Give(tbItem, 1, {"LongMenBiaoJu", "BiaoJuLibao"})
end