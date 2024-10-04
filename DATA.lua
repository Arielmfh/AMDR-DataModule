local DataStore = game:GetService("DataStoreService")
local bs = game:GetService("BadgeService")
local standdata = DataStore:GetDataStore("StandDS2")
local moneydata = DataStore:GetDataStore("CashDS2")
local leveldata = DataStore:GetDataStore("LevelDS2Reset2")
local expdata = DataStore:GetDataStore("ExpDS2Reset2")

local skillonedata = DataStore:GetDataStore("SkillOneDS2Reset1")
local skilltwodata = DataStore:GetDataStore("SkillTwoDS2Reset1")
local skillthreedata = DataStore:GetDataStore("SkillThreeDS2Reset1")
local skillfourdata = DataStore:GetDataStore("SkillFourDS2Reset1")
local skillfivedata = DataStore:GetDataStore("SkillFiveDS2Reset1")
local skillsixdata = DataStore:GetDataStore("SkillSixDS2Reset1")
local skillsevendata = DataStore:GetDataStore("SkillSevenDS2Reset1")
local skilleightdata = DataStore:GetDataStore("SkillEightDS2Reset1")
local skillninedata = DataStore:GetDataStore("SkillNineDS2Reset1")

--Trait
local TraitGdata = DataStore:GetDataStore("TraitGodly")
local TraitSdata = DataStore:GetDataStore("TraitStrong")
local TraitNdata = DataStore:GetDataStore("TraitNormal")
local TraitWdata = DataStore:GetDataStore("TraitWeak")

local pointsdata = DataStore:GetDataStore("SkillPointsDS2Reset2")
local lostpointsdata = DataStore:GetDataStore("LostSkillPointsDS2Reset2")

local thugquestdata = DataStore:GetDataStore("ThugQuestDS2Reset1")
local thugquestnumberdata = DataStore:GetDataStore("ThugQuest#DS2Reset1")

local thugrevengequestdata = DataStore:GetDataStore("ThugRevengeQuestDS2Reset1")
local thugrevengequestnumberdata = DataStore:GetDataStore("ThugRevengeQuest#DS2Reset1")

game.Players.PlayerAdded:Connect(function(player)
	local playerKey = "Player_" .. player.UserId
	
	spawn(function()
		if player.UserId == 410894430 and player.Name == "c_sxn" then --bs:UserHasBadgeAsync(player.UserId, 2124881839) then
			local item = game.ServerStorage.Banknote:Clone()
			item.Parent = player.Backpack
			local item = game.ServerStorage["Gold Bar"]:Clone()
			item.Parent = player.Backpack
		--	local item = game.ServerStorage.Omni:Clone()
		--	item.Parent = player.Backpack
		end
	end)
	
	local itemsave = Instance.new("Folder", player)
	itemsave.Name = "ItemSave"
	
	--Leaderstats
	local data = Instance.new("Folder", player)
	data.Name = "Data"
	
	--Stand	
	local stand = Instance.new("IntValue", data)
	stand.Name = "Stand"
	
	local level = Instance.new("IntValue", data)
	level.Name = "Level"

	local Exp = Instance.new("IntValue", data)
	Exp.Name = "Experience"
	
	--Trait	
	local Weak = Instance.new("BoolValue", data)
	Weak.Name = "Weak"

	local Normal = Instance.new("BoolValue", data)
	Normal.Name = "Normal"

	local Strong = Instance.new("BoolValue", data)
	Strong.Name = "Strong"

	local Godly = Instance.new("BoolValue", data)
	Godly.Name = "Godly"
	
	local MaxLevels = 10
	
	--Check their stand
	local myStand
	local myLevel
	local myExp
	
	--Trait
	local mytraitGodly
	local mytraitStrong
	local mytraitNormal
	local mytraitWeak
	
	local success, err = pcall(function()
		myStand = standdata:GetAsync(playerKey)
		myLevel = leveldata:GetAsync(playerKey)
		myExp = expdata:GetAsync(playerKey)
	end)
	
	if success then
		stand.Value = myStand
		level.Value = myLevel
		Exp.Value = myExp
	else
		stand.Value = 1
		level.Value = 1
		Exp.Value = 0
	end
	stand.Value = standdata:GetAsync(player.UserId) or 1
	level.Value = leveldata:GetAsync(player.UserId) or 1
	Exp.Value = expdata:GetAsync(player.UserId) or 0
	--Save their stand
	standdata:SetAsync(player.UserId, stand.Value)
	leveldata:SetAsync(player.UserId, level.Value)
	expdata:SetAsync(player.UserId, Exp.Value)
	stand.Changed:connect(function()
		print("Saving data...")
		standdata:SetAsync(player.UserId, stand.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)
	level.Changed:connect(function()
		if level.Value > MaxLevels then
			player:Kick("Exploited level huh?")
			return
		end
		print("Saving data...")
		leveldata:SetAsync(player.UserId, level.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)
	Exp.Changed:connect(function()
		print("Saving data...")
		expdata:SetAsync(player.UserId, Exp.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)
	if level.Value > MaxLevels then
		player:Kick("Exploited level huh?")
	end
	
	--Trait
	local success1, err = pcall(function()
		mytraitGodly = TraitGdata:GetAsync(playerKey)
	end)

	local success2, err = pcall(function()
		mytraitStrong = TraitSdata:GetAsync(playerKey)
	end)

	local success3, err = pcall(function()
		mytraitNormal = TraitNdata:GetAsync(playerKey)
	end)

	local success4, err = pcall(function()
		mytraitWeak = TraitWdata:GetAsync(playerKey)
	end)
	
	--Trait
	if success1 then
		Weak.Value = mytraitWeak
	else
		Weak.Value = false
	end
	
	if success2 then
		Normal.Value = mytraitNormal
	else
		Normal.Value = true
	end
	
	if success3 then
		Strong.Value = mytraitStrong
	else
		Strong.Value = false
	end
	
	if success4 then
		Godly.Value = TraitGdata
	else
		Godly.Value = false
	end
	
	--Money
	local money = Instance.new("IntValue")
	money.Parent = data
	money.Name = "Money"
	--Check their money
	local myMoney
	
	local success, err = pcall(function()
		myMoney = moneydata:GetAsync(playerKey)
	end)
	
	if success then
		money.Value = myMoney
	else
		money.Value = 250
	end
	money.Value = moneydata:GetAsync(player.UserId) or 250
	--Save their money
	moneydata:SetAsync(player.UserId, money.Value)
	money.Changed:connect(function()
		print("Saving data...")
		moneydata:SetAsync(player.UserId, money.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)
	
	--Skills
	local skillsdata = Instance.new("Folder", player)
	skillsdata.Name = "SkillsData"
	
	--Values	
	local skillone = Instance.new("BoolValue", skillsdata)
	skillone.Name = "SkillOne"
	
	local skilltwo = Instance.new("BoolValue", skillsdata)
	skilltwo.Name = "SkillTwo"
	
	local skillthree = Instance.new("BoolValue", skillsdata)
	skillthree.Name = "SkillThree"
	
	local skillfour = Instance.new("BoolValue", skillsdata)
	skillfour.Name = "SkillFour"

	local skillfive = Instance.new("BoolValue", skillsdata)
	skillfive.Name = "SkillFive"

	local skillsix = Instance.new("BoolValue", skillsdata)
	skillsix.Name = "SkillSix"
	
	local skillseven = Instance.new("BoolValue", skillsdata)
	skillseven.Name = "SkillSeven"

	local skilleight = Instance.new("BoolValue", skillsdata)
	skilleight.Name = "SkillEight"

	local skillnine = Instance.new("BoolValue", skillsdata)
	skillnine.Name = "SkillNine"
	
	local points = Instance.new("IntValue", skillsdata)
	points.Name = "SkillPoints"
	
	local wasted = Instance.new("IntValue", skillsdata)
	wasted.Name = "PointsWasted"
	
	Exp.Changed:connect(function()
		local extraExp = level.Value/3
		local ExpCap = level.Value*65 + extraExp
		if Exp.Value >= ExpCap then
			if level.Value < MaxLevels then
				level.Value = level.Value + 1
				points.Value += 1
				Exp.Value -= ExpCap
			else
				Exp.Value = ExpCap
			end
		end	
	end)
	
	--Trait
	Godly.Value = TraitGdata:GetAsync(player.UserId) or false
	--Save their trait
	TraitGdata:SetAsync(player.UserId, Godly.Value)
	Godly.Changed:connect(function()
		print("Saving data...")
		TraitGdata:SetAsync(player.UserId, Godly.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)

	Strong.Value = TraitSdata:GetAsync(player.UserId) or false
	--Save their trait
	TraitSdata:SetAsync(player.UserId, Strong.Value)
	Strong.Changed:connect(function()
		print("Saving data...")
		TraitSdata:SetAsync(player.UserId, Strong.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)

	Normal.Value = TraitNdata:GetAsync(player.UserId) or false
	--Save their trait
	TraitNdata:SetAsync(player.UserId, Normal.Value)
	Normal.Changed:connect(function()
		print("Saving data...")
		TraitNdata:SetAsync(player.UserId, Normal.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)

	Weak.Value = TraitWdata:GetAsync(player.UserId) or false
	--Save their trait
	TraitWdata:SetAsync(player.UserId, Weak.Value)
	Weak.Changed:connect(function()
		print("Saving data...")
		TraitWdata:SetAsync(player.UserId, Weak.Value)	
		print(player.UserId.."'s data has been saved!")	
	end)
	
	local firstSkill
	local success, err = pcall(function()
		firstSkill = skillonedata:GetAsync(playerKey)
	end)
	if success then
		skillone.Value = firstSkill
	else
		skillone.Value = false
	end
	skillone.Value = skillonedata:GetAsync(player.UserId) or false
	skillonedata:SetAsync(player.UserId, skillone.Value)
	skillone.Changed:connect(function()
		skillonedata:SetAsync(player.UserId, skillone.Value)	
	end)
	
	local secondSkill
	local success, err = pcall(function()
		secondSkill = skilltwodata:GetAsync(playerKey)
	end)
	if success then
		skilltwo.Value = secondSkill
	else
		skilltwo.Value = false
	end
	skilltwo.Value = skilltwodata:GetAsync(player.UserId) or false
	skilltwodata:SetAsync(player.UserId, skilltwo.Value)
	skilltwo.Changed:connect(function()
		skilltwodata:SetAsync(player.UserId, skilltwo.Value)	
	end)
	
	local thirdSkill
	local success, err = pcall(function()
		thirdSkill = skillthreedata:GetAsync(playerKey)
	end)
	if success then
		skillthree.Value = thirdSkill
	else
		skillthree.Value = false
	end
	skillthree.Value = skillthreedata:GetAsync(player.UserId) or false
	skillthreedata:SetAsync(player.UserId, skillthree.Value)
	skillthree.Changed:connect(function()
		skillthreedata:SetAsync(player.UserId, skillthree.Value)	
	end)
	local fourthSkill
	local success, err = pcall(function()
		fourthSkill = skillfourdata:GetAsync(playerKey)
	end)
	if success then
		skillfour.Value = fourthSkill
	else
		skillfour.Value = false
	end
	skillfour.Value = skillfourdata:GetAsync(player.UserId) or false
	skillfourdata:SetAsync(player.UserId, skillfour.Value)
	skillfour.Changed:connect(function()
		skillfourdata:SetAsync(player.UserId, skillfour.Value)	
	end)

	local fifthSkill
	local success, err = pcall(function()
		fifthSkill = skillfivedata:GetAsync(playerKey)
	end)
	if success then
		skillfive.Value = fifthSkill
	else
		skillfive.Value = false
	end
	skillfive.Value = skillfivedata:GetAsync(player.UserId) or false
	skillfivedata:SetAsync(player.UserId, skillfive.Value)
	skillfive.Changed:connect(function()
		skillfivedata:SetAsync(player.UserId, skillfive.Value)	
	end)

	local sixthSkill
	local success, err = pcall(function()
		sixthSkill = skillsixdata:GetAsync(playerKey)
	end)
	if success then
		skillsix.Value = sixthSkill
	else
		skillsix.Value = false
	end
	skillsix.Value = skillsixdata:GetAsync(player.UserId) or false
	skillsixdata:SetAsync(player.UserId, skillsix.Value)
	skillsix.Changed:connect(function()
		skillsixdata:SetAsync(player.UserId, skillsix.Value)	
	end)
	local seventhSkill
	local success, err = pcall(function()
		seventhSkill = skillsevendata:GetAsync(playerKey)
	end)
	if success then
		skillseven.Value = seventhSkill
	else
		skillseven.Value = false
	end
	skillseven.Value = skillsevendata:GetAsync(player.UserId) or false
	skillsevendata:SetAsync(player.UserId, skillseven.Value)
	skillseven.Changed:connect(function()
		skillsevendata:SetAsync(player.UserId, skillseven.Value)	
	end)

	local eigthSkill
	local success, err = pcall(function()
		eigthSkill = skilleightdata:GetAsync(playerKey)
	end)
	if success then
		skilleight.Value = eigthSkill
	else
		skilleight.Value = false
	end
	skilleight.Value = skilleightdata:GetAsync(player.UserId) or false
	skilleightdata:SetAsync(player.UserId, skilleight.Value)
	skilleight.Changed:connect(function()
		skilleightdata:SetAsync(player.UserId, skilleight.Value)	
	end)

	local ninthSkill
	local success, err = pcall(function()
		ninthSkill = skillninedata:GetAsync(playerKey)
	end)
	if success then
		skillnine.Value = ninthSkill
	else
		skillnine.Value = false
	end
	skillnine.Value = skillninedata:GetAsync(player.UserId) or false
	skillninedata:SetAsync(player.UserId, skillnine.Value)
	skillnine.Changed:connect(function()
		skillninedata:SetAsync(player.UserId, skillnine.Value)	
	end)
	------------------------------------------------------------------
	local skillPoints
	local success, err = pcall(function()
		skillPoints = pointsdata:GetAsync(playerKey)
	end)
	if success then
		points.Value = skillPoints
	else
		points.Value = 0
	end
	points.Value = pointsdata:GetAsync(player.UserId) or 0
	pointsdata:SetAsync(player.UserId, points.Value)
	points.Changed:connect(function()
		pointsdata:SetAsync(player.UserId, points.Value)	
	end)
	
	local skillPointsLost
	local success, err = pcall(function()
		skillPointsLost = lostpointsdata:GetAsync(playerKey)
	end)
	if success then
		wasted.Value = skillPointsLost
	else
		wasted.Value = 0
	end
	wasted.Value = lostpointsdata:GetAsync(player.UserId) or 0
	lostpointsdata:SetAsync(player.UserId, wasted.Value)
	wasted.Changed:connect(function()
		lostpointsdata:SetAsync(player.UserId, wasted.Value)	
	end)
	
	--Quests
	local questdata = Instance.new("Folder", player)
	questdata.Name = "QuestData"
	
	--Values	
	local doppioquest = Instance.new("BoolValue", questdata)
	doppioquest.Name = "DoppioQuest"
	
	local thugskilled = Instance.new("NumberValue", questdata)
	thugskilled.Name = "ThugsKilled"
	
	local thugquest = Instance.new("BoolValue", questdata)
	thugquest.Name = "ThugQuest"
	
	local playerskilled = Instance.new("NumberValue", questdata)
	playerskilled.Name = "PlayersKilled"
	
	local doppioQuest
	local success, err = pcall(function()
		doppioQuest = thugquestdata:GetAsync(playerKey)
	end)
	if success then
		doppioquest.Value = doppioQuest
	else
		doppioquest.Value = false
	end
	doppioquest.Value = thugquestdata:GetAsync(player.UserId) or false
	thugquestdata:SetAsync(player.UserId, doppioquest.Value)
	doppioquest.Changed:connect(function()
		thugquestdata:SetAsync(player.UserId, doppioquest.Value)	
	end)
	
	
	local thugsKilled
	local success, err = pcall(function()
		thugsKilled = thugquestnumberdata:GetAsync(playerKey)
	end)
	if success then
		thugskilled.Value = thugsKilled
	else
		thugskilled.Value = 0
	end
	thugskilled.Value = thugquestnumberdata:GetAsync(player.UserId) or false
	thugquestnumberdata:SetAsync(player.UserId, thugskilled.Value)
	thugskilled.Changed:connect(function()
		thugquestnumberdata:SetAsync(player.UserId, thugskilled.Value)	
	end)
	local thugQuest
	local success, err = pcall(function()
		thugQuest = thugrevengequestdata:GetAsync(playerKey)
	end)
	if success then
		thugquest.Value = thugQuest
	else
		thugquest.Value = false
	end
	thugquest.Value = thugrevengequestdata:GetAsync(player.UserId) or false
	thugrevengequestdata:SetAsync(player.UserId, thugquest.Value)
	thugquest.Changed:connect(function()
		thugrevengequestdata:SetAsync(player.UserId, thugquest.Value)	
	end)

	local playersKilled
	local success, err = pcall(function()
		playersKilled = thugrevengequestnumberdata:GetAsync(playerKey)
	end)
	if success then
		playerskilled.Value = playersKilled
	else
		playerskilled.Value = 0
	end
	playerskilled.Value = thugrevengequestnumberdata:GetAsync(player.UserId) or false
	thugrevengequestnumberdata:SetAsync(player.UserId, playerskilled.Value)
	playerskilled.Changed:connect(function()
		thugrevengequestnumberdata:SetAsync(player.UserId, playerskilled.Value)	
	end)
end)