elder_squirrel = {
on_healed = function(mob, healer)
	mob_ai_basic.on_healed(mob, healer)
end,

on_attacked = function(mob, attacker)
	elder_squirrel.regen(mob)
	mob_ai_basic.on_attacked(mob, attacker)
end,

move = function(mob, target)
	elder_squirrel.regen(mob)
	mob_ai_basic.move(mob, target)
end,

attack = function(mob, target)
	elder_squirrel.regen(mob)
	mob_ai_basic.attack(mob, target)
end,

regen = function(mob)
	if (mob.paralyzed or mob.sleep ~= 1 or mob.registry["regen"] > os.time()) then
		return
	end
	
	local amt = 1 + math.random(2)

	if (mob.health < mob.maxHealth) then
		if (mob.health + amt >= mob.maxHealth) then
			mob.health = mob.maxHealth
		else
			mob.health = mob.health + amt
		end
	end
	mob.registry["regen"] = os.time() + 1
end
}