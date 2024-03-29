lightning_wand = { 
equip = function(player)
	if (player:canLearnSpell("lightning_wand")) then
		player:addSpell("lightning_wand")
	end
end,

unequip = function(player)
	if (player:hasSpell("lightning_wand")) then
		player:removeSpell(503)
	end
end,

on_break = function(player)
	if (player:hasSpell("lightning_wand")) then
		player:removeSpell(503)
	end
end,

cast = function(player, target)

	local mcost = 5
	
	if (player.state == 1) then
		player:sendMinitext("Spirits can't do that.")
		return
	end	
	
	if (player.state == 3) then
		player:sendMinitext("You can not cast this spell on a mount.")
		return
	end	
	
	if (target.state == 1) then
		player:sendMinitext("Your target is already dead.")
		return
	end
	if (target.blType == BL_PC) then
		if (target.pvp == 0) then
			player:sendMinitext("Something went wrong.")
			return
		end
	end
	if (player.magic < mcost) then
		player:sendMinitext("Not enough mana.")
		return
	end
	
	if (player:getEquippedDura(100000030) > 0) then
		player:deductDura(0, 1)
		player:removeMagic(mcost)
	else
		player:sendMinitext("You can not cast it at this moment.")
		return
	end
	
	player:playSound(29)
	player:sendAction(1, 80)
	target:sendAnimation(27)
	player:setAether("lightning_wand", 2000)
	local amt = (player.wisdom * 0.15) + player.will
	target.attacker = player.ID
	target:removeHealthExtend(amt, 1, 1, 0, 1, 0)
end

}