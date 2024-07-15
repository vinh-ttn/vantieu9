Include("\\script\\activitysys\\config\\129\\variables.lua")
tbConfig = {}
tbConfig[1] = --Ò»¸öÏ¸½Ú
{
	nId = 1,
	szMessageType = "ServerStart",
	szName = "Sö kiÖn më server",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {nil},
	tbCondition = 
	{
	},
	tbActition = 
	{
        --{"NpcFunLib:AddDialogNpc",	{szNpcZhangGuiName, nNpcZhangGuiID, tbNpcZhangGuiPos} },
        --{"NpcFunLib:AddDialogNpc",	{szNpcBiaoShiName, nNpcBiaoShiID, tbNpcBiaoShiPos} },
        {"NpcFunLib:AddObjNpc",	{szNpcConsignerName, nNpcConsignerID, tbNpcConsignerPos, szNpcConsignerScriptPath} },
        {"NpcFunLib:AddObjNpc",	{szNpcReceiverName, nNpcReceiverID, tbNpcReceiverPos, szNpcReceiverScriptPath} },
        {"ThisActivity:ServerStartCall",	{nil} },
    }
}
tbConfig[2] = --Ò»¸öÏ¸½Ú
{
	nId = 2,
	szMessageType = "PlayerLogin",
	szName = "Ng­êi ch¬i ®¨ng nhËp",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {0,1},
	tbCondition = 
	{
	},
	tbActition = 
	{
        {"ThisActivity:PlayerExchageServerLoginInit", {nil}},
	},
}

tbConfig[3] = --Ò»¸öÏ¸½Ú
{
	nId = 3,
	szMessageType = "PlayerLogin",
	szName = "Ng­êi ch¬i ®¨ng nhËp",
	nStartDate = nil,
	nEndDate  = nil,
	tbMessageParam = {0,0},
	tbCondition = 
	{
	},
	tbActition = 
	{
        {"ThisActivity:PlayerExchageServerLoginInit", {nil}},
	},
}
