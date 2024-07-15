local _GetNexStartTime = function(nStartHour, nStartMinute, nInterval)
	
	
	local nNextHour = nStartHour
	local nNextMinute = nInterval * ceil(nStartMinute / nInterval)
	
	if nNextMinute >= 60 then
		
		nNextHour = nNextHour + floor(nNextMinute / 60)
		nNextMinute = mod(nNextMinute, 60) 
	end
	
	if (nNextHour >= 24) then
		nNextHour = mod(nNextHour, 24);
	end;
	return nNextHour, nNextMinute
end



function TaskShedule()
	--ÉèÖÃ·½°¸Ãû³Æ
	TaskName("longmenbiaoju")
	
	local  nInterval = 60
	
	local nStartHour = tonumber(date("%H")) ;
	local nStartMinute = tonumber(date("%M"));
	
	local nNextHour, nNextMinute = %_GetNexStartTime(nStartHour, nStartMinute, nInterval)
	
	TaskTime(nNextHour, nNextMinute);

	--ÉèÖÃ¼ä¸ôÊ±¼ä£¬µ¥Î»Îª·ÖÖÓ
	TaskInterval(nInterval) --nInterval·ÖÖÓÒ»´Î
	--ÉèÖÃ´¥·¢´ÎÊý£¬0±íÊ¾ÎÞÏÞ´ÎÊý
	

	TaskCountLimit(0)
	


	local szMsg = format("=====%s ## %d:%d ### %d #? ?###=======", "T¨ng phÇn th­ëng Long M«n Tiªu Côc.",nNextHour, nNextMinute, nInterval)
	OutputMsg(szMsg);
end

function TaskContent()
	local nTime = tonumber(date("%H%M"))
	
	local flag = 0
	if (nTime >= 1300 and nTime < 1400) then
		flag = 1
	elseif nTime == 1400 then
		flag = 2
	elseif (nTime >= 1900 and nTime < 2000) then
		flag = 1
	elseif nTime == 2000 then
		flag = 2
	end
	
	if flag == 1 then
		local szMsg = "Ch­ëng m«n Lôc Tam C©n c«ng bè phÇn th­ëng gÊp béi, chiªu mé hiÖp kh¸ch vËn tiªu, thêi gian chØ cã mét tiÕng ®ång hå, c¸c hiÖp sÜ muèn tham gia h·y mau chãng b¸o danh nhÐ."
		GlobalExecute(format("dw AddLocalCountNews([[%s]], 1)", szMsg))
		GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
		OutputMsg("start longmenbiaoju award rise begin")
	elseif flag == 2 then
		local szMsg = "Thêi gian phÇn th­ëng gÊp béi Long M«n Tiªu Côc ®· qua, c¸c hiÖp kh¸ch xin h·y l­u ý thêi gian gÊp béi lÇn sau."
		GlobalExecute(format("dw AddLocalCountNews([[%s]], 1)", szMsg))
		GlobalExecute(format("dw Msg2SubWorld([[%s]])", szMsg))
		OutputMsg("start longmenbiaoju award rise end")
	end
end


function GameSvrConnected(dwGameSvrIP)

end

function GameSvrReady(dwGameSvrIP)

end