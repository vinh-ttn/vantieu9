Include("\\script\\event\\longmenbiaoju\\head.lua")

local StartTime = LongMenBiaoJu.StartTime
local EndTime = LongMenBiaoJu.EndTime

LongMenBiaoJu.ItemList.BiaoQi.szName = "Tiªu Kú"
LongMenBiaoJu.ItemList.PingZheng.szName = "Ho¸n Tiªu ChØ"
LongMenBiaoJu.ItemList.WeiRenZhuang.szName = "¸p tiªu ñy nhiÖm tr¹ng cao cÊp"
LongMenBiaoJu.ItemList.HuBiaoLing.szName = "Hé Tiªu LÖnh"
LongMenBiaoJu.ItemList.KuaiMaJiaBian.szName = "Kho¸i M· Gia Tiªn"
LongMenBiaoJu.ItemList.JianBuKeCui.szName = "Kiªn BÊt Kh¶ Táa"
LongMenBiaoJu.ItemList.BiaoCheWeiYi.szName = "Tiªu Xa Di VÞ"

LongMenBiaoJu.LANG = {
	BIAOCHE_NAME = "Tiªu Xa %d sao cña %s",
	BIAOCHE_NOTIFY = "Tiªu Xa %d sao cña %s sÏ xuÊt hiÖn t¹i b¶n ®å %s",
	
	DLG_ITEM_NAME_1 = "Kho¸i M· Gia Tiªn (t¨ng tèc)",
	DLG_ITEM_NAME_2 = "Kiªn BÊt Kh¶ Táa (håi phôc m¸u)",
	DLG_ITEM_NAME_3 = "Tiªu Xa Di VÞ (tr¸nh kÑt)",
	
	NPC_NAME_BIAOWU = "T¸n L¹c Tiªu VËt",
	NPC_NAME_BROKEN_BIAOCHE = "Tiªu Xa bÞ ph¸ ho¹i",
	NPC_NAME_ZHANGGUI = "¤ng chñ Tiªu côc Lôc Tam C©n",
	NPC_NAME_BIAOSHI = "Long M«n Tiªu S­",
	
	DLG_MAIN_CONTENT = "Giang hå hiÓm ¸c, lßng ng­êi khã ®o¸n, nhê vËy mµ viÖc lµm ¨n cña Tiªu côc ta ngµy cµng tèt. HiÖn t¹i nh©n lùc kh«ng ®ñ, ta thÊy ®¹i hiÖp cèt c¸ch tinh c¬, m¹nh mÏ chi b»ng gióp chóng ta vËn 1 chuyÕn Tiªu Xa, phÇn th­ëng nhÊt ®Þnh sÏ lµm ng­¬i hµi lßng. Ngoµi ra, sau khi hoµn thµnh nhiÖm vô vËn tiªu sÏ nhËn ®­îc 'Hé Tiªu LÖnh' cã thÓ dïng ®Ó ®æi ®¹o cô khi cÇn ®Ó vËn tiªu t¹i cöa hµng Tiªu côc.",
	DLG_ACCEPT_TASK = "NhËn nhiÖm vô ¸p Tiªu",
	DLG_START_TASK = "B¾t ®Çu ¸p Tiªu",
	DLG_CANCEL_TASK = "Tõ bá nhiÖm vô ¸p Tiªu",
	DLG_GET_AWARD = "NhËn phÇn th­ëng nhiÖm vô ¸p Tiªu",
	DLG_VIEW_INFO = "KiÓm tra th«ng tin ¸p Tiªu",
	DLG_TRANSFER_TO_BIAOCHE = format("TruyÒn tèng ®Õn vÞ trÝ cña Tiªu Xa (%d l­îng)", LongMenBiaoJu.TRANSFER_COST),
	DLG_OPEN_SHOP = "Cöa hµng Tiªu côc",
	DLG_CONFIRM = " Sö dông",
	DLG_CANCEL = " Hñy bá ",
	DLG_CLOSE = " §ãng",
	DLG_CLOSE_2 = "Ta ®i t×m l¹i xem sao",
	DLG_ACCEPT_CONTENT = "§¹i hiÖp rÊt can ®¶m, ë ®©y ta cã c¸c lo¹i nhiÖm vô ¸p Tiªu, h·y l­îng søc mµ lùa chän cho phï hîp. GÇn ®©y trong rõng th­êng xuyªn cã c­íp Tiªu, khi ¸p Tiªu Xa cao cÊp nhí ph¶i cã tæ ®éi ®i cïng. Tiªu Xa bÞ c­íp th× ®èi víi ng­¬i hay ta ®Òu lµ 1 tæn thÊt lín.",
	DLG_ACCEPT_TYPE_LOW = "NhËn nhiÖm vô ¸p Tiªu 1 sao",
	DLG_ACCEPT_TYPE_RANDOM = "NhËn nhiÖm vô ¸p Tiªu ngÉu nhiªn",
	DLG_ACCEPT_TYPE_HIGH = "NhËn nhiÖm vô ¸p Tiªu cao cÊp",
	DLG_FREE_REFRESH_END = "Ng­¬i ®· dïng hÕt sè lÇn lµm míi miÔn phÝ cña ngµy h«m nay, muèn sö dông tiÕp <color=red> Ho¸n Tiªu ChØ <color>.",
	DLG_FREE_REFRESH_AVAILABLE = "Sè lÇn sö dông miÔn phÝ cña h«m nay vÉn cßn, ng­¬i kh«ng cÇn sö dông Ho¸n Tiªu ChØ.",
	DLG_REFRESH_USING_ITEM_CONFIRM = "Cã ph¶i muèn sö dông Ho¸n Tiªu ChØ ®Ó lµm míi nhiÖm vô?",
	DLG_CONFIRM_TASK_CONTENT = "NhiÖm vô Tiªu Xa %d sao, ®iÓm khëi hµnh:%s - ®iÓm kÕt thóc:%s, trong %d phót sÏ ®Õn, cã tiÕp nhËn kh«ng?",
	DLG_HIGH_CONTENT = "Ng­¬i muèn thö th¸ch b¶n th©n nhËn nhiÖm vô ¸p Tiªu khã nhÊt? Kh«ng cã thùc lùc th× kh«ng ®­îc, nÕu nh­ ng­¬i cã <color=red> ¸p tiªu ñy nhiÖm tr¹ng cao cÊp <color> th× ta cã thÓ suy nghÜ l¹i.",
	DLG_HIGH_CONFIRM = "Sö dông ¸p tiªu ñy nhiÖm tr¹ng cao cÊp",
	DLG_HIGH_CONTENT_FINAL = "Nép ¸p tiªu ñy nhiÖm tr¹ng cao cÊp sÏ ngÉu nhiªn xuÊt hiÖn nhiÖm vô ¸p Tiªu 7 sao, 8 sao, 9 sao. Ng­¬i ®· chuÈn bÞ xong ch­a?",
	DLG_RANDOM_ACCEPT = "NhËn (kh«ng thÓ lµm míi nhiÖm vô)",
	DLG_RANDOM_REFRESH_FREE = "Lµm míi nhiÖm vô miÔn phÝ",
	DLG_RANDOM_REFRESH_CHARGE = "Sö dông Ho¸n Tiªu ChØ lµm míi nhiÖm vô",
	DLG_CANCEL_CONFIRM = "§¹i hiÖp x¸c ®Þnh lÇn nµy kh«ng thÓ xuÊt Tiªu kh«ng?",
	DLG_TOO_YONG = "Ng­¬i vÉn ch­a ®Õn cÊp 120, h·y cè g¾ng h¬n n÷a.",
	DLG_CAMP_ERROR = "ThiÕu HiÖp, hiÖn t¹i ThiÕu HiÖp kh«ng thÓ l·nh nhËn nhiÖm vô Long M«n Tiªu Côc.",
	DLG_GET_AWARD_NOT_FINISH_CONTENT = "NhiÖm vô ch­a kÕt thóc. Tiªu Xa vµ Tiªu Kú ®Òu mÊt hÕt råi th× cã thÓ kÕt thóc nhiÖm vô vµ nhËn 100 v¹n kinh nghiÖm. Tiªu Xa bÞ c­íp th× t×m l¹i <color=red> Tiªu Kú <color> cã thÓ nhËn 1 phÇn cña phÇn th­ëng",
	DLG_GET_AWARD_QUERY = "KÕt thóc nhiÖm vô, nhËn kinh nghiÖm",
	DLG_FINISH_TASK_BIAOQI = "Tuy lµ Tiªu Xa bÞ c­íp nh­ng còng may c­íp l¹i ®­îc Tiªu Kú, kh«ng cã c«ng còng cã søc, cã chót tiÒn cho ng­¬i mua r­îu h·y nhËn lÊy.",
	DLG_FINISH_TASK_OK = "NhiÖm vô thµnh c«ng",
	DLG_FINISH_TASK_BIAOCHE_EXIST = "Tiªu Xa cña ng­¬i vÉn cßn, h·y mau ®i t×m l¹i ®i.",
	DLG_FINISH_TASK_FAILED = "Tiªu Xa cña ng­¬i ®· biÕn mÊt hoÆc bÞ ph¸ hñy, cã ph¶i kÕt thóc nhiÖm vô lÇn nµy?",
	
	DLG_SHOP = "Do ®¹i hiÖp tham gia vµo viÖc hé tiªu nªn Tiªu S­ cña chóng ta ®· c¶i tiÕn 1 tÝ nót ®ãng më Tiªu Xa, c¶i t¹o kh«ng Ýt, ng­¬i cã thÓ lÊy<color=red> Hé Tiªu LÖnh <color>®Ó ®æi. Khi vËn tiªu cã thÓ sö dông ®¹o cô nµy ®èi víi Tiªu Xa kÕ bªn, b¶o ®¶m ®¹i hiÖp dïng nöa søc nh­ng c«ng gÊp ®«i.",
	
	DLG_BACK = "Trë vÒ",
	
	MSG_NO_ITEM_PZ = "Ng­¬i kh«ng cã<color=red> Ho¸n Tiªu ChØ <color>, kh«ng thÓ lµm míi nhiÖm vô.",
	MSG_NO_ITEM_WRZ = "Ng­¬i kh«ng cã ¸p tiªu ñy nhiÖm tr¹ng cao cÊp, ®õng phÝ thêi gian n÷a.",
	MSG_NOT_OPEN = format("Kh«ng trong thêi gian ¸p Tiªu %.2d:%.2d-%.2d:%.2d, ®¹i hiÖp h·y quay vÒ ®i", StartTime[1], StartTime[2], EndTime[1], EndTime[2]),
	MSG_BIWO_WU_MAX = format("Mçi ngµy mçi ®¹i hiÖp chØ cã thÓ nhËn %d lÇn ¸p Tiªu, h«m nay sè lÇn nhËn cña ®¹i hiÖp ®· hÕt.", LongMenBiaoJu.MAX_BIAO_WU_PICK_COUNT),
	MSG_MAX_COUNT_DAILY = format("H«m nay ng­¬i ®· hoµn thµnh %d lÇn ¸p Tiªu, ngµy mai quay l¹i ®i.", LongMenBiaoJu.MAX_TASK_COUNT),
	MSG_ALREADY_ACCEPT = "Ng­¬i ®· nhËn nhiÖm vô, h·y n¾m b¾t thêi gian",
	MSG_NEED_FINISH = "Ng­¬i cã phÇn th­ëng ¸p Tiªu ch­a nhËn, nhËn xong råi quay l¹i ®©y.",
	MSG_BAG_FULL = "Hµnh trang ®· ®Çy, kh«ng thÓ nhËn ®­îc.",
	MSG_HIGH_TASK_ACCEPTED = "Ng­¬i ®· nhËn 1 nhiÖm vô ¸p Tiªu cao cÊp, h·y thµnh lËp tæ ®éi ®Ó hé Tiªu",
	MSG_NO_TASK = "Ng­¬i vÉn ch­a nhËn nhiÖm vô vËn Tiªu.",
	MSG_NO_START = " Tiªu Xa vÉn ch­a xuÊt ph¸t. ",
	MSG_CANCEL_ALREADY_START = "Tiªu Xa cña ng­¬i ®· xuÊt ph¸t råi, lµm sao cã thÓ bá gi÷a chõng ®­îc!",
	MSG_CANCEL_HIGH_TASK = "Ng­¬i ®· nhËn nhiÖm vô ¸p Tiªu cao cÊp lµm sao cã thÓ bá ®­îc? Ta xem träng ng­¬i!",
	MSG_START_ALREADY_START = "Kh«ng ph¶i Tiªu Xa cña ng­¬i ®· xuÊt ph¸t tõ l©u råi sao, cßn kh«ng mau ®i b¶o vÖ nÕu kh«ng sÏ bÞ kÎ xÊu c­íp mÊt b©y giê!",
	MSG_START_WRONG_NPC = "Ng­¬i t×m sai chç råi, Tiªu Xa ë ®iÓm xuÊt ph¸t ®îi ng­¬i",
	MSG_NO_MONEY = "Ng©n l­îng cña ®¹i hiÖp kh«ng ®ñ.",
	MSG_NO_BIAOCHE = "Tiªu Xa ®Òu bÞ ng­¬i lµm mÊt hÕt råi, kh«ng thÓ truyÒn tèng.",
	MSG_TRANSFER_CD = format("VÉn ch­a v­ît qu¸ %d gi©y so víi lÇn truyÒn tèng tr­íc, ®îi mét chót.", LongMenBiaoJu.TRANSFER_CD),
	
	MSG_FINISH_NO_TASK = "Ng­¬i vÉn ch­a nhËn nhiÖm vô ¸p Tiªu, h·y ®Õn Long M«n TrÊn t×m «ng chñ Yªm M«n ®i.",
	MSG_FINISH_NOT_START = "Tiªu Xa cña ng­¬i vÉn ch­a xuÊt ph¸t, mau ®i ®Õn ®iÓm xuÊt ph¸t t×m Tiªu S­ ®Ó b¾t ®Çu ®i.",
	MSG_FINISH_WRONG_NPC = "§¹i hiÖp ®i sai ®­êng råi, mau chãng hé tèng Tiªu Xa ®Õn ®Þa ®iÓm chÝnh x¸c.",
	MSG_TASK_STATE_BROKEN = "Tiªu Xa cña ng­¬i ®· bÞ ph¸ ho¹i, nhiÖm vô kÕt thóc.",
	MSG_TASK_TIME_REMAIN = "§Õm ng­îc thêi gian %d phót %d gi©y",
	MSG_TASK_FAILED = "NhiÖm vô thÊt b¹i",
	
	MSG_TASK_COUNT = "Sè lÇn nhiÖm vô ¸p Tiªu h«m nay: %d/%d",
	MSG_REFRESH_COUNT_FREE = "Sè lÇn lµm míi nhiÖm vô miÔn phÝ h«m nay: %d/%d",
	MSG_ROUTE_INFO = "Ng­¬i ®· nhËn nhiÖm vô ¸p Tiªu %d sao, %s - %s.",
	MSG_REFRESH_COMFIRM = "Cã ph¶i lµm míi nhiÖm vô?",
	
	MSG_CAN_NOT_PICK = "§¼ng cÊp cña ng­¬i vÉn ch­a ®Õn cÊp 120 vµ ch­a trïng sinh, kh«ng thÓ nhÆt Tiªu vËt rít ra",
	MSG_CAN_NOT_PICK2 = "§¹i hiÖp vÉn ch­a gia nhËp m«n ph¸i, kh«ng thÓ nhËn Tiªu vËt rít ra.",
	MSG_CAN_NOT_PICK_NOW = "HiÖn t¹i ng­¬i kh«ng thÓ nhËn Tiªu vËt nµy.",
	MSG_START_PICK = "B¾t ®Çu nhËn Tiªu vËt",
	MSG_PICK_BROKEN = "Qu¸ tr×nh nhËn Tiªu vËt bÞ ®øt ®o¹n råi.",
	MSG_PICK_FAILED = "NhËn Tiªu vËt thÊt b¹i.",
	MSG_PICK_SUCCESS = "NhËn Tiªu vËt thµnh c«ng.",
	
	MSG_LACK_ITEM_HBL = "Hé Tiªu LÖnh cña ng­¬i kh«ng ®ñ %d c¸i.",
	MSG_ITEM_CD =  "Ng­¬i võa sö dông ®¹o cô nµy, sau %d phót %d gi©y n÷a sö dông l¹i",
	MSG_BIAOCHE_NOT_NEAR = "Tiªu Xa kh«ng n»m trong ph¹m vi cã hiÖu qu¶, h·y l¹i gÇn Tiªu Xa.",
	
	MSG_BIAOCHE_FARAWAY = "§õng c¸ch Tiªu Xa xa qu¸.",
	MSG_EXTRA_AWARD = "Mçi ngµy thµnh c«ng hoµn thµnh 3 lÇn VËn Tiªu sÏ nhËn ®­îc thªm mét LÔ Bao Tiªu Côc.",
	MSG_ALREADY_ACCEPT_TONG_TASK = "Sau khi nhËn nhiÖm vô ¸p Tiªu Bang Héi, kh«ng thÓ nhËn nhiÖm vô ¸p tiªu c¸ nh©n.",
}

