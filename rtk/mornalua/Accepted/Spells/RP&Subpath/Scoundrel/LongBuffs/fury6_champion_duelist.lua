-------------------------------------------------------
--   Spell: Champion Duelist                             
--   Class: Scoundrel
--   Level: 153
--  Aether: 0 Second
--    Cost: 50000
--    Type: Fury Bonus
-- Targets: Self
-- Effects: Fury Mult: 7x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Multiply your base damage 7x.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
champion_duelist = {

on_learn = function(player) player.registry["learned_champion_duelist"] = 1

end,
on_forget = function(player) player.registry["learned_champion_duelist"] = 0 end,

cast = function(player)

	local magicCost = 50000
	local duration = 600000
	local sound = 31
	local anim = 35

	if not player:canCast(1,1,0) then return end
	if player:hasDuration("champion_duelist") then player:setDuration("champion_duelist", 0) return end	
	if player.magic < magicCost then notEnoughMP(player) return end

	player:sendAction(6, 20)
	player.magic = player.magic - magicCost	
	player:sendStatus()
	player:sendAnimation(anim)
	player:playSound(sound)
	player:setDuration("champion_duelist", duration)
	player:calcStat()
	player:sendMinitext("You cast Champion Duelist")
end,

recast = function(player)

	player.fury = 12
end,

uncast = function(player) 
	
	player:calcStat() 
	player:sendMinitext("Champion Duelist ends.")
end,

requirements = function(player)

	local level = 153
	local item = {0}
	local amounts = {0}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	local desc = {"Champion Duelist is a spell that hones your fighting technique to increase your attack damage!\nReplaces Kingdom Duelist.", txt}
	return level, item, amounts, desc
end
}