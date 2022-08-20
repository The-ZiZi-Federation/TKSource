petrify = {

on_learn = function(player) player.registry["learned_petrify"]= 1 end,
on_forget = function(player) player.registry["learned_petrify"]= 0 end,

cast = function(player, target)
	
	if not distanceSquare(player, target, 9) then
		player:sendMinitext("Target is too far away!")
		return
	end
	
	local duration = 20000
	local magicCost = 100
	local hitchance
	local aether = 1000
	local anim = 199
	local sound = 71
	
	if (not player:canCast(1, 1, 0)) then return end
	if (player.magic < magicCost) then notEnoughMP(player) return end
	if (target.state == 1 or target.blType ~= BL_MOB) then player:sendMinitext("Invalid Target") return end
	if(target.paralyzed==true) or target:hasDuration("petrify") then player:sendMinitext("Spell already cast") player:sendAnimation(246) return end	

	player:sendAction(6, 20)
	player:setAether("petrify", aether)
	player.magic = player.magic - magicCost
	player:sendStatus()
	player:sendMinitext("You cast Petrify")
	if checkResist(player, target, "petrify") == 1 then return end
	player:playSound(sound)
	target:sendAnimation(anim)
	target.paralyzed = true
	target:setDuration("petrify", duration)
end,

while_cast = function(player)

	player:sendAnimation(34)
end,

while_cast_250 = function(player)

	player.paralyzed = true
end,
	
uncast = function(player) 
	player.paralyzed = false
	player:calcStat()


end,

requirements = function(player)

	local level = 32
	local item = {0, 51, 389}
	local amounts = {5000, 1, 25}
	local txt = "In order to learn this spell, you must bring me:\n\n"
	for i = 1, #item do txt = txt..""..amounts[i].." "..Item(item[i]).name.."\n" end
	
	local desc = {"Petrify will stun an enemy! Strong enemies are resistant to Stuns!", txt}
	return level, item, amounts, desc
end
}