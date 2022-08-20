
blue_rooster = {
--[[
uncast = function(mob)
local pc = mob:getObjectsInArea(BL_PC)
	
	mob:sendAnimationXY(292, mob.x, mob.y)
	mob:playSound(73)
	mob.look = 433
	for i = 1, #pc do
		pc[i]:refresh()
	end
	mob:removeHealth(mob.health)

end,

after_death = function(mob)

	blue_rooster.allyRevengeSpawn(mob)

end,

move = function(mob, target)

	if (mob.health <= (mob.maxHealth * 0.15)) and mob.registry["warning"] == 0 then
		blue_rooster.warningNPCSpawn(mob)
		mob.registry["warning"] = 1
	end

	mob_ai_basic.move(mob, target)

end,

attack = function(mob, target)

	if (mob.health <= (mob.maxHealth * 0.15)) and mob.registry["warning"] == 0 then
		
		blue_rooster.warningNPCSpawn(mob)
		mob.registry["warning"] = 1
	end
	mob_ai_basic.attack(mob, target)
	
end,


on_healed = function(mob, healer)

	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
	
end,


on_attacked = function(mob, attacker)
	
	mob_ai_basic.on_attacked(mob, attacker)	

end,


allyRevengeSpawn = function(mob)

	local map = mob.m
	local xmin, xmax = mob.x - 3, mob.x + 3
	local ymin, ymax = mob.y - 3, mob.y + 3
	local mobid = 22
	local number = 12
	
	dmSpawn.spawn(mob, map, xmin, xmax, ymin, ymax, mobid, number)

end,

warningNPCSpawn = function(mob)

	local map = mob.m
	local xmin, xmax = mob.x - 4, mob.x + 4
	local ymin, ymax = mob.y - 4, mob.y + 4
	local mobid = 23
	local number = 1

	
	dmSpawn.spawn(mob, map, xmin, xmax, ymin, ymax, mobid, number)

end
}


rooster_warning_npc = {

on_spawn = function(mob)
--Player(4):talk(0,"spawn")
	mob:sendAnimation(292)
	mob:talk(0,""..mob.name..": Hey! What are you doing?")

end,

move = function(mob)
--Player(4):talk(0,"move timer: "..mob.registry["timer"])
	mob.registry["timer"] = mob.registry["timer"] + 1
	
	if mob.registry["timer"] == 4 then
		mob:talk(0,""..mob.name..": Don't you know it's bad luck to kill a Blue Rooster?")
		
	elseif mob.registry["timer"] == 8 then
		mob:talk(0,""..mob.name..": This is going to be dangerous!")
		
	elseif mob.registry["timer"] == 11 then
		mob:talk(0,""..mob.name..": I'm getting out of here before you die.")
		
	elseif mob.registry["timer"] == 13 then
		mob:sendAnimationXY(292, mob.x, mob.y)
		mob:delete()
	end

end
}

angry_blue_chick = {

on_spawn = function(mob)
	mob:setDuration("blue_rooster", 60000)
end,

after_death = function(mob)


end,

move = function(mob, target)

	mob_ai_basic.move(mob, target)

end,

attack = function(mob, target)
	
	mob_ai_basic.attack(mob, target)
	
end,


on_healed = function(mob, healer)

	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
	
end,


on_attacked = function(mob, attacker)
	
	mob_ai_basic.on_attacked(mob, attacker)	

end,
]]--
}



