

mob_ai_ghost = {

on_healed = function(mob, healer)

	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob,attacker)
	
	local damage = 0
	local threat
	
	if attacker.blType == BL_PC then
		damage = element.getDamage(attacker, mob, attacker.damage)
		threat = mob:removeHealthExtend(damage, 1,1,1,1,2)
		attacker:addThreat(mob.ID, threat)
	end
	if damage - mob.armor > 0 then damage = damage - mob.armor end
	mob.attacker = attacker.ID
	mob:sendHealth(damage, attacker.critChance)
	attacker.damage = 0
end,
	
move = function(mob,target)

	local found
	local moved = true
	local pc = mob:getObjectsInArea(BL_PC)
	local move1, move2 = math.random(0, 10), math.random(0, 20)
	
	if (mob.paralyzed == true or mob.sleep ~= 1) then return end
	if (mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false) then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif (mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1) then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end

	if (mob.returning == true) then
		found = toStart(mob, mob.startX, mob.startY)
	else
		if (mob.owner == 0 or mob.owner > 1073741823) then
			threat.calcHighestThreat(mob)
			local block = mob:getBlock(mob.target)
			if (block ~= nil) then target = block end
		end
		if (target == nil) then
			if move1 <= 3 then
				mob.side = move1
				mob:sendSide()
			else
				if move1 > move2 then
					if not mob.snare and not mob.blind then moved = mob:moveGhost() end
				end
			end
			if #pc > 0 then
				for i = 1, #pc do
					if pc[i].state ~= 1 and pc[i].state ~= 2 then
						if pc[i].optFlags ~= 160 then
							mob.target = pc[i].ID
						end
					end
				end
			end
		else
			local owner = mob:getBlock(mob.owner)
			
			if (target == nil and owner ~= nil) then
				target = mob:getBlock(owner.target)
				mob.target = owner.target
			end
			
			if (target ~= nil) then
				if target.state ~= 1 and target.state ~= 2 then
					if (not mob.snare and not mob.blind) then moved = FindCoordsGhost(mob,target) end
					if mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner then
						mob.state = MOB_HIT
					end
				end
			end
		end
	end
	
	if (found == true) then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack = function(mob,target)
	
	local moved
	local pc = getTargetFacing(mob, BL_PC)
	
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		mob_ai_basic.move(mob, target)
		return
	end
	
	if (mob.paralyzed or mob.sleep ~= 1) then return end
	
	if (target) then
		threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then target = block end
		
		if target.state ~= 1 and target.state ~= 2 then
			moved=FindCoordsGhost(mob,target)
			if mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner then
				if pc ~= nil and pc.ID == target.ID then
					mob:attack(pc.ID)
				end
			else
				mob.target = 0
				mob.state = MOB_ALIVE
			end
		end
	else
		mob.target = 0
		mob.state = MOB_ALIVE
	end
end,
}















mob_ai_basic_old = {

on_healed = function(mob, healer)

	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)

	local damage = 0
	
	if attacker.damage > 0 then
		if attacker.damage - mob.armor > 0 then
			damage = attacker.damage - mob.armor
		end
	end
	mob.attacker = attacker.ID
	mob.target = attacker.ID 
	mob:sendHealth(damage, attacker.critChance)
end,


move = function(mob, target)
	
	local moved = true
	local found, owner
	local move1, move2 = math.random(0, 10), math.random(0, 20)

	if mob.paralyzed == true or mob.sleep > 1 or mob.snare or mob.blind then return else
		if mob.owner == 0 or mob.owner > 1073741823 then
		--	threat.calcHighestThreat(mob)
			getTarget = mob:getBlock(mob.target)
			if getTarget ~= nil then target = getTarget end
		end
		if target == nil then
			if mob.state ~= MOB_HIT then 
				if mob.owner == 0 then
					if move1 <= 3 then
						mob.side = move1
						mob:sendSide()
					return else
						if move1 > move2 then moved = mob:moveGhost() end
					end
				else
					owner = mob:getBlock(mob.owner)
					if owner ~= nil and target == nil then
						ownerTarget = mob:getBlock(owner.target)
						mob.target = ownerTarget.ID
					end
				end
			end
		return elseif target ~= nil then
			mob_ai_basic.priorityTarget(mob)
			if target.state == 1 or target.state == 2 or target.optFlags == 160 then
				mob.target = 0
				mob.state = MOB_ALIVE
			return else
				moved = FindCoordsGhost(mob, target)
				if mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner then
					pc = getTargetFacing(mob, BL_PC)
					if pc ~= nil and pc.ID == target.ID then
						if mob.registry["priority_target"] > 0 then
							if target.ID ~= mob.registry["priority_target"] then return end
						end
						mob.state = MOB_HIT
					end
				end
			end
		end
	end
end,

attack = function(mob, target)

	local moved = true

	if mob.paralyzed == true or mob.sleep > 1 or mob.snare or mob.blind then return else
		mob_ai_basic.priorityTarget(mob)
		if target == nil then mob.state = MOB_ALIVE return else
		--	threat.calcHighestThreat(mob)
			if target.blType == BL_PC then
				if target.gmLevel > 0 then
					if target.optFlags == 160 then
						mob.target = 0
						mob.state = MOB_ALIVE
						return
					end
				end
			end
			if target.state == 1 or target.state == 2 or target.optFlags == 160 then
				mob.target = 0
				mob.state = MOB_ALIVE
			return else
				moved = FindCoordsGhost(mob, target)
				if mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner then
					pc = getTargetFacing(mob, BL_PC)
					if pc ~= nil and pc.ID == target.ID then
						if mob.registry["priority_target"] > 0 then
							if target.ID ~= mob.registry["priority_target"] then return end
						end
						mob:sendAction(1, 20)
						mob:playSound(mob.sound)
						mob:attack(target.ID)
					end
				end
			end
		end
	end
end,

priorityTarget = function(mob)
	
	local reg = mob.registry["priority_target"]
	local target = Player(reg)
	
	if reg > 0 then
		if target ~= nil then
			if target.ID ~= mob.owner then
				if target.state ~= 1 then
					if target.m == mob.m then
						mob.target = target.ID
						mob.state = MOB_HIT
					return else
						mob.registry["priority_target"] = 0
					end
				return else
					mob.registry["priority_target"] = 0
				end
			end
		end
	end
end,
}



----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------


mob_ai_basic2 = {

on_healed = function(mob, healer)

	mob.attacker = healer.ID
	mob:sendHealth(healer.damage, healer.critChance)
	healer.damage = 0
end,

on_attacked = function(mob, attacker)

	mob.attacker = attacker.ID
	mob:sendHealth(attacker.damage, attacker.critChance)
	attacker.damage = 0
end,


move = function(mob, target)
	
	local moved = true
	local found
	local move1, move2 = math.random(0, 10), math.random(0, 20)
	
	if mob.paralyzed == true or mob.sleep ~= 1 then return end
	if mob.retDist <= distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 and mob.returning == false then
		mob.newMove = 250
		mob.deduction = mob.deduction - 1
		mob.returning = true
	elseif mob.returning == true and mob.retDist > distanceXY(mob, mob.startX, mob.startY) and mob.retDist > 1 then
		mob.newMove = mob.baseMove
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
	
	if mob.returning == true then
		found = toStart(mob, mob.startX, mob.startY)
	else
		if mob.owner == 0 or mob.owner > 1073741823 then
		--	threat.calcHighestThreat(mob)
			block = mob:getBlock(mob.target)
			if block ~= nil then target = block end
		end
		if mob.state ~= MOB_HIT and target == nil and mob.owner == 0 then
			if move1 <= 3 then
				mob.side = move1
				mob:sendSide()
			return else
				if move1 > move2 then
					if not mob.snare and not mob.blind then moved = mob:moveGhost() end
				end
			end
		else
			owner = mob:getBlock(mob.owner)
			if target == nil and owner ~= nil then
				target = mob:getBlock(owner.target)
				mob.target = owner.target
			end
			if target ~= nil then
				if not mob.snare and not mob.blind then
					if target.state ~= 1 and target.state ~= 2 then
						moved = FindCoordsGhost(mob, target)
					else
						mob.state = MOB_ALIVE
					end
				end
				if mob:moveIntent(target.ID) == 1 and mob.target ~= mob.owner then
					mob.state = MOB_HIT
				end
			end
		end
	end
	
	if found == true then
		mob.newMove = 0
		mob.deduction = mob.deduction + 1
		mob.returning = false
	end
end,

attack = function(mob,target)

	local moved
	if (mob.target == 0) then
		mob.state = MOB_ALIVE
		mob_ai_basic.move(mob, target)
		return
	end
	if (mob.paralyzed or mob.sleep ~= 1) then return end
	
	if (target) then
	--	threat.calcHighestThreat(mob)
		local block = mob:getBlock(mob.target)
		if (block ~= nil) then target = block end
		moved=FindCoordsGhost(mob,target)
		if(moved and mob.target ~= mob.owner) then
			--We are right next to them, so attack!
			mob:sendAction(1, 14)
			mob:playSound(mob.sound)
			mob:attack(target.ID)
		else
			mob.state = MOB_ALIVE
		end
	else
		mob.state = MOB_ALIVE
	end
end
}
	
	
	
	
	
