-------------------------------------------------------
--   Spell: Weapon Celerity                             
--   Class: Scoundrel
--   Level: 242
--  Aether: 0 Second
--    Cost: 350000
--    Type: Enchant Bonus
-- Targets: Self
-- Effects: Enchant Mult: 14x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your weapon's damage 14x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 07/07/2017
-------------------------------------------------------
weapon_celerity = {

on_learn = function(player) player.registry["learned_weapon_celerity"] = 1

end,
on_forget = function(player) player.registry["learned_weapon_celerity"] = 0 end,

cast = function(player)

	local magicCost = 350000
	local duration = 600000
	local sound = 31
	local anim = 35

	if not player:canCast(1,1,0) then return end
	if player:hasDuration("weapon_celerity") then player:setDuration("weapon_celerity", 0) return end	
	if player.magic < magicCost then notEnoughMP(player) return end

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost	
	player:sendStatus()
	player:sendAnimation(anim)
	player:playSound(sound)
	player:setDuration("weapon_celerity", duration)
	player:calcStat()
	player:sendMinitext("You cast Weapon Celerity")
end,

recast = function(player)

	player.enchant = 16
end,

uncast = function(player) 
	
	player:calcStat() 
	player:sendMinitext("You have lost focus on your Weapon Celerity")
end,

requirements = function(player)

	local level = 242
	local item = {0}
	local amounts = {0}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	local desc = {"Weapon Celerity is a spell that enhances your skill and improves weapon damage!", txt}
	return level, item, amounts, desc
end
}