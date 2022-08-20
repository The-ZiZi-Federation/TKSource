-------------------------------------------------------
--   Spell: Zap Lv1                        
--   Class: Wizard
--   Level: 5
--  Aether: 0
--    Cost: (player.maxMagic * 0.025)
--	Damage: (player.maxMagic * manaMult) + (player.level * levelMult)
-- DmgType: Magical
--    Type: Lightning
-- Targets: Single, Ranged
--  Effect: Chance to Shock on Hit for 3 seconds.
-------------------------------------------------------
--    Desc: Electricity zaps the target.
-------------------------------------------------------
-- Script Author: John Crandell, John Day, Justin Chartier 
--   Last Edited: 07/02/2017
-------------------------------------------------------
zap_lv1 = {

on_learn = function(player) player.registry["learned_zap_lv1"] = 1
	player:removeSpell("zap_lv2") 
	player:removeSpell("zap_lv3") 
	player:removeSpell("zap_lv4") 
	player:removeSpell("zap_lv5")
end,
    on_forget = function(player) player.registry["learned_zap_lv1"] = 0 end,

cast = function(player, target)
----------------------
--Varable Declarations
----------------------
	if not distanceSquare(player, target, 9) then
		player:sendMinitext("Target is too far away!")
		return
	end

	local magicCost = (player.maxMagic * 0.01)
	local shockDuration = 3000
	local r = math.random(1,1000)
	
	local threat

	local m = player.m
	local x = player.x
	local y = player.y
	
	local anim = 27
	local sound = 57
	
---------------------------
--- Spell Damage Formula---
---------------------------
	local manaMult = 0
	local levelMult = 0
	
	if player.level < 17 then 
		manaMult = 0.15
		levelMult = 15
	elseif player.level >= 17 then
		manaMult = 0.25
		levelMult = 25
	end

	local damage = (player.maxMagic * manaMult) + (player.level * levelMult)
	damage = math.floor(damage)
---------------------------------
-- Cast Checks ------------------
---------------------------------
	if (player.blType == BL_PC) then
		if (not player:canCast(1, 1, 0)) then
			return
		end
	end
	
	if (player.magic < magicCost) then
		player:sendAnimation(246)
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (target.state == 1) then
		player:sendMinitext("That is no longer useful.")
		return
	end

-----------------player vs mob-------------------------------
	if (target.blType == BL_MOB) then
		player.magic = player.magic - magicCost
		player:sendAction(6, 20)
		player:sendStatus()
		player:playSound(sound)
		target:sendAnimation(anim)
		player:sendMinitext("You cast Zap Lv1")
		
		if player.registry["extra_spell_info"] == 1 then
			player:sendMinitext("Zap Lv1 DMG: "..damage)
		end
		
		target.attacker = player.ID
		
		threat = target:removeHealthExtend(damage, 1, 1, 0, 1, 2)
		player:addThreat(target.ID, threat)
		target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		if r <= 50 then 
			if not target:hasDuration("shock") then
				if checkResist(player, target, "shock") == 1 then return end
				target:setDuration("shock", shockDuration)
			end
		end
----------------player vs player-----------------------------------------------------------	
	elseif (target.blType == BL_PC and player:canPK(target)) then
		player:sendAction(6, 20)
		player.magic = player.magic - magicCost
		player:sendStatus()
		player:playSound(sound)
		target:sendAnimation(anim)
		player:sendMinitext("You cast Zap Lv1")
		target.attacker = player.ID
		target:removeHealthExtend(damage, 1, 1, 0, 1, 1)
		target:sendMinitext(player.name.." burns you with Zap Lv1")
		if r <= 50 then 
			if not target:hasDuration("shock") then
				target:setDuration("shock", shockDuration)
			end
		end
	end
end,

requirements = function(player)

	local level = 5
	local item = {0, 50, 248}
	local amounts = {5, 10, 5}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	local desc = {"Zap Lv1 electrocutes an opponent!", txt}
	return level, item, amounts, desc
end
}