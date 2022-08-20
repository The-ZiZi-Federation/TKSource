-------------------------------------------------------
--   Spell: Spiritual Weapon                             
--   Class: Priest
--   Level: 84
--  Aether: 0 Second
--    Cost: 1100
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 6x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 6x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/13/2017
-------------------------------------------------------
spiritual_weapon = {

on_learn = function(player) player.registry["learned_spiritual_weapon"] = 1

end,
on_forget = function(player) player.registry["learned_spiritual_weapon"] = 0 end,

cast = function(player)

	local magicCost = 1100
	local duration = 600000
	local sound = 31
	local anim = 80

	if not player:canCast(1,1,0) then return end
	if player:hasDuration("spiritual_weapon") then player:setDuration("spiritual_weapon", 0) return end	
	if player.magic < magicCost then notEnoughMP(player) return end


	player:sendAction(6, 20)
	player.magic = player.magic - magicCost	
	player:sendStatus()
	player:sendAnimation(anim)
	player:playSound(sound)
	player:setDuration("spiritual_weapon", duration)
	player:calcStat()
	player:sendMinitext("You cast Spiritual Weapon")

end,

recast = function(player)

	player.enchant = 8

end,

uncast = function(player) 
	
	player:calcStat() 
	player:sendMinitext("You have lost focus on your Spiritual Weapon")
end,

requirements = function(player)

	local level = 84
	local item = {6001}
	local amounts = {3}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	
	local desc = {"Spiritual Weapon is a spell that enhances your skill and improves weapon damage!", txt}
	return level, item, amounts, desc
end
}
