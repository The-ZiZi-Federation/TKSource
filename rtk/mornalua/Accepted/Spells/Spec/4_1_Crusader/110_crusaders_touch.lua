-------------------------------------------------------
--   Spell: Crusader's Touch                          
--   Class: Crusader
--   Level: 110
--  Aether: 0 Second
--    Cost: 1000 MP
-- DmgType: N/A 
--    Type: Heal
-- Targets: Single Target
-- Effects: Restore Vita
-------------------------------------------------------
--    Desc: 
-------------------------------------------------------
-- Script Author: John Day / John Crandell / Justin Chartier
--   Last Edited: 08/12/2017
-------------------------------------------------------
--cure wounds- single target high heal level 110
crusaders_touch = {

on_learn = function(player) player.registry["learned_crusaders_touch"] = 1 end,
on_forget = function(player) player.registry["learned_crusaders_touch"] = 0 end,

cast = function(player, target)

	local magicCost = math.floor((player.level / 2 ) + 500)
	local healAmount = math.floor((player.will * 100) + (player.grace * 100) + 1000)

	local anim1 = 166
	local sound = 708
	
	if magicCost > 600 then magicCost = 600 end
	if healAmount > 9000 then healAmount = 9000 end
	
	if not player:canCast(1,1,0) then return else
		if player.magic < magicCost then notEnoughMP(player) return else
			if target.health == target.maxHealth then
				player:sendMinitext("Your target is at Max Vita!")
				return
			end
			if target.health <= 0 or target.state == 1 then
				player:sendMinitext("Your target is dead!")
				return
			end
			if target ~= nil then
				if target.state == 1 or player.health <= 0 then return else
					player:sendAction(6, 20)
					player.magic = player.magic - magicCost
					player:calcStat()
					player:sendStatus()
					player:sendMinitext("You cast Crusader's Touch  You heal your target for "..healAmount.." Vita.")
					player:playSound(sound)
					target:sendAnimation(anim1)
					addHealth(target, healAmount)
					if target.blType == BL_PC and target.ID ~= player.ID then 
						target:sendMinitext(player.name.." cast Crusader's Touch on you.  You are healed for "..healAmount.." Vita.")
					end
				end
			end
		end
	end
end,

requirements = function(player)

	local level = 5
	local item = {0}
	local amounts = {50000}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	local desc = {"Crusader's Touch is a spell that can be used to heal others.", txt}
	return level, item, amounts, desc
end
}
		