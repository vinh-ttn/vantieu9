Include("\\script\\event\\longmenbiaoju\\head.lua")

LongMenBiaoJu.BoxAwardData = {
	[1] = {
		tbRobber		= {nFreeBag=1, nCount=1, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=1, nCount=1},
		tbHighLevel		= {nFreeBag=1, nCount=1},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=90.0},
			{tbProp={6,1,30228,1,0,0}, nRate=5.0, nBindState=-2},
			{tbProp={6,1,3203,1,0,0}, nRate=5.0, nBindState=-2, nCount = 10},
			
		}
	},
	[2] = {
		tbRobber		= {nFreeBag=1, nCount=1, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=1, nCount=1},
		tbHighLevel		= {nFreeBag=5, nCount=5},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=89.0},
			{tbProp={6,1,30229,1,0,0}, nRate=5.0, nBindState=-2},
			{tbProp={6,1,3203,1,0,0}, nRate=5.0, nBindState=-2, nCount = 5},
			{tbProp={6,1,30289,9,0,0}, nRate=1.0, nBindState=-2},
		}
	},
	[3] = {
		tbRobber		= {nFreeBag=1, nCount=1, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=1, nCount=1},
		tbHighLevel		= {nFreeBag=5, nCount=5},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=40.0},
			{tbProp={6,0,2389,1,0,0}, nRate=34.0},
			{tbProp={6,1,30229,1,0,0}, nRate=15.0, nBindState=-2},
			{tbProp={6,1,3203,1,0,0}, nRate=10.0, nBindState=-2, nCount = 10},
			{tbProp={6,1,30289,9,0,0}, nRate=1.0, nBindState=-2},
		}
	},
	[4] = {
		tbRobber		= {nFreeBag=2, nCount=2, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=2, nCount=2},
		tbHighLevel		= {nFreeBag=7, nCount=7},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=40.0},
			{tbProp={6,1,3455,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3456,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3457,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3458,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,30229,1,0,0}, nRate=5.0, nBindState=-2, nCount=2},
			{tbProp={6,1,3203,1,0,0}, nRate=5.0, nBindState=-2, nCount=10},
			{tbProp={6,0,2389,1,0,0}, nRate=8.0},
			{
				nRate = 2.0,
				[1] = {tbProp={6,1,30289,9,0,0}, nRate=80.0, nBindState=-2},
				[2] = {tbProp={6,1,30289,12,0,0}, nRate=20.0, nBindState=-2},
			},
		}
	},
	[5] = {
		tbRobber		= {nFreeBag=3, nCount=3, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=3, nCount=3},
		tbHighLevel		= {nFreeBag=9, nCount=9},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=26.0},
			{tbProp={6,1,3455,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3456,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3457,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,30229,1,0,0}, nRate=14.0, nBindState=-2, nCount=2},
			{tbProp={6,1,3203,1,0,0}, nRate=14.0, nBindState=-2, nCount=10},
			{tbProp={6,1,907,1,0,0}, nRate=5.0, nBindState=-2, nExpiredTime=7*24*60},
			{
				nRate = 11,
				[1] = {tbProp={6,1,30289,9,0,0}, nRate=60.0, nBindState=-2},
				[2] = {tbProp={6,1,30289,11,0,0}, nRate=30.0, nBindState=-2},
				[3] = {tbProp={6,1,30289,12,0,0}, nRate=10.0, nBindState=-2},
			}
		}
	},
	[6] = {
		tbRobber		= {nFreeBag=3, nCount=3, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=3, nCount=3},
		tbHighLevel		= {nFreeBag=10, nCount=10},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=18.0},
			{tbProp={6,1,3455,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3456,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3457,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,30557,1,0,0}, nRate=8.0},
			{tbProp={6,1,30229,1,0,0}, nRate=13.0, nBindState=-2, nCount=3},
			{tbProp={6,1,3203,1,0,0}, nRate=15.0, nBindState=-2, nCount=15},
			{tbProp={6,1,907,1,0,0}, nRate=1.0, nBindState=-2, nExpiredTime=7*24*60},
			{
				nRate = 15,
				[1] = {tbProp={6,1,30289,9,0,0}, nRate=60.0, nBindState=-2},
				[2] = {tbProp={6,1,30289,11,0,0}, nRate=30.0, nBindState=-2},
				[3] = {tbProp={6,1,30289,12,0,0}, nRate=10.0, nBindState=-2},
			}
		}
	},
	[7] = {
		tbRobber		= {nFreeBag=3, nCount=3, nPickUpMax=1,},
		tbLowLevel		= {nFreeBag=3, nCount=3},
		tbHighLevel		= {nFreeBag=10, nCount=10},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=20.0},
			{tbProp={6,1,3455,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3456,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3457,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,30557,1,0,0}, nRate=13.0},
			{tbProp={6,1,30301,1,0,0}, nRate=1.0},
			{tbProp={6,1,3203,1,0,0}, nRate=15.0, nBindState=-2, nCount=15},
			{tbProp={6,1,907,1,0,0}, nRate=1.0, nExpiredTime=7*24*60},
			{
				nRate = 10,
				[1] = {tbProp={6,1,30289,9,0,0}, nRate=60.0, nBindState=-2},
				[2] = {tbProp={6,1,30289,11,0,0}, nRate=30.0, nBindState=-2},
				[3] = {tbProp={6,1,30289,12,0,0}, nRate=10.0, nBindState=-2},
			},
			{
				nRate = 10,
				[1] = {tbProp={6,1,4535,1,0,0}, nRate=10.0, nBindState=-2},
				[2] = {tbProp={6,1,4536,1,0,0}, nRate=90.0, nBindState=-2},
			},
		}
	},
	[8] = {
		tbRobber		= {nFreeBag=6, nCount=6, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=6, nCount=6},
		tbHighLevel		= {nFreeBag=20, nCount=20},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=20.0},
			{tbProp={6,1,3455,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3456,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3457,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,30557,1,0,0}, nRate=12.0},
			{tbProp={6,1,30301,1,0,0}, nRate=1.0},
			{tbProp={6,1,3203,1,0,0}, nRate=13.0, nBindState=-2, nCount=15},
			{tbProp={6,1,907,1,0,0}, nRate=4.0, nExpiredTime=7*24*60},
			{
				nRate = 10,
				[1] = {tbProp={6,1,4535,1,0,0}, nRate=10.0, nBindState=-2},
				[2] = {tbProp={6,1,4536,1,0,0}, nRate=90.0, nBindState=-2},
				
			},
			{
				nRate = 10,
				[1] = {tbProp={6,1,30289,9,0,0}, nRate=60.0, nBindState=-2},
				[2] = {tbProp={6,1,30289,11,0,0}, nRate=30.0, nBindState=-2},
				[3] = {tbProp={6,1,30289,12,0,0}, nRate=10.0, nBindState=-2},
			},
		}
	},
	[9] = {
		tbRobber		= {nFreeBag=9, nCount=9, nPickUpMax=1},
		tbLowLevel		= {nFreeBag=9, nCount=9},
		tbHighLevel		= {nFreeBag=30, nCount=30},
		tbAward = {
			{tbProp={6,0,20,1,0,0}, nRate=13},
			{tbProp={6,1,3455,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3456,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,3457,1,0,0}, nRate=10.0, nBindState=-2},
			{tbProp={6,1,30557,1,0,0}, nRate=10.0},
			{tbProp={6,1,30301,1,0,0}, nRate=1.4},
			{tbProp={6,1,3203,1,0,0}, nRate=20.0, nBindState=-2, nCount=15},
			{tbProp={6,1,2126,1,0,0}, nRate=0.1, nExpiredTime=30*24*60},
			{tbProp={0, 3477}, nQuality = 1, nRate=0.1, nBindState=-2, nExpiredTime=7*24*60},
			{
				nRate = 10,
				[1] = {tbProp={6,1,30289,9,0,0}, nRate=60.0, nBindState=-2},
				[2] = {tbProp={6,1,30289,11,0,0}, nRate=30.0, nBindState=-2},
				[3] = {tbProp={6,1,30289,12,0,0}, nRate=10.0, nBindState=-2},
			},
			{
				nRate = 10,
				[1] = {tbProp={6,1,4535,1,0,0}, nRate=10.0, nBindState=-2},
				[2] = {tbProp={6,1,4536,1,0,0}, nRate=90.0, nBindState=-2},
				
			},
			{
				nRate = 5.4,
				[1] = {tbProp={6,1,2271,1,0,0}, nRate=30.0, nExpiredTime=7*24*60},
				[2] = {tbProp={6,1,30438,1,0,0}, nRate=10.0, nExpiredTime=7*24*60},
				[3] = {tbProp={6,1,2269,1,0,0}, nRate=60.0, nExpiredTime=7*24*60},
			},
		}
	},
}
