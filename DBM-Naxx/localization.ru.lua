if GetLocale() ~= "ruRU" then return end

local L

-------------------
--  Anub'Rekhan  --
-------------------
L = DBM:GetModLocalization("Anub'Rekhan")

L:SetGeneralLocalization({
	name = "Ануб'Рекан"
})

L:SetWarningLocalization({
	SpecialLocust		= "Жуки-трупоеды",
	WarningLocustFaded	= "Жуки-трупоеды исчезают"
})

L:SetOptionLocalization({
	SpecialLocust		= "Cпец-предупреждение для Жуков-трупоедов",
	WarningLocustFaded	= "Предупреждение для исчезновения Жуков-трупоедов",
	ArachnophobiaTimer	= "Отсчет времени для Арахнофобия (достижение)"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Арахнофобия"
})

----------------------------
--  Grand Widow Faerlina  --
----------------------------
L = DBM:GetModLocalization("Faerlina")

L:SetGeneralLocalization({
	name = "Великая вдова Фарлина"
})

L:SetWarningLocalization({
	WarningEmbraceExpire	= "Объятие Вдовы через 5 секунд",
	WarningEmbraceExpired	= "Объятие Вдовы исчезает"
})

L:SetOptionLocalization({
	WarningEmbraceExpire	= "Предупреждение, когда Объятие Вдовы исчезает",
	WarningEmbraceExpired	= "Предупреждение, когда Объятие Вдовы закончится"
})

---------------
--  Maexxna  --
---------------
L = DBM:GetModLocalization("Maexxna")

L:SetGeneralLocalization({
	name = "Мексна"
})

L:SetWarningLocalization({
	WarningSpidersSoon	= "Паученыши Мексны через 5 секунд",
	WarningSpidersNow	= "В паутине появляются паучата"
})

L:SetTimerLocalization({
	TimerSpider	= "Паученыши Мексны"
})

L:SetOptionLocalization({
	WarningSpidersSoon	= "Предупреждать перед следующим призывом Паученышей Мексны",
	WarningSpidersNow	= "Предупреждение для призыва Паученышей Мексны",
	TimerSpider			= "Отсчет времени до Паученышей Мексны"
})

L:SetMiscLocalization({
	ArachnophobiaTimer	= "Арахнофобия"
})

------------------------------
--  Noth the Plaguebringer  --
------------------------------
L = DBM:GetModLocalization("Noth")

L:SetGeneralLocalization({
	name = "Нот Чумной"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Телепортация",
	WarningTeleportSoon	= "Телепортация через 20 секунд"
})

L:SetTimerLocalization({
	TimerTeleport		= "Телепортация",
	TimerTeleportBack	= "Телепортация обратно"
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Предупреждение о телепортации",
	WarningTeleportSoon	= "Предупреждать перед следующей телепортацией",
	TimerTeleport		= "Отсчет времени до телепортации",
	TimerTeleportBack	= "Отсчет времени до обратной телепортации"
})

--------------------------
--  Heigan the Unclean  --
--------------------------
L = DBM:GetModLocalization("Heigan")

L:SetGeneralLocalization({
	name = "Хейган Нечестивый"
})

L:SetWarningLocalization({
	WarningTeleportNow	= "Телепортация",
	WarningTeleportSoon	= "Телепортация через %d сек."
})

L:SetTimerLocalization({
	TimerTeleport	= "Телепортация",
})

L:SetOptionLocalization({
	WarningTeleportNow	= "Предупреждение о телепортации",
	WarningTeleportSoon	= "Предупреждать перед следующей телепортацией",
	TimerTeleport		= "Отсчет времени до телепортации"
})

---------------
--  Loatheb  --
---------------
L = DBM:GetModLocalization("Loatheb")

L:SetGeneralLocalization({
	name = "Лотхиб"
})

L:SetWarningLocalization({
	WarningHealSoon	= "Исцеление через 3 секунды",
	WarningHealNow	= "Исцеление"
})

L:SetOptionLocalization({
	WarningHealSoon		= "Предупреждать перед следующим исцелением",
	WarningHealNow		= "Предупреждение для исцеления",
	SporeDamageAlert	= "Сообщать шепотом и объявлять в рейд игроков, наносящих урон спорам\n(требуются права лидера или помощника)"
})

-----------------
--  Patchwerk  --
-----------------
L = DBM:GetModLocalization("Patchwerk")

L:SetGeneralLocalization({
	name = "Лоскутик"
})

L:SetOptionLocalization({
	WarningHateful	= "Объявлять цели под Ударом ненависти\n(требуются права лидера или помощника)"
})

L:SetMiscLocalization({
	yell1			= "Лоскутик хочет поиграть!",
	yell2			= "Кел'Тузад объявил Лоскутика воплощением войны!",
	HatefulStrike	= "Удар ненависти --> %s [%s]"
})

-----------------
--  Grobbulus  --
-----------------
L = DBM:GetModLocalization("Grobbulus")

L:SetGeneralLocalization({
	name = "Гроббулус"
})

L:SetOptionLocalization({
	SpecialWarningInjection		= "Cпец-предупреждение для Мутагенного укола",
	SetIconOnInjectionTarget	= "Устанавливать метки на цели заклинания Мутагенный укол"
})

L:SetWarningLocalization({
	SpecialWarningInjection	= "Вам сделали мутагенный укол."
})

L:SetTimerLocalization({
})

-------------
--  Gluth  --
-------------
L = DBM:GetModLocalization("Gluth")

L:SetGeneralLocalization({
	name = "Глут"
})

----------------
--  Thaddius  --
----------------
L = DBM:GetModLocalization("Thaddius")

L:SetGeneralLocalization({
	name = "Таддиус"
})

L:SetMiscLocalization({
	Yell	= "Сталагг сокрушить вас!",
	Emote	= "%s перезагружается!",
	Emote2	= "%s теряет связь!",
	Boss1	= "Фойген",
	Boss2	= "Сталагг",
	Charge1 = "отрицательную",
	Charge2 = "положительную"
})

L:SetOptionLocalization({
	WarningChargeChanged	= "Предупреждение, когда ваша полярность изменена",
	WarningChargeNotChanged	= "Предупреждение, когда ваша полярность не изменена",
	ArrowsEnabled			= "Отображать стрелки (обычная \"2-сторонняя\" стратегия)",
	ArrowsRightLeft			= "Стрелки влево/вправо для \"4-сторонней\" стратегии",
	ArrowsInverse			= "Обратная \"4-сторонняя\" стратегия (вправо, если полярность изменена, влево, если нет)",
	SoundWarnCountingShift	= "Проигрывать звуковой отсчет 5...1 до смены полярности"
})

L:SetWarningLocalization({
	WarningChargeChanged	= "Полярность изменена на %s",
	WarningChargeNotChanged	= "Полярность не изменена"
})

L:SetOptionCatLocalization({
	Arrows	= "Стрелки"
})

----------------------------
--  Instructor Razuvious  --
----------------------------
L = DBM:GetModLocalization("Razuvious")

L:SetGeneralLocalization({
	name = "Инструктор Разувий"
})

L:SetMiscLocalization({
	Yell1 = "Покажите мне, на что способны!",
	Yell2 = "Обучение окончено! Покажите мне, что вы усвоили!",
	Yell3 = "Вспомните, чему я вас учил!",
	Yell4 = "Выше ногу! Или у тебя с этим проблемы?"
})

L:SetOptionLocalization({
	WarningShieldWallSoon	= "Предупреждать о скором исчезновении Стены костей"
})

L:SetWarningLocalization({
	WarningShieldWallSoon	= "Стена костей закончится через 5 секунд"
})

----------------------------
--  Gothik the Harvester  --
----------------------------
L = DBM:GetModLocalization("Gothik")

L:SetGeneralLocalization({
	name = "Готик Жнец"
})

L:SetOptionLocalization({
	TimerWave			= "Отсчет времени до волны",
	TimerPhase2			= "Отсчет времени до фазы 2",
	WarningWaveSoon		= "Предупреждать перед следующей волной",
	WarningWaveSpawned	= "Предупреждение для волны призыва",
	WarningRiderDown	= "Предупреждение, когда всадник мертв",
	WarningKnightDown	= "Предупреждение, когда рыцарь мертв"
})

L:SetTimerLocalization({
	TimerWave	= "Волна %d",
	TimerPhase2	= "Фаза 2"
})

L:SetWarningLocalization({
	WarningWaveSoon		= "Волна %d: %s через 3 секунды",
	WarningWaveSpawned	= "Волна %d: %s призван",
	WarningRiderDown	= "Всадник мертв",
	WarningKnightDown	= "Рыцарь мертв",
	WarningPhase2		= "Фаза 2"
})

L:SetMiscLocalization({
	yell			= "Глупо было искать свою смерть.",
	WarningWave1	= "%d %s",
	WarningWave2	= "%d %s и %d %s",
	WarningWave3	= "%d %s, %d %s и %d %s",
	Trainee			= "Ученика",
	Knight			= "Рыцаря",
	Rider			= "Всадника",
})

---------------------
--  Four Horsemen  --
---------------------
L = DBM:GetModLocalization("Horsemen")

L:SetGeneralLocalization({
	name = "Четыре Всадника"
})

L:SetOptionLocalization({
	WarningMarkSoon				= "Предупреждать перед следующими знаками",
	WarningMarkNow				= "Предупреждение для знаков",
	SpecialWarningMarkOnPlayer	= "Спец-предупреждение, когда >4 знаков на вас"
})

L:SetTimerLocalization({
})

L:SetWarningLocalization({
	WarningMarkSoon				= "Знак %d через 3 секунды",
	WarningMarkNow				= "Знак %d",
	SpecialWarningMarkOnPlayer	= "%s: %s"
})

L:SetMiscLocalization({
	Korthazz	= "Тан Кортазз",
	Rivendare	= "Барон Ривендер",
	Blaumeux	= "Леди Бломе",
	Zeliek		= "Сэр Зелиек"
})

-----------------
--  Sapphiron  --
-----------------
L = DBM:GetModLocalization("Sapphiron")

L:SetGeneralLocalization({
	name = "Сапфирон"
})

L:SetOptionLocalization({
	WarningAirPhaseSoon	= "Предупреждать о приближении Воздушной фазы",
	WarningAirPhaseNow	= "Объявлять Воздушную фазу",
	WarningLanded		= "Объявлять Наземную фазу",
	TimerAir			= "Отсчет времени до Воздушной фазы",
	TimerLanding		= "Отсчет времени до приземления",
	TimerIceBlast		= "Отсчет времени до Ледяного дыхания",
	WarningDeepBreath	= "Специальное объявление Ледяного Дыхания",
	WarningIceblock		= "Кричать, когда вы в Ледяной глыбе",
	SpecWarnSapphLow	= "Спец-предупреждения для 10% босса(отмена воздушной фазы)"
})

L:SetMiscLocalization({
	EmoteBreath			= "%s глубоко вдыхает.",
	WarningYellIceblock	= "Я в Ледяной глыбе!"
})

L:SetWarningLocalization({
	WarningAirPhaseSoon	= "Воздушная фаза через 10 секунд",
	WarningAirPhaseNow	= "Воздушная фаза",
	WarningLanded		= "Сапфирон приземляется",
	WarningDeepBreath	= "Ледяное дыхание",
	SpecWarnSapphLow	= "У Сапфирона нет сил взлететь"
})

L:SetTimerLocalization({
	TimerAir		= "Воздушная фаза",
	TimerLanding	= "Приземление",
	TimerIceBlast	= "Ледяное дыхание"
})

------------------
--  Kel'Thuzad  --
------------------

L = DBM:GetModLocalization("Kel'Thuzad")

L:SetGeneralLocalization({
	name = "Кел'Тузад"
})

L:SetOptionLocalization({
	TimerPhase2		= "Отсчет времени до фазы 2",
	MCImminent		= "Сейчас контроль! (20s)",
	specwarnP2Soon	= "Спец-предупреждение за 10 секунд до вступления Кел'Тузада в бой",
	fissure 		= "Спец-предупреждение для Взрыва Бездны(войдзона)",
	manaNear		= "Спец-предупреждение когда рядом Взрыв Маны",
	warnAddsSoon	= "Предупреждать заранее о Стражах Ледяной Короны",
	BlastAlarm		= "Воспроизводить специальный звук сирены при применении Ледяного взрыва",
	EqUneqWeaponsKT	= "Снимать/надевать оружия перед/после контроля по таймеру. Для надевания создайте компл. экип. 'pve'. Для снятия не нужен.",
	EqUneqWeaponsKT2= "Снимать/надевать оружия когда контроль кастуется в вас.",
	ShowRange		= "Показывать окно проверки дистанции в фазе 2"
})

L:SetMiscLocalization({
	Yell		= "Соратники, слуги, солдаты холодной тьмы! Повинуйтесь зову Кел'Тузада!",
	YellMC1		= "Теперь твоя душа связана с моей!",
	YellMC2		= "Тебе не уйти!",
	setMissing	= "ВНИМАНИЕ! DBM: автоматическое снимание/надевание оружия не будет работать пока вы не создадите набор экипировки pve"
})

L:SetWarningLocalization({
	specwarnP2Soon	= "Кел'Тузад вступает в бой через 10 секунд",
	fissure 		= "Взрыв Бездны",
	manaNear		= "Рядом Взрыв Маны",
	warnAddsSoon	= "Скоро прибытие Стражей Ледяной Короны"
})

L:SetTimerLocalization({
	TimerPhase2	= "Фаза 2",
	MCImminent	= "Сейчас контроль! (20s)"
})

