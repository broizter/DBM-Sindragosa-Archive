local mod	= DBM:NewMod("Sapphiron", "DBM-Naxx", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2248 $"):sub(12, -3))
mod:SetCreatureID(15989)

mod:RegisterCombat("combat")
mod:SetModelScale(0.1)
mod:EnableModel()

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_EMOTE",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnDrainLifeNow		= mod:NewSpellAnnounce(28542, 2)
local warnDrainLifeSoon		= mod:NewSoonAnnounce(28542, 1)
local warnAirPhaseSoon		= mod:NewAnnounce("WarningAirPhaseSoon", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnAirPhaseNow		= mod:NewAnnounce("WarningAirPhaseNow", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnLanded			= mod:NewAnnounce("WarningLanded", 4, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")

local warnDeepBreath		= mod:NewSpecialWarning("WarningDeepBreath")
local specwarnlowhp			= mod:NewSpecialWarning("SpecWarnSapphLow")
local warnFrostrain			= mod:NewSpecialWarningMove(55699)

mod:AddBoolOption("WarningIceblock", true, "yell")

local timerDrainLife		= mod:NewCDTimer(24, 28542)
local timerAirPhase			= mod:NewTimer(53.5, "TimerAir", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerLanding			= mod:NewTimer(28.5, "TimerLanding", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerIceBlast			= mod:NewTimer(8, "TimerIceBlast", 15876)

local timerStomp			= mod:NewCDTimer(10, 45185, nil, "Tank|Healer", nil, 5) -- Custom stomp for Sindragosa realm
local warnStomp				= mod:NewTargetAnnounce(45185, 3, nil, "Tank|Healer")
local specWarnStompTaunt	= mod:NewSpecialWarningTaunt(45185, nil, nil, nil, 1, 2)
local specWarnStompYou		= mod:NewSpecialWarningYou(45185, "Tank")

local noTargetTime = 0
local isFlying = false
local warned_lowhp = false

mod:AddBoolOption("RangeFrame", true)

function mod:OnCombatStart(delay)
	noTargetTime = 0
	isFlying = false
	warned_lowhp = false
	warnAirPhaseSoon:Schedule(35.5 - delay)
	timerAirPhase:Start(45.5 - delay)
	self:Schedule(43 - delay, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(28522) and args:IsPlayer() and self.Options.WarningIceblock then
		SendChatMessage(L.WarningYellIceblock, "YELL")
	elseif (args.spellId == 55699 or args.spellId == 28547) and args.destName == UnitName("player") and self:AntiSpam(1) then
		warnFrostrain:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28542, 55665) then -- Life Drain
		warnDrainLifeNow:Show()
		warnDrainLifeSoon:Schedule(19)
		timerDrainLife:Start()
	elseif args:IsSpellID(45185) then -- Custom Stomp ability
		warnStomp:Show(args.destName)
		if not args:IsPlayer() then
			specWarnStompTaunt:Show(args.destName)
			specWarnStompTaunt:Play("tauntboss")
		else
			specWarnStompYou:Show()
		end
		timerStomp:Start()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.EmoteBreath or msg:find(L.EmoteBreath) then
		self:SendSync("DeepBreath")
	end
end

mod.CHAT_MSG_RAID_BOSS_EMOTE = mod.CHAT_MSG_MONSTER_EMOTE -- used to be a normal emote

function mod:UNIT_HEALTH(uId)
	if not warned_lowhp and self:GetUnitCreatureId(uId) == 15989 and UnitHealth(uId) / UnitHealthMax(uId) < 0.1 then
		warned_lowhp = true
		specwarnlowhp:Show()
		timerAirPhase:Cancel()
	end
end

function mod:OnSync(event)
	if event == "DeepBreath" then
		timerIceBlast:Show()
		timerLanding:Update(14)
		self:ScheduleMethod(14.5, "Landing")
		warnDeepBreath:Show()
	end
end

function mod:Landing()
	warnAirPhaseSoon:Schedule(44)
	warnLanded:Show()
	timerAirPhase:Start()
	timerStomp:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:Schedule(51, DBM.RangeCheck.Show, DBM.RangeCheck, 12)
end

local function resetIsFlying()
	isFlying = false
end

mod:RegisterOnUpdateHandler(function(self, elapsed)
	if not self:IsInCombat() then return end
	local foundBoss, target
	for i = 1, GetNumRaidMembers() do
		local uId = "raid"..i.."target"
		if self:GetUnitCreatureId(uId) == 15989 and UnitAffectingCombat(uId) then
			target = UnitName(uId.."target")
			foundBoss = true
			break
		end
	end
	if foundBoss and not target then
		noTargetTime = noTargetTime + elapsed
	elseif foundBoss and target then
		noTargetTime = 0
	end
	if noTargetTime > 0.5 and not isFlying then
		noTargetTime = 0
		isFlying = true
		self:Schedule(53.5, resetIsFlying)
		timerStomp:Cancel()
		local oldDrainLife = timerDrainLife:GetRemaining()
		timerDrainLife:Cancel()
		timerDrainLife:Start(oldDrainLife + 36)
		timerAirPhase:Cancel()
		warnAirPhaseNow:Show()
		timerLanding:Start()
	end
end, 0.2)
