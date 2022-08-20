
race_mob = {

--[[

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



on_spawn = function(mob)

	local pc = mob:getObjectsInCell(mob.m, mob.x, mob.y, BL_PC)

	if pc ~= nil then
		mob.owner = pc[1].ID
	end

	local owner = mob:getBlock(mob.owner)
	local ownerT = mob:getBlock(owner.target)

	
	mob:talk(0,""..mob.name..": owner: "..owner.name)
	mob:talk(0,""..mob.name..": attacker: "..mob.attacker)
	mob:talk(0,""..mob.name..": target: "..mob.target)
	mob:talk(0,""..mob.name..": summon: "..mob.summon)

end





]]--

}








































