Include("\\script\\activitysys\\functionlib.lua")
Include("\\script\\activitysys\\playerfunlib.lua")
Include("\\script\\dailogsys\\dailogsay.lua")
Include("\\script\\lib\\objbuffer_head.lua")
Include("\\script\\global\\autoexec_head.lua")
Include("\\script\\lib\\awardtemplet.lua")
Include("\\script\\lib\\log.lua")
IncludeLib("TASKSYS")

LongMenBiaoJu = {}
LongMenBiaoJu.nPack = curpack()
LongMenBiaoJu.TaskList = {}
LongMenBiaoJu.PlayerList = {}
LongMenBiaoJu.BiaoCheList = {}
LongMenBiaoJu.BiaoCheIndexList = {}
LongMenBiaoJu.RemoteCallList = {}
LongMenBiaoJu.nRemoteCallId = 0

LongMenBiaoJu.szRelayFile = "\\script\\event\\longmenbiaoju\\head.lua"
LongMenBiaoJu.szGsFile = "\\script\\event\\longmenbiaoju\\head.lua"

LongMenBiaoJu.StartTime = {10, 00}
LongMenBiaoJu.EndTime = {23, 00}

LongMenBiaoJu.TASK_ID = {
	BIAOCHE_TYPE_FLAG		= 3494,			--bytes  1:TYPE£¬ 2:Flag  3:Route  4:nInvertRoute
	BIAOCHE_REFRESH_COUNT	= 3495,		
	BIAOCHE_FINISH_COUNT	= 3496,	
	TASK_START_TIME			= 3497,
	BIAOWU_PICK_COUNT		= 3498,
	TRANSFER_TIME	= 3499,
	ITEM1_USE_TIME	= 3500,
	ITEM2_USE_TIME	= 3501,
	ITEM3_USE_TIME	= 3502,
	TASK_TEMP_DATA	= 3503,
	BIAOCHE_FINISH_SUCCESS_COUNT = 4111, 
}

LongMenBiaoJu.FAILED_EXP = 1000000	--ÈÎÎñÊ§°ÜµÄ ¾­Ñé½±Àø

LongMenBiaoJu.FOLLOW_DISTANCE	= 750*750 --ïÚ³µ¸úËæ°ë¾¶µÄÆ½·½Öµ
LongMenBiaoJu.FINISH_DISTANCE	= 600 * 600 --Íê³ÉÈÎÎñÊ±£¬ïÚ³µÓëÍæ¼ÒµÄ×î´ó¾àÀëÆ½·½Öµ

LongMenBiaoJu.TASK_TIME			= 30 * 60 --ÈÎÎñÊ±¼ä
LongMenBiaoJu.BIAOCHE_LIFE		= 30 * 60 --ïÚ³µÉú´æÊ±¼ä
LongMenBiaoJu.BIAOCHE_ALONE		= 5 * 60  --ÑºïÚÍæ¼ÒÀë¿ªïÚ³µºó£¬ïÚ³µÏûÊ§µÄÊ±¼ä
LongMenBiaoJu.BIAOQI_TIME		= 10 * 60 --ÆÆËðµÄïÚ³µ´æÔÚÊ±¼ä
LongMenBiaoJu.BOX_TIME			= 10 * 60 --É¢ÂäµÄïÚÎï´æÔÚÊ±¼ä
LongMenBiaoJu.BOX_PROTECT_TIME	= 3 * 60  --É¢ÂäµÄïÚÎï±£»¤Ê±¼ä

LongMenBiaoJu.MIN_NOTIFY_TYPE	= 7	--ïÚ³µÊÀ½ç¹«¸æµÄ×îÐ¡ÐÇ¼¶
LongMenBiaoJu.MAX_TASK_COUNT	= 3	--Ã¿Ìì×î´óµÄÈÎÎñÊýÁ¿£¨ÓÃµÀ¾ß½ÓÊÜµÄ²»Ëã£©
LongMenBiaoJu.MAX_REFRESH_COUNT	= 5	--Ã¿ÌìÃâ·ÑË¢ÐÂÈÎÎñµÄ´ÎÊý
LongMenBiaoJu.MIN_LEVEL			= 120	--²Î¼ÓµÄ×îÐ¡µÈ¼¶
LongMenBiaoJu.MAX_BIAO_WU_PICK_COUNT	= 5 --Ã¿ÌìÊ°È¡ïÚÎïµÄ×î´ó´ÎÊý

LongMenBiaoJu.TRANSFER_COST	= 10000	--´«ËÍµ½ïÚ³µµÄ·ÑÓÃ
LongMenBiaoJu.TRANSFER_CD	= 30	--´«ËÍCD

LongMenBiaoJu.ItemList = {
	BiaoQi={tbProp={6,1,4200,1,0,0}, nBindState = -2},
	PingZheng={tbProp={6,1,4201,1,0,0}},
	WeiRenZhuang={tbProp={6,1,4202,-1,0,0}},
	HuBiaoLing={tbProp={6,1,4203,1,0,0}, nBindState=-2},
	KuaiMaJiaBian={tbProp={6,1,4204,1,0,0}, nBindState=-2, nSkillId=1467, CD=3*60, nPrice=1, nTaskId=LongMenBiaoJu.TASK_ID.ITEM1_USE_TIME},
	JianBuKeCui={tbProp={6,1,4205,1,0,0}, nBindState=-2, nSkillId=1468, CD=3*60, nPrice=1, nTaskId=LongMenBiaoJu.TASK_ID.ITEM2_USE_TIME, tbSkillLevel={1,2,3}},
	BiaoCheWeiYi={tbProp={6,1,4207,1,0,0}, nBindState=-2, nPrice=1, CD=3*60, nTaskId=LongMenBiaoJu.TASK_ID.ITEM3_USE_TIME},
}

LongMenBiaoJu.tbAwardRiseTime = 
{
	{1300, 1400},
	{1900, 2000},
}

LongMenBiaoJu.tbAwardRiseFactor = 2
LongMenBiaoJu.tbLogTittle = {"LongMenBiaoJu", "BaseAward"}

--ÁìÈ¡1£¬ÔËËÍ2£¬ÁìÈ¡½±Àø3
LongMenBiaoJu.TSK_IS_IN_AWARDRISE_TIME = 4110
LongMenBiaoJu.tbAwardBaseParam = 
{
	--nExpFactor, nCurrencyFactor, nExpBiaoCheFactor, nCurrencyBiaoCheFactor
	--nResult1 = (nLevel + nTransLife * 200) * nAwardFactor * nBiaoCheFactor
	--nResult2= (nLevel + nTransLife * 200) * nAwardFactor * nBiaoCheFactor * 0.3
	[1] = {1500, 0, 1, 4},
	[2] = {1500, 0, 1.3, 4.3},
	[3] = {1500, 0, 3, 4.5},
	[4] = {1500, 200, 4.8, 4.8},
	[5] = {1500, 200, 6, 5},
	[6] = {1500, 200, 7, 5.3},
	[7] = {1500, 200, 8, 5.8},
	[8] = {1500, 200, 9.6, 6.3},
	[9] = {1500, 200, 11, 7},
}

LongMenBiaoJu.tbExtraAward = {szName = "LÔ Bao Tiªu Côc", tbProp={6,1,4534,1,0,0}, nCount=1, nBindState = -2}
LongMenBiaoJu.nExtraAwardCondition = 3
LongMenBiaoJu.nExpBiaocheOtherFactor = 1.1

function LongMenBiaoJu:NewPlayer(szName)
	local tbNew = self.PlayerClass:New()
	self.PlayerList[szName] = tbNew
	return tbNew
end

function LongMenBiaoJu:DelPlayer(szName)
	self.PlayerList[szName] = nil
end

function LongMenBiaoJu:FindPlayer(szName)
	return self.PlayerList[szName]
end

function LongMenBiaoJu:NewBiaoChe(nType, nMapId, nX, nY, szOwner)
	local tbNew = self.BiaoCheClass:New(nType, nMapId, nX, nY, szOwner)
	if tbNew then
		self.BiaoCheIndexList[tbNew.nNpcIndex] = tbNew
		self.BiaoCheList[tbNew.szOwner] = tbNew
	end
	return tbNew
end

function LongMenBiaoJu:NewBrokenBiaoChe(nMapIndex, nX32, nY32, szOwner, nTaskTime)
	local tbNew = self.BrokenBiaoCheClass:CreateNpc(nMapIndex, nX32, nY32, szOwner, nTaskTime)
	return tbNew
end

function LongMenBiaoJu:NewDropBox(nType, nMapIndex, nX32, nY32, szOwner)
	local tbNew = self:GetBoxClass():CreateNpc(nType, nMapIndex, nX32, nY32, szOwner)
	return tbNew
end

function LongMenBiaoJu:RemoveBiaoChe(npc)
	self.BiaoCheIndexList[npc.nNpcIndex] = nil
	self.BiaoCheList[npc.szOwner] = nil
end

function LongMenBiaoJu:FindBiaoChe(szName)
	return self.BiaoCheList[szName]
end

function LongMenBiaoJu:FindBiaoCheByIndex(nNpcIndex)
	return self.BiaoCheIndexList[nNpcIndex]
end

function LongMenBiaoJu:GetTaskClass()
	return self.TaskClass
end

function LongMenBiaoJu:GetDataClass()
	return self.TaskDataClass
end

function LongMenBiaoJu:GetDlgClass()
	return self.DlgClass
end

function LongMenBiaoJu:GetBoxClass()
	return self.BoxClass
end

function LongMenBiaoJu:RemoteCall(szFunction, tbCallParam, szCallBack, tbCallBackParam)
	local nCallBackId = 0

	if szCallBack and tbCallBackParam then
		self.nRemoteCallId = self.nRemoteCallId + 1
		nCallBackId = self.nRemoteCallId
		self.RemoteCallList[nCallBackId] = {
			szFunction = szCallBack,
			tbParam = tbCallBackParam,
		}
	end

	local handle = OB_Create()
	ObjBuffer:PushObject(handle, nCallBackId)
	ObjBuffer:PushObject(handle, szFunction)
	ObjBuffer:PushObject(handle, tbCallParam)
	RemoteExecute(self.szRelayFile, "LongMenBiaoJu:OnGSTransfer", handle)
	OB_Release(handle)
end

function LongMenBiaoJu:OnRemoteCall(HParam)
	if OB_IsEmpty(HParam) == 1 then
		return
	end
	
	local nCallBackId = ObjBuffer:PopObject(HParam)
	local szFunction = ObjBuffer:PopObject(HParam)
	local tbParam = ObjBuffer:PopObject(HParam)
	if type(tbParam) ~= "table" then
		return
	end
	
	local pFunction = self[szFunction]
	if type(pFunction) ~= "function" then
		return
	end
	
	local tbResule = pack(pFunction(self, unpack(tbParam)))
	
	if nCallBackId ~= 0 and getn(tbResule) > 0 then --ÓÐ·µ»ØÖµ²Å»Øµ÷
		local HResult = OB_Create()
		ObjBuffer:PushObject(HResult, nCallBackId)
		ObjBuffer:PushObject(HResult, tbResule)
		RemoteExecute(self.szRelayFile, "LongMenBiaoJu:OnGSReturn", HResult)
		OB_Release(HResult)
	end
end

function LongMenBiaoJu:OnRemoteRespond(HResult)
	if OB_IsEmpty(HResult) == 1 then
		return
	end
	local nCallBackId = ObjBuffer:PopObject(HResult)
	local tbResult = ObjBuffer:PopObject(HResult)
	
	if nCallBackId == 0 or type(tbResult) ~= "table" then
		return
	end
	
	local CallBack = self.RemoteCallList[nCallBackId]
	self.RemoteCallList[nCallBackId] = nil
	if not CallBack then
		return
	end
	
	for i = 1, getn(tbResult) do
		tinsert(CallBack.tbParam, tbResult[i])
	end
	
	if type(CallBack.szFunction) == "function" then
		CallBack.szFunction(unpack(CallBack.tbParam))
	else
		local pFunction = self[CallBack.szFunction]
		if type(pFunction) ~= "function" then
			return
		end
		pFunction(self, unpack(CallBack.tbParam))
	end
	
end

function LongMenBiaoJu:DeleteBiaoCheForTransfer(szOwner)
	local task = self:GetTaskClass()
	return task:DeleteBiaoCheForTransfer(szOwner)
end

function LongMenBiaoJu:WriteLog(...)
	--WriteLog(unpack(arg))
end

function LongMenBiaoJu:ResetRecordIsAwardRiseTime()
	SetTask(self.TSK_IS_IN_AWARDRISE_TIME, 0)
end

function LongMenBiaoJu:CanGetAwardRise()
	local nRetCode = 0
	local nAcceptRetCode = GetBitTask(self.TSK_IS_IN_AWARDRISE_TIME, 1, 1)
	local nDoTaskRetCode = GetBitTask(self.TSK_IS_IN_AWARDRISE_TIME, 2, 1)
	local nGetPrizeRetCode = GetBitTask(self.TSK_IS_IN_AWARDRISE_TIME, 3, 1)
	if nAcceptRetCode * nDoTaskRetCode * nGetPrizeRetCode == 0 then
		nRetCode = 0
		return nRetCode
	end
	nRetCode = 1
	return 1
end

function LongMenBiaoJu:IsInAwardRiseTime()
	local nRetCode = 0
	local tbTime = Time2Tm(GetCurServerTime())
	local _, _, _, nHour, nMin = unpack(tbTime)
	local nCurTime = nHour * 100 + nMin
	for nIndex, tbTimeConfig in LongMenBiaoJu.tbAwardRiseTime do
		local nBeginTime, nEndTime = unpack(tbTimeConfig)
		if nCurTime >= nBeginTime and nCurTime <= nEndTime then
			nRetCode = 1
			return nRetCode
		end
	end
	return nRetCode
end

function LongMenBiaoJu:GetExpAwardValueSuccess(nExpAwardFactor, nBiaoCheFactor)
	nExpAwardFactor = nExpAwardFactor or 0
	nBiaoCheFactor = nBiaoCheFactor or 0
	local nCurLevel = GetLevel()
	local nTransLife = ST_GetTransLifeCount()
	local nResult = (nCurLevel + nTransLife * 200) * nExpAwardFactor * nBiaoCheFactor * LongMenBiaoJu.nExpBiaocheOtherFactor
	return nResult 
end

function LongMenBiaoJu:GetCurrencyAwardValueSuccess(nCurrencyAwardFactor, nBiaoCheFactor)
	nCurrencyAwardFactor = nCurrencyAwardFactor or 0
	nBiaoCheFactor = nBiaoCheFactor or 0
	local nCurLevel = GetLevel()
	local nTransLife = ST_GetTransLifeCount()
	local nResult = (nCurLevel + nTransLife * 200) * nCurrencyAwardFactor * nBiaoCheFactor
	return nResult 
end

function LongMenBiaoJu:GetExpAwardValue(nExpAwardFactor, nBiaoCheFactor)
	nExpAwardFactor = nExpAwardFactor or 0
	nBiaoCheFactor = nBiaoCheFactor or 0
	local nCurLevel = GetLevel()
	local nTransLife = ST_GetTransLifeCount()
	local nResult = (nCurLevel + nTransLife * 200) * nExpAwardFactor * nBiaoCheFactor * 0.3 * LongMenBiaoJu.nExpBiaocheOtherFactor
	return nResult 
end

function LongMenBiaoJu:GetCurrencyAwardValue(nCurrencyAwardFactor, nBiaoCheFactor)
	nCurrencyAwardFactor = nCurrencyAwardFactor or 0
	nBiaoCheFactor = nBiaoCheFactor or 0
	local nCurLevel = GetLevel()
	local nTransLife = ST_GetTransLifeCount()
	local nResult = (nCurLevel + nTransLife * 200) * nCurrencyAwardFactor * nBiaoCheFactor * 0.3
	return nResult
end
