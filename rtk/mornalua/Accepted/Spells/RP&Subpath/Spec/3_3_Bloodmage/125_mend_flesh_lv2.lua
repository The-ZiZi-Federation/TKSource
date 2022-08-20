-------------------------------------------------------
--   Spell: Mend Flesh Lv2                   
--   Class: Necromancer
--   Level: 125
--  Aether: 0 seconds
-- MP Cost: 1000
-- DmgType: N/A
--    Type: Vita Recovery
-- Targets: Self
-- Heal Formula: 5000
-------------------------------------------------------
--    Desc: A Significant heal.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
mend_flesh_lv2 = {

on_learn = function(player) 
	player.registry["learned_mend_flesh_lv2"] = 1
	player:removeSpell("mend_flesh")
end,

on_forget = function(player) 
	player.registry["learned_mend_flesh_lv2"] = 0 
end,

cast = function(player)
	
	local anim = 149
	local sound = 736
	local aether = 0
	
	local recoverAmount = 5000
	local magicCost = 1000

	if not player:canCast(1,1,0) then return end
	
	if player.state == 1 or player.health <= 0 then return end
	
	if player.magic < magicCost then notEnoughMP(player) return end
	if player.health == player.maxHealth then
		player:sendMinitext("You are at Max Vita!!")
		return
	end
	
	player:sendAction(6, 20)
	player.magic = player.magic - magicCost
	player:sendAnimation(anim)
	player:playSound(sound)
	addHealth(player, recoverAmount)
	player:sendMinitext("You cast Mend Flesh Lv2.  You heal yourself for "..recoverAmount.." Vita.")
	
end,

requirements = function(player)

	local level = 125
	local item = {0}
	local amounts = {100000}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	
	local desc = {"Mend Flesh Lv2 is a Necromancer's upgraded self-healing spell.", txt}
	return level, item, amounts, desc
end
}
