-------------------------------------------------------
--   Spell: Spirit's Blessing                         
--   Class: Priest
--   Level: 225
--  Aether: 0 Second
--    Cost: player.maxMagic / 9
--    Type: Blessing Bonus
-- Targets: Self
-- Effects: Blessing Mult: 91x
--        : Flank
--					X X X
--                  X P X
--                  X . X 
-------------------------------------------------------
--    Desc: Multiply your damage output to swing and spells while cast.
--        : Gain flanking and the ability to hit up to 7 targets at once.
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 6/5/2017
-------------------------------------------------------
spirits_blessing = {

on_learn = function(player) player.registry["learned_spirits_blessing"] = 1
end,
on_forget = function(player) player.registry["learned_spirits_blessing"] = 0 end,

cast = function(player)

	local magicCost = player.maxMagic / 9
	local duration = 600000
	local sound = 31
	local anim = 38


	if not player:canCast(1,1,0) then return end
	if player:hasDuration("spirits_blessing") then player:setDuration("spirits_blessing", 0) return end	
	if player.magic < magicCost then notEnoughMP(player) return end


	player:sendAction(6, 20)
	player.magic = player.magic - magicCost	
	player:sendStatus()
	player:sendAnimation(anim)
	player:playSound(sound)
	player:setDuration("spirits_blessing", duration)
	player:calcStat()
	player:sendMinitext("You cast Spirit's Blessing")

end,

on_swing_while_cast = function(player)


	if player.side == 0 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}

	elseif player.side == 1 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
	
	elseif player.side == 2 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x + 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}

	elseif player.side == 3 then
		pcflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_PC)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_PC)[1]}

	mobflankTargets = {player:getObjectsInCell(player.m, player.x, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y + 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x + 1, player.y - 1, BL_MOB)[1],
		player:getObjectsInCell(player.m, player.x - 1, player.y + 1, BL_MOB)[1]}
	end	

	for i = 1, 6 do
		if (pcflankTargets[i] ~= nil) then
			if pcflankTargets[i].state ~= 1 and player:canPK(pcflankTargets[i]) then
				player:swingTarget(pcflankTargets[i])
			end
		end
	end

	for i = 1, 6 do
		if (mobflankTargets[i] ~= nil) then
			player:swingTarget(mobflankTargets[i])

		end
	end
end,


recast = function(player)


	player.rage = 120


end,

uncast = function(player) 


	player:calcStat() 
end,


requirements = function(player)

	local level = 225
	local item = {0}
	local amounts = {35000}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	
	local desc = {"Spirit's Blessing is a stronger version of Divine Blessing.", txt}
	return level, item, amounts, desc
end
}