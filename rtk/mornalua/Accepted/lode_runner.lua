lode_runner = {
--[[
dig = function(player)
	
	local m = player.m
	local x = player.x
	local y = player.y
	
	if player.side == 1 then
		dig = getTile(m,x+1,y)
	elseif player.side == 3 then
		dig = getTile(m,x-1,y)
	end
	
	if dig == 41641 then
		if player.side == 1 then
			setTile(m,x+1,y, 18234)
			setPass(m,x+1,y+1, 0)
		elseif player.side == 3 then
			setTile(m,x-1,y, 18234)
			setPass(m,x-1,y+1, 0)
		end
	end

end,


walk = function(player)

	local m = player.m
	local x = player.x
	local y = player.y
	local obj = getObject(m,x,y)
	local tile = getTile(m,x,y)
	local tileup = getTile(m,x,y-1)
	local ladder = 14349
	local ladderleft = getTile(m, x-1, y)
	local ladderright = getTile(m, x+1, y)

	if obj == 13580 then
		player.registry["pickup_gold"] = player.registry["pickup_gold"] + 1
		setObject(m,x,y,0)
		if player.registry["pickup_gold"] < player.mapRegistry["goal_gold"] then 
			player:playSound(719) 
		elseif player.registry["pickup_gold"] >= player.mapRegistry["goal_gold"] then
			if player.mapRegistry["complete"] == 0 then
				player:playSound(123)
				player.mapRegistry["complete"] = 1
				setObject(m, 9, 8, 14349)
				setObject(m, 9, 7, 14349)
				setObject(m, 9, 6, 14349)
				setObject(m, 9, 5, 14349)
				setObject(m, 9, 4, 14349)
				setTile(m, 9, 3, 37065)
				setPass(m, 9, 7, 0)
				setPass(m, 9, 6, 0)
				setPass(m, 9, 5, 0)
				setPass(m, 9, 4, 0)
				setPass(m, 9, 3, 0)
			end
		end
	end
	if tileup == 41641 then
		if ladderleft == 0 and ladderright == 0 then
			player:warp(m,x,y-2)
		end
	end
	if tile ~= 41641 and obj ~= ladder then
		if not player:hasDuration("falling") then
			--player:lock()
			--player.paralyzed = true
			player:setDuration("falling", 999999999)
			player:playSound(21)
		end
	end
	if player.mapRegistry["complete"] == 1 then
		if x == 9 then
			if y == 3 then
				player.mapRegistry["goal_gold"] = 19
				player.mapRegistry["complete"] = 0
				player:warp(3999, 16, 9)
				lode_runner.reset(player)
			end
		end
	end
	if tileup == 41641 then
		if ladderleft == 0 and ladderright == 0 then
			player:warp(m,x,y-2)
		end
	end

end,

jump = function(player)

	local m = player.m
	local x = player.x
	local y = player.y
	local obj = getObject(m,x,y)
	local tile = getTile(m,x,y)
	local npass = getPass(m,x,y-1)

	if npass == 0 then
		player:warp(m,x,y-1)
		player:setDuration("jumping", 1000)
	elseif npass == 1 then
		player:setDuration("jumping", 0)
	end

end,

reset = function(player)


	player.registry["pickup_gold"] = 0
	setObject(15015, 9, 8, 0)
	setObject(15015, 9, 7, 0)
	setObject(15015, 9, 6, 0)
	setObject(15015, 9, 5, 0)
	setObject(15015, 9, 4, 0)
	setObject(15015, 0, 1, 13580)
	setObject(15015, 1, 1, 13580)
	setObject(15015, 2, 1, 13580)
	setObject(15015, 0, 5, 13580)
	setObject(15015, 1, 5, 13580)
	setObject(15015, 5, 5, 13580)
	setObject(15015, 6, 5, 13580)
	setObject(15015, 13, 3, 13580)
	setObject(15015, 14, 3, 13580)
	setObject(15015, 15, 3, 13580)
	setObject(15015, 2, 8, 13580)
	setObject(15015, 3, 8, 13580)
	setObject(15015, 4, 8, 13580)
	setObject(15015, 9, 8, 13580)
	setObject(15015, 10, 8, 13580)
	setObject(15015, 11, 8, 13580)
	setObject(15015, 8, 13, 13580)
	setObject(15015, 9, 13, 13580)
	setObject(15015, 10, 13, 13580)
	setTile(15015, 9, 3, 43516)
	setPass(15015, 9, 7, 1)
	setPass(15015, 9, 6, 1)
	setPass(15015, 9, 5, 1)
	setPass(15015, 9, 4, 1)
	setPass(15015, 9, 3, 1)

	for x = 0, 16 do
		for y = 0, 14 do
			if getTile(15015, x, y) == 18234 then
				setTile(15015, x, y, 41641)
				setPass(15015, x, y, 0)
			end
		end
	end

end
}


jumping = {

while_cast_250 = function(player)

	local m = player.m
	local x = player.x
	local y = player.y
	local obj = getObject(m,x,y)
	local tile = getTile(m,x,y)
	local npass = getPass(m,x,y-1)

	if npass == 0 then
		player:warp(m,x,y-1)			
	elseif npass == 1 then
		player:setDuration("jumping", 0)
	end


end,


uncast = function(player)


	player:setDuration("falling", 4000)

end,
}


falling = {

while_cast_250 = function(player)

	local m = player.m
	local x = player.x
	local y = player.y
	local obj = getObject(m,x,y)
	local tile = getTile(m,x,y)
	local dpass = getPass(m,x,y+1)

	if dpass == 0 then
		if tile == 18234 or tile == 19495 then
			player.side = 2
			player:warp(m, x, y+1)
		else
			player:setDuration("falling", 0)
		end
	else
		player:setDuration("falling", 0)
	end

end,

while_cast = function(player)


end,

uncast = function(player)

--	player:unlock()

end]]--
}