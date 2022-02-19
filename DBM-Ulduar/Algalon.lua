local mod	= DBM:NewMod("Algalon", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal"

--[[
--
--  Thanks to  Apathy @ Vek'nilash  who provided us with Informations and Combatlog about Algalon
--
--]]


mod:SetRevision(("$Revision: 3804 $"):sub(12, -3))
mod:SetCreatureID(32871)

mod:RegisterCombat("yell", L.YellPull)
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(20)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_HEALTH",
	"SPELL_AURA_APPLIED 64412",
	"SPELL_AURA_APPLIED_DOSE 64412",
	"SPELL_CAST_SUCCESS 65108 64122 64598 62301",
	"SPELL_CAST_START 64584 64443"
)

local warnPhase2				= mod:NewPhaseAnnounce(2, 2)
local warnPhase2Soon			= mod:NewPrePhaseAnnounce(2, 2)
local announcePreBigBang		= mod:NewPreWarnAnnounce(64584, 10, 3)
local announceBlackHole			= mod:NewSpellAnnounce(65108, 2)
local announcePhasePunch		= mod:NewStackAnnounce(65108, 4, nil, "Tank|Healer")

local specwarnStarLow			= mod:NewSpecialWarning("warnStarLow", "Tank|Healer", nil, nil, 1, 2)
local specWarnPhasePunch		= mod:NewSpecialWarningStack(64412, nil, 4, nil, nil, 1, 6)
local specWarnBigBang			= mod:NewSpecialWarningSpell(64584, nil, nil, nil, 3, 2)
local specWarnCosmicSmash		= mod:NewSpecialWarningDodge(64596, nil, nil, nil, 2, 2)

local timerCombatStart			= mod:NewCombatTimer(8)
local enrageTimer				= mod:NewBerserkTimer(300)
local timerNextBigBang			= mod:NewNextTimer(75, 64584, nil, nil, nil, 2)
local timerBigBangCast			= mod:NewCastTimer(8, 64584, nil, nil, nil, 2, nil, DBM_CORE_L.DEADLY_ICON)
local timerNextCollapsingStar	= mod:NewTimer(60, "NextCollapsingStar", "Interface\\Icons\\INV_Enchant_EssenceCosmicGreater", nil, nil, 2, DBM_CORE_L.HEALER_ICON)
local timerCDCosmicSmash		= mod:NewCDTimer(25.5, 64596, nil, nil, nil, 3)
local timerCastCosmicSmash		= mod:NewCastTimer(4.5, 64596)
local timerPhasePunch			= mod:NewTargetTimer(45, 64412, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)
local timerNextPhasePunch		= mod:NewNextTimer(15.5, 64412, nil, "Tank", 2, 5, nil, DBM_CORE_L.TANK_ICON)

local warned_preP2 = false
local warned_star = false

function mod:OnCombatStart(delay)
end

function mod:startTimers()
	if mod:IsDifficulty("normal10") then
		enrageTimer:Start(360)
		timerNextBigBang:Start(90)
		announcePreBigBang:Schedule(80)
	else
		enrageTimer:Start()
		timerNextBigBang:Start(65)
		announcePreBigBang:Schedule(55)
	end
	timerCDCosmicSmash:Start(25)
	timerNextCollapsingStar:Start(16.5)
	timerNextPhasePunch:Start()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(64584, 64443) then 	-- Big Bang
		timerBigBangCast:Start()
		if mod:IsDifficulty("normal10") then
			timerNextBigBang:Start(90)
			announcePreBigBang:Schedule(80)
		else
			timerNextBigBang:Start()
			announcePreBigBang:Schedule(65)
		end
		specWarnBigBang:Show()
		if self:IsTank() then
			specWarnBigBang:Play("defensive")
		else
			specWarnBigBang:Play("findshelter")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(65108, 64122) then 	-- Black Hole Explosion
		announceBlackHole:Show()
		warned_star = false
	elseif args:IsSpellID(64598, 62301) then	-- Cosmic Smash
		timerCastCosmicSmash:Start()
		timerCDCosmicSmash:Start()
		specWarnCosmicSmash:Show()
		specWarnCosmicSmash:Play("watchstep")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(64412) then
		timerNextPhasePunch:Start()
		local amount = args.amount or 1
		if args:IsPlayer() and amount >= 4 then
			specWarnPhasePunch:Show(args.amount)
			specWarnPhasePunch:Play("stackhigh")
		end
		timerPhasePunch:Start(args.destName)
		announcePhasePunch:Show(args.destName, amount)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED


function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.Emote_CollapsingStar or msg:find(L.Emote_CollapsingStar) then
		timerNextCollapsingStar:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Phase2 or msg:find(L.Phase2) then
		timerNextCollapsingStar:Cancel()
		warnPhase2:Show()
	elseif (msg == L.YellPull or msg:find(L.YellPull)) then
		warned_preP2 = false
		warned_star = false
		timerCombatStart:Start()
		self:ScheduleMethod(8, "startTimers")
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preP2 and self:GetUnitCreatureId(uId) == 32871 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 then
		warned_preP2 = true
		warnPhase2Soon:Show()
	elseif not warned_star and self:GetUnitCreatureId(uId) == 32955 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 then
		warned_star = true
		specwarnStarLow:Show()
		specwarnStarLow:Play("aesoon")
	end
end