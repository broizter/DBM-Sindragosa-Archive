local mod	= DBM:NewMod("Gluth", "DBM-Naxx", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2869 $"):sub(12, -3))
mod:SetCreatureID(15932)

mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEventsInCombat(
	"SPELL_DAMAGE 28375"
)

local warnDecimateSoon	= mod:NewSoonAnnounce(54426, 2)
local warnDecimateNow	= mod:NewSpellAnnounce(54426, 3)

local enrageTimer		= mod:NewBerserkTimer(420)
local timerDecimate		= mod:NewCDTimer(104, 54426, nil, nil, nil, 2)

function mod:OnCombatStart(delay)
	local subZone = GetSubZoneText()
	if subZone ~= "The Halls of Reanimation" then -- Fix for Gluth timers showing on Thaddius pull
		enrageTimer:Start(420 - delay)
		timerDecimate:Start(105 - delay)
		warnDecimateSoon:Schedule(95 - delay)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, spellId)
	if spellId == 28375 and self:AntiSpam(20) then
		warnDecimateNow:Show()
		timerDecimate:Start(60)
		warnDecimateSoon:Schedule(50)
	end
end


