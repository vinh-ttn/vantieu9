Include("\\script\\event\\longmenbiaoju\\head.lua")

local TaskDataClass = {}

function TaskDataClass:New()
	return self
end

function TaskDataClass:SetTaskByte(nId, nByte, nValue)
	SetBitTask(nId, (nByte-1)*8, 8, nValue)
	SyncTaskValue(nId)
end

function TaskDataClass:GetTaskByte(nId, nByte)
	return GetBitTask(nId, (nByte-1)*8, 8)
end

function TaskDataClass:GetTempRouteRandom()
	local nRouteId = self:GetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 3)
	local nInvert = self:GetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 4)
	return nRouteId, nInvert
end

function TaskDataClass:SetTempRouteRandom(nRouteId, nInvert)
	self:SetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 3, nRouteId)
	self:SetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 4, nInvert)
end

function TaskDataClass:GetTempRouteLow()
	local nRouteId = self:GetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 1)
	local nInvert = self:GetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 2)
	return nRouteId, nInvert
end

function TaskDataClass:SetTempRouteLow(nRouteId, nInvert)
	self:SetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 1, nRouteId)
	self:SetTaskByte(LongMenBiaoJu.TASK_ID.TASK_TEMP_DATA, 2, nInvert)
end

function TaskDataClass:GetType()
	return self:GetTaskByte(LongMenBiaoJu.TASK_ID.BIAOCHE_TYPE_FLAG, 1)
end

function TaskDataClass:SetType(nType)
	self:SetTaskByte(LongMenBiaoJu.TASK_ID.BIAOCHE_TYPE_FLAG, 1, nType)
end

function TaskDataClass:SetRoute(nRouteId, nInvert)
	self:SetTaskByte(LongMenBiaoJu.TASK_ID.BIAOCHE_TYPE_FLAG, 3, nRouteId)
	self:SetTaskByte(LongMenBiaoJu.TASK_ID.BIAOCHE_TYPE_FLAG, 4, nInvert)
end

function TaskDataClass:GetRoute()
	local nRouteId = self:GetTaskByte(LongMenBiaoJu.TASK_ID.BIAOCHE_TYPE_FLAG, 3)
	local nInvert = self:GetTaskByte(LongMenBiaoJu.TASK_ID.BIAOCHE_TYPE_FLAG, 4)
	return nRouteId, nInvert
end

function TaskDataClass:SetTransferFlag(nFlag)
	self:SetTaskByte(LongMenBiaoJu.BIAOCHE_TYPE_FLAG, 2, nFlag)
end

function TaskDataClass:GetTransferFlag()
	return self:GetTaskByte(LongMenBiaoJu.BIAOCHE_TYPE_FLAG, 2)
end

function TaskDataClass:ClearAll()
	local tb = LongMenBiaoJu.TASK_ID
	SetTask(tb.BIAOCHE_TYPE_FLAG, 0)
	SetTask(tb.TASK_START_TIME, 0)
end

function TaskDataClass:GetStartTime()
	return GetTask(LongMenBiaoJu.TASK_ID.TASK_START_TIME)
end

function TaskDataClass:SetStartTime(nTime)
	SetTask(LongMenBiaoJu.TASK_ID.TASK_START_TIME, nTime)
end


LongMenBiaoJu.TaskDataClass = TaskDataClass
