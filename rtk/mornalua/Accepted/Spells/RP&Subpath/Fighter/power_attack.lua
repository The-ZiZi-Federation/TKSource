-------------------------------------------------------
--   Spell: Power Attack
--   Class: Fighter
--   Level: 9
--  Aether: 5 Second
--  MagicCost: (player.level* 10)+ (player.maxMagic/ 25)
-- DmgType: Physical
--    Type: Offensive
-- Targets: 1
--          . X .
--          . P .
--          . . .
-- Effects: N/A
-------------------------------------------------------
--    Desc: A heavy strike against a single foe.
-------------------------------------------------------
-- Script Author: John Day / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
power_attack = {
on_learn = function(player) player.registry["power_attack"]=1 end,
on_forget = function(player) player.registry["power_attack"]=0 end,

cast = function(player)
----------------------
--Varable Declarations
----------------------
	local mobTarget = getTargetFacing(player, BL_MOB)
	local pcTarget = getTargetFacing(player, BL_PC)
	local threat

	local aether = 5000
	local magicCost = (player.level * 25)

	local anim = 246
	local sound = 14

    local damage

	player.critChance = 1
-------------------------------------------------------
	if (not player:canCast(1, 1, 0)) then
		return
	end
-------------------------------------------------------
	if player.magic < magicCost or player.magic-magicCost <= 0 then
		player:sendAnimation(246)
		player:sendMinitext("Not Enough MP.")
		return
	end
------------------------------------
	if mobTarget ~= nil then
		damage = ((0.025 * player.maxHealth) + (0.1 * player.level)+ swingDamage(player, mobTarget, 2)) * 7
		mobTarget.attacker = player.ID
		player:sendAction(1, 20)
		player:talk(2, "~Smash~")
		player:sendMinitext("You use the Power Attack technique!")

		if player.registry["extra_spell_info"] > 0 then
			--player:sendMinitext("DMG From Might: "..damCalc)
			--player:sendMinitext("DMG From Swing: "..finalSwingDamage)
			--player:sendMinitext("DMG From Vita: "..vitaDamageBonus)
			--player:sendMinitext("Fury X: "..buff)
			--player:sendMinitext("--------------------------")
			player:sendMinitext("Power Attack DMG: "..damage)
		end

		player:setAether("power_attack", aether)
		player:playSound(sound)
		mobTarget:sendAnimation(6, 0)
	--	player:talk(0, "Before RHExtend1")
		threat = mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 2)

	--	player:talk(0, "After RHExtend1")

		player:addThreat(mobTarget.ID, threat)
		player.magic = player.magic - magicCost
		player:sendStatus()
	--	player:talk(0, "before RHExtend, damag = "..damage)
		mobTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)

	--	player:talk(0, "After RHExtend2")


	elseif pcTarget ~= nil then
		if (player:canPK(pcTarget)) then
			damage = ((0.025 * player.maxHealth) + (0.1 * player.level)+ swingDamage(player, pcTarget, 2)) * 4.2
			pcTarget.attacker = player.ID
			-- Action, Animation, Text, Sound ---
			player:sendAction(1, 20)
			player:talk(2, "~Smash~")
			player:sendMinitext("You use the Power Attack technique!")
			player:setAether("power_attack", aether)
			player:sendStatus()
			player:playSound(14)
			pcTarget:sendAnimation(6, 0)
			-- Apply Damage, pay MP Cost ----
			player.magic = player.magic - magicCost
			pcTarget:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		end
	end
end,

requirements = function(player)

	local level = 9
	local item = {50, 212}
	local amounts = {10, 10}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end


	local desc = {"This is essential. Once you learn how to hit, life just changes forever.", txt}
	return level, item, amounts, desc
end
}
