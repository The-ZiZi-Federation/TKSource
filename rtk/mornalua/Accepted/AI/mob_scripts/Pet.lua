
mob_ai_pet = {

on_healed = function(mob, healer)

	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)
	
	local moved = true
	local owner = mob:getBlock(mob.owner)
	local talk = {"!", "!!", "!!!"}
	local target = mob:getBlock(mob.target)
	
	if owner > 0 then
		if mob.m == owner.m then
			if not distanceSquare(mob, owner, 10) then
				if mob.health <= mob.maxHealth*.5 and mob.health > mob.maxHealth*.3 then
					owner:msg(12, "[Pet] Your pet has been attacked! Current pet's health: "..format_number(mob.health), owner.ID)
				elseif mob.health <= mob.maxHealth*.3 then
					owner:msg(12, "[Pet] Warning! your pet has been attacked at somewhere! Current pet's health: "..format_number(mob.health), owner.ID)	
				end
			end
		else
			mob:warp(owner.m, owner.x, owner.y)
		end
	end
	
	if math.random(0, 10) < 5 then 
		mob:talk(0, mob.name..": "..talk[math.random(#talk)])
	end
end,

move = function(mob, target)
	
	local moved = true
	local owner, target = mob:getBlock(mob.owner), mob:getBlock(mob.target)
	local act = math.random(1, 5)
		
	if owner == nil then
		mob:removeHealth(mob.health)
	return else
		if mob.m ~= owner.m then
			mob:warp(owner.m, owner.x, owner.y)
		return else
			if not distanceSquare(mob, owner, 10) then
				mob:warp(owner.m, owner.x, owner.y)
			return else
				moved = FindCoordsGhost(mob, owner)
				if distanceSquare(mob, owner, 1) or mob:moveIntent(owner.ID) == 1 then
					if math.random(0, 10) <= 3 then
						if act == 1 then
							mob:sendAction(1, 20)
						elseif act == 2 then
							toXY(mob.m, math.random(mob.x-1, mob.x+1), math.random(mob.y-1, mob.y+1))
						else
							mob.side = math.random(0, 3)
							mob:sendSide()
						end
					end
				end
			end
		end
	end
end,

attack = function(mob, target)
	
	local moved = true
	local owner = mob:getBlock(mob.owner)
	local ownerT = mob:getBlock(owner.target)
			
	if target == nil then mob.state = MOB_ALIVE return else
		if target.ID ~= owner.ID then
			if target.blType == BL_PC then
				if target.state ~= 1 and target.state ~= 2 then
					if owner:canPK(target) then
						moved = FindCoordsGhost(mob, target)
						if mob:moveIntent(target.ID) == 1 then
							mob:attack(target.ID)
						end
					end
				end
			end
		else
			mob.target = 0
			mob.state = MOB_ALIVE
		end
	end
end
}









testpet = {

before_death = function(mob)
Player(4):talk(0,"1")
	local mobT = mob:getBlock(mob.target)
	local attacker = mob:getBlock(mob.attacker)
Player(4):talk(0,"2")

if mobT ~= nil then 
	Player(4):talk(0,"Target: "..mobT.ID)
	Player(4):talk(0,"Attacker: "..mob.attacker)
else
	Player(4):talk(0,"wut")
end	
	mob:setThreat(mobT.ID, 0)
Player(4):talk(0,"2a")
	mob:setThreat(mob.attacker, 0)
Player(4):talk(0,"3")
	mob.target = 0
	mob.attacker = 0

Player(4):talk(0,"4")
	mobT.target = 0
	mobT.attacker = 0
Player(4):talk(0,"5")
end,

say = function(player, mob)

	local s = string.lower(player.speech)
	local owner = mob:getBlock(mob.owner)
	local ownerT = mob:getBlock(owner.target)
	local attacker = mob:getBlock(player.attacker)



	if player.ID == mob.owner then
		if string.find(s, "(.*)pet attack(.*)") then
			mob.attacker = attacker.ID
			mob.target = attacker.ID
			mob.state = MOB_HIT
			mob:talk(0,""..mob.name..": You got it!")
			testpet.attack(mob, player.attacker)
			

		end

	end


end,

on_spawn = function(mob)

	local pc = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_PC)

	if pc ~= nil then
		mob.owner = pc[1].ID
	end

	local owner = mob:getBlock(mob.owner)
	local ownerT = mob:getBlock(owner.target)

	
--	mob.attacker = ownerT
--	mob.target = ownerT
	mob.summon = true
	
	mob:talk(0,""..mob.name..": owner: "..owner.name)
	mob:talk(0,""..mob.name..": attacker: "..mob.attacker)
	mob:talk(0,""..mob.name..": target: "..mob.target)
	mob:talk(0,""..mob.name..": summon: "..mob.summon)

end,

on_healed = function(mob, healer)

	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)
	
	local moved = true
	local owner = mob:getBlock(mob.owner)
	local talk = {"!", "!!", "!!!"}
	local target = mob:getBlock(mob.target)

	if owner.ID > 0 then
		if mob.m == owner.m then
			if not distanceSquare(mob, owner, 10) then
				if mob.health <= mob.maxHealth*.5 and mob.health > mob.maxHealth*.3 then
					owner:msg(12, "[Pet] Your pet has been attacked! Current pet's health: "..format_number(mob.health), owner.ID)
				elseif mob.health <= mob.maxHealth*.3 then
					owner:msg(12, "[Pet] Warning! your pet has been attacked at somewhere! Current pet's health: "..format_number(mob.health), owner.ID)	
				end
			end
		else
			mob:warp(owner.m, owner.x, owner.y)
		end
	end
	
	mob_ai_basic.on_attacked(mob, target)
end,


move = function(mob, target)

--Player(4):talk(0, "petmove")
	
	local moved = true
	local owner, target = mob:getBlock(mob.owner), mob:getBlock(mob.target)
	local act = math.random(1, 5)
		
	if owner == nil then
		mob:removeHealth(mob.health)
	return else
		if mob.m ~= owner.m then
			mob:warp(owner.m, owner.x, owner.y)
		return else
			if not distanceSquare(mob, owner, 10) then
				mob:warp(owner.m, owner.x, owner.y)
			return else
				moved = FindCoords(mob, owner)
				if distanceSquare(mob, owner, 1) or mob:moveIntent(owner.ID) == 1 then
					if math.random(0, 10) <= 3 then
						if act == 1 then
							--mob:sendAction(1, 20)
						elseif act == 2 then
							toXY(mob.m, math.random(mob.x-1, mob.x+1), math.random(mob.y-1, mob.y+1))
						else
							--mob.side = math.random(0, 3)
							--mob:sendSide()
						end
					end
				end
				
			end
		end
	end
end,

attack = function(mob, target)

--Player(4):talk(0, "petattack")
	

	local moved = true
	local owner = mob:getBlock(mob.owner)
	local ownerT = mob:getBlock(owner.target)
			
	if target == nil then mob.state = MOB_ALIVE return else
		if target.ID ~= owner.ID then
			if target.blType == BL_PC then
				if target.state ~= 1 and target.state ~= 2 then
					if owner:canPK(target) then
						moved = FindCoords(mob, target)
						if mob:moveIntent(target.ID) == 1 then
							mob:attack(target.ID)
						end
					end
				end
			elseif target.blType == BL_MOB then
				moved = FindCoords(mob, target)
				if mob:moveIntent(target.ID) == 1 then
					mob:attack(target.ID)
				end
			end
		else
			mob.target = 0
			mob.state = MOB_ALIVE
		end
	end
end
}








































