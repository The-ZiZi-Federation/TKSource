-------------------------------------------------------
--   Spell: Believer's Blessing                           
--   Class: Priest
--   Level: 5
--  Aether: 0 Second
--    Cost: 100
--    Type: Rage Bonus
-- Targets: Self
-- Effects: Rage Mult: 2x
--        : Flank: N/A
-------------------------------------------------------
--    Desc: Double your damage output to swing and spells while cast.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
believers_blessing = {

on_learn = function(player) player.registry["learned_believers_blessing"] = 1


end,
on_forget = function(player) player.registry["learned_believers_blessing"] = 0 end,

cast = function(player)

	local magicCost = 100
	local duration = 600000
	local sound = 31
	local anim = 35

	if not player:canCast(1,1,0) then return end
	if player:hasDuration("believers_blessing") then player:setDuration("believers_blessing", 0) return end	
	if player.magic < magicCost then notEnoughMP(player) return end


	player:sendAction(6, 20)
	player.magic = player.magic - magicCost	
	player:sendStatus()
	player:sendAnimation(anim)
	player:playSound(sound)
	player:setDuration("believers_blessing", duration)
	player:calcStat()
	player:sendMinitext("You cast Believer's Blessing")

end,

recast = function(player)

	player.rage = 2

end,

uncast = function(player) 
	
	player:calcStat() 
	player:sendMinitext("Your Believer's Blessing fades away")
end,

requirements = function(player)

	local level = 5
	local item = {0}
	local amounts = {0}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	
	local desc = {"Believer's Blessing is a spell that multiplies your attack damage!", txt}
	return level, item, amounts, desc
end
}