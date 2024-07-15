Include("\\script\\lib\\objbuffer_head.lua")

LongMenBiaoJu = {}
LongMenBiaoJu.GSCallBackList = {}
LongMenBiaoJu.RelayCallBackId = 0
LongMenBiaoJu.BiaoCheList = {}
LongMenBiaoJu.GenData = {}
LongMenBiaoJu.nCurDate = nil
LongMenBiaoJu.nCurDate = nil
LongMenBiaoJu.nCurDate = nil

LongMenBiaoJu.KEY_DAILY = 1
LongMenBiaoJu.KEY_WEEKLY = 2

LongMenBiaoJu.KEY = "EVENT_LongMenBiaoJu"

LongMenBiaoJu.RandomTable = {
	{nRate = 0,			tbRoute = {1} },			--1星 不参与随机，占位用
	{nRate = 0.4053,	tbRoute = {2,3,4,5,6,7,}},	--2星
	{nRate = 0.4,		tbRoute = {8,9,}},			--3星
	{nRate = 0.15,		tbRoute = {10,11,}},		--4星
	{nRate = 0.03,		tbRoute = {12,13,14,15,}},	--5星
	{nRate = 0.01,		tbRoute = {16,17,18,}},		--6星
	{nRate = 0.004,		tbRoute = {19,20,21,22,}},	--7星:每天全区服最多产出13
	{nRate = 0.0006,	tbRoute = {23,24,25,}},		--8星:每天全区服最多产出3
	{nRate = 0.0001,	tbRoute = {26,}},			--9星:每周全区服最多产出3
}

LongMenBiaoJu.MaxCount = {
	-1,-1,-1,-1,-1,-1,13,3,3
}

function LongMenBiaoJu:OnGSTransfer(HParam, HResult, nGameServerID)
	local nGSCallBackId = ObjBuffer:PopObject(HParam)
	if OB_IsEmpty(HParam) == 1 then
		return
	end
	
	local szFunction = ObjBuffer:PopObject(HParam)
	local tbCallParam = ObjBuffer:PopObject(HParam)
	
	if type(tbCallParam) ~= "table" then
		return
	end
	
	if tbCallParam[1] then
		if self.BiaoCheList[tbCallParam[1]] == nil then
			local HCallBack = OB_Create()
			ObjBuffer:PushObject(HCallBack, nGSCallBackId)
			ObjBuffer:PushObject(HCallBack, {})
			RemoteExecute("\\script\\event\\longmenbiaoju\\head.lua", "LongMenBiaoJu:OnRemoteRespond", HCallBack, "", 0, nGameServerID)
			OB_Release(HCallBack)
			return
		end
	end
	
	local nRelayCallBack = 0
	if nCallBackId ~= 0 then
		self.RelayCallBackId = self.RelayCallBackId + 1
		nRelayCallBack = self.RelayCallBackId
		local data = {nGSCallBackId = nGSCallBackId, nGSID = nGameServerID}
		self.GSCallBackList[nRelayCallBack] = data
	end
	
	local HCallParam = OB_Create()
	ObjBuffer:PushObject(HCallParam, nRelayCallBack)
	ObjBuffer:PushObject(HCallParam, szFunction)
	ObjBuffer:PushObject(HCallParam, tbCallParam)
	RemoteExecute("\\script\\event\\longmenbiaoju\\head.lua", "LongMenBiaoJu:OnRemoteCall", HCallParam)
	OB_Release(HCallParam)
end

function LongMenBiaoJu:OnGSReturn(HResult)
	local nRelayCallBack = ObjBuffer:PopObject(HResult)
	local tbResult = ObjBuffer:PopObject(HResult)
	if type(tbResult) ~= "table" or nRelayCallBack == 0 then
		return
	end

	local tbCallBack = self.GSCallBackList[nRelayCallBack]
	self.GSCallBackList[nRelayCallBack] = nil
	if not tbCallBack then
		return
	end
	
	local HCallBack = OB_Create()
	ObjBuffer:PushObject(HCallBack, tbCallBack.nGSCallBackId)
	ObjBuffer:PushObject(HCallBack, tbResult)
	RemoteExecute("\\script\\event\\longmenbiaoju\\head.lua", "LongMenBiaoJu:OnRemoteRespond", HCallBack, "", 0, tbCallBack.nGSID)
	OB_Release(HCallBack)
end

function LongMenBiaoJu:QueryBiaoChe(HParam, HResult)
	local szName = ObjBuffer:PopObject(HParam)
	if type(szName) ~= "string" then
		return
	end
	local tbData = self.BiaoCheList[szName] or {}

	ObjBuffer:PushObject(HResult, szName)
	ObjBuffer:PushObject(HResult, tbData)
end

function LongMenBiaoJu:SyncBiaoChe(HParam)
	local tbData = ObjBuffer:PopObject(HParam)
	if type(tbData) ~= "table" then
		return
	end
	if tbData.nLife > 0 then
		self.BiaoCheList[tbData.szOwner] = tbData
	else
		self.BiaoCheList[tbData.szOwner] = nil
	end
end

function LongMenBiaoJu:DeleteBiaoChe(HParam)
	local szName = ObjBuffer:PopObject(HParam)
	if type(szName) ~= "string" then
		return
	end
	self.BiaoCheList[szName] = nil
end

function LongMenBiaoJu:Load()
	local nCurDate = tonumber(date("%y%m%d"))
	local nCurWeek = tonumber(date("%y%W"))
	
	local DailyHandle = OB_Create()
	self.GenData.nDate = nCurDate
	self.GenData[7] = 0
	self.GenData[8] = 0
	OB_LoadShareData(DailyHandle, self.KEY, self.KEY_DAILY, nCurDate)
	if OB_IsEmpty(DailyHandle) ~= 1 then
		self.GenData[7] = ObjBuffer:PopObject(DailyHandle)
		self.GenData[8] = ObjBuffer:PopObject(DailyHandle)
	end
	OB_Release(DailyHandle)
	
	local WeeklyHandle = OB_Create()
	self.GenData.nWeek = nCurWeek
	self.GenData[9] = 0
	OB_LoadShareData(WeeklyHandle, self.KEY, self.KEY_WEEKLY, nCurWeek)
	if OB_IsEmpty(DailyHandle) ~= 1 then
		self.GenData[9] = ObjBuffer:PopObject(WeeklyHandle)
	end
	OB_Release(WeeklyHandle)
	
end

function LongMenBiaoJu:SaveData()
	local handle = OB_Create();
	ObjBuffer:PushObject(handle, self.GenData[7])
	ObjBuffer:PushObject(handle, self.GenData[8])
	OB_SaveShareData(handle, self.KEY, self.KEY_DAILY, self.GenData.nDate)
	OB_Release(handle)

	handle = OB_Create()
	ObjBuffer:PushObject(handle, self.GenData[9])
	OB_SaveShareData(handle, self.KEY, self.KEY_WEEKLY, self.GenData.nWeek)
	OB_Release(handle)
end

function LongMenBiaoJu:GenerateTask(HParam, HResult)
	if OB_IsEmpty(HParam) == 1 then
		return
	end
	
	local nCurDate = tonumber(date("%y%m%d"))
	if (nCurDate ~= self.GenData.nDate) then
		self:SaveData()
		self.GenData.nDate = nCurDate
		self.GenData[7] = 0
		self.GenData[8] = 0
	end
	
	local nCurWeek = tonumber(date("%y%W"))
	if (nCurWeek ~= self.GenData.nWeek) then
		self:SaveData()
		self.GenData.nWeek = nCurWeek
		self.GenData[9] = 0
	end
	
	local nType = 1
	local nRandValue = random(1, 10000)
	local nCurValue = 0
	local tbData = nil
	for i = 2, getn(self.RandomTable) do
		local tb = self.RandomTable[i]
		nCurValue = nCurValue + tb.nRate * 10000
		if nRandValue <= nCurValue then
			nType = self:FixType(i)
			tbData = self.RandomTable[nType]
			break
		end
	end

	local idx = random(1, getn(tbData.tbRoute))
	local nRouteId = tbData.tbRoute[idx]
	local nInvert = random(0, 1)

	local szPlayer = ObjBuffer:PopObject(HParam)
	ObjBuffer:PushObject(HResult, szPlayer)
	ObjBuffer:PushObject(HResult, nRouteId)
	ObjBuffer:PushObject(HResult, nInvert)
end

function LongMenBiaoJu:FixType(nType)
	local nCurType = nType
	
	while (self.MaxCount[nCurType] ~= -1 and self.GenData[nCurType] >= self.MaxCount[nCurType]) do
		nCurType = nCurType - 1
	end
	return  nCurType
end

function LongMenBiaoJu:AcceptRandomTask(ParamHandle)
	if OB_IsEmpty(ParamHandle) == 1 then
		return
	end
	
	local nType = ObjBuffer:PopObject(ParamHandle)
	local nCurDate = tonumber(date("%y%m%d"))
	if (nCurDate ~= self.GenData.nDate) then
		self.GenData.nDate = nCurDate
		self.GenData[7] = 0
		self.GenData[8] = 0
	end
	
	local nCurWeek = tonumber(date("%y%W"))
	if (nCurWeek ~= self.GenData.nWeek) then
		self.GenData.nWeek = nCurWeek
		self.GenData[9] = 0
	end
	
	if self.MaxCount[nType] > 0 then
		self.GenData[nType] = self.GenData[nType] + 1
	end
	self:SaveData()
end

function LongMenBiaoJu:Msg2Player(ParamHandle)
	if OB_IsEmpty(ParamHandle) == 1 then
		return
	end
	
	local szName = ObjBuffer:PopObject(ParamHandle)
	local szMsg = ObjBuffer:PopObject(ParamHandle)
	
	Msg2PlayerByName(szName, szMsg)
end

LongMenBiaoJu:Load()