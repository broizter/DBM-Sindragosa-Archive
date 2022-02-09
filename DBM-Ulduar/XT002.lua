local mod	= DBM:NewMod("XT002", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4154 $"):sub(12, -3))
mod:SetCreatureID(33293)
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 62776",
	"SPELL_AURA_APPLIED 62775 63018 65121 63024 64234 63849 64193 65737",
	"SPELL_AURA_REMOVED 63018 65121 63024 64234 63849",
	"SPELL_DAMAGE 64208 64206",
	"SPELL_MISSED 64208 64206"
)

local warnLightBomb					= mod:NewTargetAnnounce(65121, 3)
local warnGravityBomb				= mod:NewTargetAnnounce(64234, 3)

local specWarnLightBomb				= mod:NewSpecialWarningMoveAway(65121, nil, nil, nil, 1, 2)
local yellLightBomb					= mod:NewYell(65121)
local specWarnGravityBomb			= mod:NewSpecialWarningMoveAway(64234, nil, nil, nil, 1, 2)
local yellGravityBomb				= mod:NewYell(64234)
local specWarnConsumption			= mod:NewSpecialWarningMove(64206, nil, nil, nil, 1, 2)--Hard mode void zone dropped by Gravity Bomb

local enrageTimer					= mod:NewBerserkTimer(600)
local timerTympanicTantrumCast		= mod:NewCastTimer(62776)
local timerTympanicTantrum			= mod:NewBuffActiveTimer(12, 62776, nil, nil, nil, 5, nil, DBM_CORE_L.HEALER_ICON)
local timerTympanicTantrumCD		= mod:NewCDTimer(60, 62776, nil, nil, nil, 2, nil, DBM_CORE_L.HEALER_ICON, nil, 3)
local timerHeart					= mod:NewCastTimer(30, 63849, nil, nil, nil, 6, nil, DBM_CORE_L.DAMAGE_ICON)
local timerLightBomb				= mod:NewTargetTimer(9, 65121, nil, nil, nil, 3)
local timerGravityBomb				= mod:NewTargetTimer(9, 64234, nil, nil, nil, 3)
local timerAchieve					= mod:NewAchievementTimer(205, 2937)

mod:AddSetIconOption("SetIconOnLightBombTarget", 65121, true, true, {1})
mod:AddSetIconOption("SetIconOnGravityBombTarget", 64234, true, true, {2})
mod:AddRangeFrameOption(12, nil, true)

function mod:OnCombatStart(delay)
	enrageTimer:Start(-delay)
	timerAchieve:Start()
	if self:IsDifficulty("normal10") then
		timerTympanicTantrumCD:Start(35-delay)
	else
		timerTympanicTantrumCD:Start(60-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 62776 then					-- Tympanic Tantrum (aoe damage + daze)
		timerTympanicTantrum:Start()
		timerTympanicTantrumCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args:IsSpellID(63018, 65121) then 	-- Light Bomb
		if args:IsPlayer() then
			specWarnLightBomb:Show()
			specWarnLightBomb:Play("runout")
			yellLightBomb:Yell()
		end
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 1)
		end
		warnLightBomb:Show(args.destName)
		timerLightBomb:Start(args.destName)
	elseif args:IsSpellID(63024, 64234) then		-- Gravity Bomb
		if args:IsPlayer() then
			specWarnGravityBomb:Show()
			specWarnGravityBomb:Play("runout")
			yellGravityBomb:Yell()
		end
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 2)
		end
		warnGravityBomb:Show(args.destName)
		timerGravityBomb:Start(args.destName)
	elseif args:IsSpellID(64193, 65737) then				-- 1st Tympanic Tantrum on HM mode
		timerHeart:Stop()
		--[[ if self.Options.WarningTympanicTantrumIn10Sec then
			specWarnTTIn10Sec:Schedule(54)
		end ]]-- not a valid function?
		timerTympanicTantrumCD:Start(64)
	elseif args:IsSpellID(63849) then
		timerHeart:Start()
		timerTympanicTantrumCD:Stop()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(63018, 65121) then	-- Light Bomb
		if self.Options.SetIconOnLightBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(63024, 64234) then	-- Gravity Bomb
		if self.Options.SetIconOnGravityBombTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 63849 then
		timerHeart:Stop()
	end
end

function mod:SPELL_DAMAGE(_, _, _, destGUID, _, _, spellId)
	if (spellId == 64208 or spellId == 64206) and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnConsumption:Show()
		specWarnConsumption:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE