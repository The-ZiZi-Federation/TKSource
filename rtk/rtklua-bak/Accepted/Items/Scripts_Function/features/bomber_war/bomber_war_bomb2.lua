bomber_war_bomb2 = {	

while_cast_500 = function(player)
	local m = 15050
	local x = core.gameRegistry["bombx2"..player.name]
	local y = core.gameRegistry["bomby2"..player.name]
	
	if player.m == m then player:sendAnimationXY(361, x, y) end
end,

uncast = function(player)

	if player.m == 15050 then 
		bomber_war_bomb2.explode(player) 
	end
end,

explode = function(player)

	bomber_war_bomb2.breakBoxes(player)
	bomber_war_bomb2.kill(player)
	bomber_war_bomb2.animation(player)
	bomber_war_bomb2.cleanup(player)
	bomber_war.winnerCheck()
	
end,

animation = function(player)

	local m = 15050
	local x = core.gameRegistry["bombx2"..player.name]
	local y = core.gameRegistry["bomby2"..player.name]

	player:sendAnimationXY(13, x, y, 1)
	player:playSound(700)
	

	if player.registry["bomb_distance"] == 3 then
		if getPass(m, x, y-1) == 0 then 
			player:sendAnimationXY(48, x, y-1, 1) 
			player:sendAnimationXY(305, x, y-1, 1) 
			if getPass(m, x, y-2) == 0 and getObject(m, x, y-1) == 0 then
				player:sendAnimationXY(48, x, y-2, 1)
				player:sendAnimationXY(305, x, y-2, 1)
				if getPass(m, x, y-3) == 0 and getObject(m, x, y-2) == 0 then
					player:sendAnimationXY(48, x, y-3, 1)
					player:sendAnimationXY(305, x, y-3, 1)
					if getPass(m, x, y-4) == 0 and getObject(m, x, y-3) == 0 then
						player:sendAnimationXY(48, x, y-4, 1)
						player:sendAnimationXY(305, x, y-4, 1)
					end
				end
			end
		end
		if getPass(m, x, y+1) == 0 then	
			player:sendAnimationXY(48, x, y+1, 1) 
			player:sendAnimationXY(305, x, y+1, 1) 
			if getPass(m, x, y+2) == 0 and getObject(m, x, y+1) == 0 then
				player:sendAnimationXY(48, x, y+2, 1)
				player:sendAnimationXY(305, x, y+2, 1)
				if getPass(m, x, y+3) == 0 and getObject(m, x, y+2) == 0 then
					player:sendAnimationXY(48, x, y+3, 1)
					player:sendAnimationXY(305, x, y+3, 1)
					if getPass(m, x, y+4) == 0 and getObject(m, x, y+3) == 0 then
						player:sendAnimationXY(48, x, y+4, 1)
						player:sendAnimationXY(305, x, y+4, 1)
					end
				end

			end
		end
		if getPass(m, x+1, y) == 0 then 
			player:sendAnimationXY(48, x+1, y, 1) 
			player:sendAnimationXY(305, x+1, y, 1)
			if getPass(m, x+2, y) == 0 and getObject(m, x+1, y) == 0 then
				player:sendAnimationXY(48, x+2, y, 1)
				player:sendAnimationXY(305, x+2, y, 1)
				if getPass(m, x+3, y) == 0 and getObject(m, x+2, y) == 0 then
					player:sendAnimationXY(48, x+3, y, 1)
					player:sendAnimationXY(305, x+3, y, 1)
					if getPass(m, x+4, y) == 0 and getObject(m, x+3, y) == 0 then
						player:sendAnimationXY(48, x+4, y, 1)
						player:sendAnimationXY(305, x+4, y, 1)
					end
				end

			end

		end
		if getPass(m, x-1, y) == 0 then	
			player:sendAnimationXY(48, x-1, y, 1) 
			player:sendAnimationXY(305, x-1, y, 1) 
			if getPass(m, x-2, y) == 0 and getObject(m, x-1, y) == 0 then
				player:sendAnimationXY(48, x-2, y, 1)
				player:sendAnimationXY(305, x-2, y, 1)
				if getPass(m, x-3, y) == 0 and getObject(m, x-2, y) == 0 then
					player:sendAnimationXY(48, x-3, y, 1)
					player:sendAnimationXY(305, x-3, y, 1)
					if getPass(m, x-4, y) == 0 and getObject(m, x-3, y) == 0 then
						player:sendAnimationXY(48, x-4, y, 1)
						player:sendAnimationXY(305, x-4, y, 1)
					end
				end

			end

		end
	elseif player.registry["bomb_distance"] == 2 then
		if getPass(m, x, y-1) == 0 then 
			player:sendAnimationXY(48, x, y-1, 1) 
			player:sendAnimationXY(305, x, y-1, 1) 
			if getPass(m, x, y-2) == 0 and getObject(m, x, y-1) == 0 then
				player:sendAnimationXY(48, x, y-2, 1)
				player:sendAnimationXY(305, x, y-2, 1)
				if getPass(m, x, y-3) == 0 and getObject(m, x, y-2) == 0 then
					player:sendAnimationXY(48, x, y-3, 1)
					player:sendAnimationXY(305, x, y-3, 1)
				end
			end
		end
		if getPass(m, x, y+1) == 0 then	
			player:sendAnimationXY(48, x, y+1, 1) 
			player:sendAnimationXY(305, x, y+1, 1) 
			if getPass(m, x, y+2) == 0 and getObject(m, x, y+1) == 0 then
				player:sendAnimationXY(48, x, y+2, 1)
				player:sendAnimationXY(305, x, y+2, 1)
				if getPass(m, x, y+3) == 0 and getObject(m, x, y+2) == 0 then
					player:sendAnimationXY(48, x, y+3, 1)
					player:sendAnimationXY(305, x, y+3, 1)
				end

			end
		end
		if getPass(m, x+1, y) == 0 then 
			player:sendAnimationXY(48, x+1, y, 1) 
			player:sendAnimationXY(305, x+1, y, 1)
			if getPass(m, x+2, y) == 0 and getObject(m, x+1, y) == 0 then
				player:sendAnimationXY(48, x+2, y, 1)
				player:sendAnimationXY(305, x+2, y, 1)
				if getPass(m, x+3, y) == 0 and getObject(m, x+2, y) == 0 then
					player:sendAnimationXY(48, x+3, y, 1)
					player:sendAnimationXY(305, x+3, y, 1)
				end

			end

		end
		if getPass(m, x-1, y) == 0 then	
			player:sendAnimationXY(48, x-1, y, 1) 
			player:sendAnimationXY(305, x-1, y, 1) 
			if getPass(m, x-2, y) == 0 and getObject(m, x-1, y) == 0 then
				player:sendAnimationXY(48, x-2, y, 1)
				player:sendAnimationXY(305, x-2, y, 1)
				if getPass(m, x-3, y) == 0 and getObject(m, x-3, y) == 0 then
					player:sendAnimationXY(48, x-3, y, 1)
					player:sendAnimationXY(305, x-3, y, 1)
				end

			end

		end
	elseif player.registry["bomb_distance"] == 1 then

		if getPass(m, x, y-1) == 0 then 
			player:sendAnimationXY(48, x, y-1, 1) 
			player:sendAnimationXY(305, x, y-1, 1) 
			if getPass(m, x, y-2) == 0 and getObject(m, x, y-1) == 0 then
				player:sendAnimationXY(48, x, y-2, 1)
				player:sendAnimationXY(305, x, y-2, 1)
			end
		end

		if getPass(m, x, y+1) == 0 then	
			player:sendAnimationXY(48, x, y+1, 1)
			player:sendAnimationXY(305, x, y+1, 1)  
			if getPass(m, x, y+2) == 0 and getObject(m, x, y+1) == 0 then
				player:sendAnimationXY(48, x, y+2, 1)
				player:sendAnimationXY(305, x, y+2, 1)
			end
		end

		if getPass(m, x+1, y) == 0 then 
			player:sendAnimationXY(48, x+1, y, 1) 
			player:sendAnimationXY(305, x+1, y, 1) 
			if getPass(m, x+2, y) == 0 and getObject(m, x+1, y) == 0 then
				player:sendAnimationXY(48, x+2, y, 1)
				player:sendAnimationXY(305, x+2, y, 1)
			end

		end

		if getPass(m, x-1, y) == 0 then	
			player:sendAnimationXY(48, x-1, y, 1) 
			player:sendAnimationXY(305, x-1, y, 1) 
			if getPass(m, x-2, y) == 0 and getObject(m, x-1, y) == 0 then
				player:sendAnimationXY(48, x-2, y, 1)
				player:sendAnimationXY(305, x-2, y, 1)
			end

		end

	elseif player.registry["bomb_distance"] == 0 then

	if getPass(m, x, y-1) == 0 then player:sendAnimationXY(48, x, y-1, 1) player:sendAnimationXY(305, x, y-1, 1) end
	if getPass(m, x, y+1) == 0 then	player:sendAnimationXY(48, x, y+1, 1) player:sendAnimationXY(305, x, y+1, 1) end
	if getPass(m, x+1, y) == 0 then player:sendAnimationXY(48, x+1, y, 1) player:sendAnimationXY(305, x+1, y, 1) end
	if getPass(m, x-1, y) == 0 then	player:sendAnimationXY(48, x-1, y, 1) player:sendAnimationXY(305, x-1, y, 1) end

	end

end,


kill = function(player)

	local m = 15050
	local x = core.gameRegistry["bombx2"..player.name]
	local y = core.gameRegistry["bomby2"..player.name]
	
	local target1 = player:getObjectsInCell(m, x+1, y, BL_PC)
	local target2 = player:getObjectsInCell(m, x-1, y, BL_PC)
	local target3 = player:getObjectsInCell(m, x, y+1, BL_PC)
	local target4 = player:getObjectsInCell(m, x, y-1, BL_PC)
	
	local target5 = player:getObjectsInCell(m, x, y, BL_PC)
	
	local target1a = player:getObjectsInCell(m, x+2, y, BL_PC)
	local target2a = player:getObjectsInCell(m, x-2, y, BL_PC)
	local target3a = player:getObjectsInCell(m, x, y+2, BL_PC)
	local target4a = player:getObjectsInCell(m, x, y-2, BL_PC)
	
	local target1b = player:getObjectsInCell(m, x+3, y, BL_PC)
	local target2b = player:getObjectsInCell(m, x-3, y, BL_PC)
	local target3b = player:getObjectsInCell(m, x, y+3, BL_PC)
	local target4b = player:getObjectsInCell(m, x, y-3, BL_PC)
	
	local target1c = player:getObjectsInCell(m, x+4, y, BL_PC)
	local target2c = player:getObjectsInCell(m, x-4, y, BL_PC)
	local target3c = player:getObjectsInCell(m, x, y+4, BL_PC)
	local target4c = player:getObjectsInCell(m, x, y-4, BL_PC)

	local wall1 = getObject(m, x+1, y)
	local wall2 = getObject(m, x-1, y)
	local wall3 = getObject(m, x, y+1)
	local wall4 = getObject(m, x, y-1)

	local wall1a = getObject(m, x+2, y)
	local wall2a = getObject(m, x-2, y)
	local wall3a = getObject(m, x, y+2)
	local wall4a = getObject(m, x, y-2)

	local wall1b = getObject(m, x+3, y)
	local wall2b = getObject(m, x-3, y)
	local wall3b = getObject(m, x, y+3)
	local wall4b = getObject(m, x, y-3)


	if player.registry["bomb_distance"] == 3 then
	
		if #target1 > 0 then
			for i = 1, #target1 do
				if target1[i].state == 0 then
					target1[i].health = 0
					target1[i].state = 1
					target1[i]:sendStatus()
					target1[i]:updateState()
					target1[i]:sendAnimationXY(94, target1[i].x, target1[i].y)

					if target1[i].registry["bomber_war_team"] == 1 then
					target1[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target1[i].registry["bomber_war_team"] == 2 then
					target1[i]:warp(m,math.random(1,34),math.random(39,40))
					end





				end
			end
			
		elseif #target1 == 0 and #target1a > 0 then
			if wall1 == 0 then
				for i = 1, #target1a do
					if target1a[i].state == 0 then
						target1a[i].health = 0
						target1a[i].state = 1
						target1a[i]:sendStatus()
						target1a[i]:updateState()
						target1a[i]:sendAnimationXY(94, target1a[i].x, target1a[i].y)
						if target1a[i].registry["bomber_war_team"] == 1 then
						target1a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target1a[i].registry["bomber_war_team"] == 2 then
						target1a[i]:warp(m,math.random(1,34),math.random(39,40))
						end


					end
				end
			end
			
		elseif #target1 == 0 and #target1a == 0 and #target1b >0 then
			if wall1 == 0 and wall1a == 0 then
				for i = 1, #target1b do
					if target1b[i].state == 0 then
						target1b[i].health = 0
						target1b[i].state = 1
						target1b[i]:sendStatus()
						target1b[i]:updateState()
						target1b[i]:sendAnimationXY(94, target1b[i].x, target1b[i].y)
						if target1b[i].registry["bomber_war_team"] == 1 then
						target1b[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target1b[i].registry["bomber_war_team"] == 2 then
						target1b[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		elseif #target1 == 0 and #target1a == 0 and #target1b == 0 and #target1c > 0 then
			if wall1 == 0 and wall1a == 0 and wall1b == 0 then
				for i = 1, #target1c do
					if target1b[i].state == 0 then
						target1c[i].health = 0
						target1c[i].state = 1
						target1c[i]:sendStatus()
						target1c[i]:updateState()
						target1c[i]:sendAnimationXY(94, target1c[i].x, target1c[i].y)
						if target1c[i].registry["bomber_war_team"] == 1 then
						target1c[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target1c[i].registry["bomber_war_team"] == 2 then
						target1c[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end
		

		if #target2 > 0 then
			for i = 1, #target2 do
				if target2[i].state == 0 then
					target2[i].health = 0
					target2[i].state = 1
					target2[i]:sendStatus()
					target2[i]:updateState()
					target2[i]:sendAnimationXY(94, target2[i].x, target2[i].y)
						if target2[i].registry["bomber_war_team"] == 1 then
					target2[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target2[i].registry["bomber_war_team"] == 2 then
					target2[i]:warp(m,math.random(1,34),math.random(39,40))
					end

					
				end
			end
			
		elseif #target2 == 0 and #target2a > 0 then
			if wall2 == 0 then
				for i = 1, #target2a do
					if target2a[i].state == 0 then
						target2a[i].health = 0
						target2a[i].state = 1
						target2a[i]:sendStatus()
						target2a[i]:updateState()
						target2a[i]:sendAnimationXY(94, target2a[i].x, target2a[i].y)
						if target2a[i].registry["bomber_war_team"] == 1 then
						target2a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target2a[i].registry["bomber_war_team"] == 2 then
						target2a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
			
		elseif #target2 == 0 and #target2a == 0 and #target2b >0 then
			if wall2 == 0 and wall2a == 0 then
				for i = 1, #target2b do
					if target2b[i].state == 0 then
						target2b[i].health = 0
						target2b[i].state = 1
						target2b[i]:sendStatus()
						target2b[i]:updateState()
						target2b[i]:sendAnimationXY(94, target2b[i].x, target2b[i].y)
							if target2b[i].registry["bomber_war_team"] == 1 then
						target2b[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target2b[i].registry["bomber_war_team"] == 2 then
						target2b[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		elseif #target2 == 0 and #target2a == 0 and #target2b == 0 and #target2c > 0 then
			if wall2 == 0 and wall2a == 0 and wall2b == 0 then
				for i = 1, #target2c do
					if target2b[i].state == 0 then
						target2c[i].health = 0
						target2c[i].state = 1
						target2c[i]:sendStatus()
						target2c[i]:updateState()
						target2c[i]:sendAnimationXY(94, target2c[i].x, target2c[i].y)
						if target2c[i].registry["bomber_war_team"] == 1 then
						target2c[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target2c[i].registry["bomber_war_team"] == 2 then
						target2c[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end

		
		if #target3 > 0 then
			for i = 1, #target3 do
				if target3[i].state == 0 then
					target3[i].health = 0
					target3[i].state = 1
					target3[i]:sendStatus()
					target3[i]:updateState()
					target3[i]:sendAnimationXY(94, target3[i].x, target3[i].y)
						if target3[i].registry["bomber_war_team"] == 1 then
					target3[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target3[i].registry["bomber_war_team"] == 2 then
					target3[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target3 == 0 and #target3a > 0 then
			if wall3 == 0 then
				for i = 1, #target3a do
					if target3a[i].state == 0 then
						target3a[i].health = 0
						target3a[i].state = 1
						target3a[i]:sendStatus()
						target3a[i]:updateState()
						target3a[i]:sendAnimationXY(94, target3a[i].x, target3a[i].y)
						if target3a[i].registry["bomber_war_team"] == 1 then
						target3a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target3a[i].registry["bomber_war_team"] == 2 then
						target3a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
			
			
		elseif #target3 == 0 and #target3a == 0 and #target3b >0 then
			if wall3 == 0 and wall3a == 0 then
				for i = 1, #target3b do
					if target3b[i].state == 0 then
						target3b[i].health = 0
						target3b[i].state = 1
						target3b[i]:sendStatus()
						target3b[i]:updateState()
						target3b[i]:sendAnimationXY(94, target3b[i].x, target3b[i].y)
						if target3b[i].registry["bomber_war_team"] == 1 then
						target3b[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target3b[i].registry["bomber_war_team"] == 2 then
						target3b[i]:warp(m,math.random(1,34),math.random(39,40))
						end


					end
				end
			end
		elseif #target3 == 0 and #target3a == 0 and #target3b == 0 and #target3c > 0 then
			if wall3 == 0 and wall3a == 0 and wall3b == 0 then
				for i = 1, #target3c do
					if target3b[i].state == 0 then
						target3c[i].health = 0
						target3c[i].state = 1
						target3c[i]:sendStatus()
						target3c[i]:updateState()
						target3c[i]:sendAnimationXY(94, target3c[i].x, target3c[i].y)
						if target3c[i].registry["bomber_war_team"] == 1 then
						target3c[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target3c[i].registry["bomber_war_team"] == 2 then
						target3c[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end

		
		if #target4 > 0 then
			for i = 1, #target4 do
				if target4[i].state == 0 then
					target4[i].health = 0
					target4[i].state = 1
					target4[i]:sendStatus()
					target4[i]:updateState()
					target4[i]:sendAnimationXY(94, target4[i].x, target4[i].y)
					if target4[i].registry["bomber_war_team"] == 1 then
					target4[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target4[i].registry["bomber_war_team"] == 2 then
					target4[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target4 == 0 and #target4a > 0 then
			if wall4 == 0 then
				for i = 1, #target4a do
					if target4a[i].state == 0 then
						target4a[i].health = 0
						target4a[i].state = 1
						target4a[i]:sendStatus()
						target4a[i]:updateState()
						target4a[i]:sendAnimationXY(94, target4a[i].x, targeta4a[i].y)
						if target4a[i].registry["bomber_war_team"] == 1 then
						target4a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target4a[i].registry["bomber_war_team"] == 2 then
						target4a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
			
			
		elseif #target4 == 0 and #target4a == 0 and #target4b >0 then
			if wall4 == 0 and wall4a == 0 then
				for i = 1, #target4b do
					if target4b[i].state == 0 then
						target4b[i].health = 0
						target4b[i].state = 1
						target4b[i]:sendStatus()
						target4b[i]:updateState()
						target4b[i]:sendAnimationXY(94, target4b[i].x, targeta4b[i].y)
						if target4b[i].registry["bomber_war_team"] == 1 then
						target4b[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target4b[i].registry["bomber_war_team"] == 2 then
						target4b[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		elseif #target4 == 0 and #target4a == 0 and #target4b == 0 and #target4c > 0 then
			if wall4 == 0 and wall4a == 0 and wall4b == 0 then
				for i = 1, #target4c do
					if target4b[i].state == 0 then
						target4c[i].health = 0
						target4c[i].state = 1
						target4c[i]:sendStatus()
						target4c[i]:updateState()
						target4c[i]:sendAnimationXY(94, target4c[i].x, targeta4c[i].y)
						if target4c[i].registry["bomber_war_team"] == 1 then
						target4c[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target4c[i].registry["bomber_war_team"] == 2 then
						target4c[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end


		if #target5 > 0 then
			for i = 1, #target5 do
				if target5[i].state == 0 then
					target5[i].health = 0
					target5[i].state = 1
					target5[i]:sendStatus()
					target5[i]:updateState()
					target5[i]:sendAnimationXY(94, target5[i].x, target5[i].y)
					if target5[i].registry["bomber_war_team"] == 1 then
					target5[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target5[i].registry["bomber_war_team"] == 2 then
					target5[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
		end



	elseif player.registry["bomb_distance"] == 2 then
		if #target1 > 0 then
			for i = 1, #target1 do
				if target1[i].state == 0 then
					target1[i].health = 0
					target1[i].state = 1
					target1[i]:sendStatus()
					target1[i]:updateState()
					target1[i]:sendAnimationXY(94, target1[i].x, target1[i].y)
					if target1[i].registry["bomber_war_team"] == 1 then
					target1[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target1[i].registry["bomber_war_team"] == 2 then
					target1[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target1 == 0 and #target1a > 0 then
			if wall1 == 0 then
				for i = 1, #target1a do
					if target1a[i].state == 0 then
						target1a[i].health = 0
						target1a[i].state = 1
						target1a[i]:sendStatus()
						target1a[i]:updateState()
						target1a[i]:sendAnimationXY(94, target1a[i].x, target1a[i].y)
						if target1a[i].registry["bomber_war_team"] == 1 then
						target1a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target1a[i].registry["bomber_war_team"] == 2 then
						target1a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
			
		elseif #target1 == 0 and #target1a == 0 and #target1b >0 then
			if wall1 == 0 and wall1a == 0 then
				for i = 1, #target1b do
					if target1b[i].state == 0 then
						target1b[i].health = 0
						target1b[i].state = 1
						target1b[i]:sendStatus()
						target1b[i]:updateState()
						target1b[i]:sendAnimationXY(94, target1b[i].x, target1b[i].y)
						if target1b[i].registry["bomber_war_team"] == 1 then
						target1b[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target1b[i].registry["bomber_war_team"] == 2 then
						target1b[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end

		
		if #target2 > 0 then
			for i = 1, #target2 do
				if target2[i].state == 0 then
					target2[i].health = 0
					target2[i].state = 1
					target2[i]:sendStatus()
					target2[i]:updateState()
					target2[i]:sendAnimationXY(94, target2[i].x, target2[i].y)
					if target2[i].registry["bomber_war_team"] == 1 then
					target2[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target2[i].registry["bomber_war_team"] == 2 then
					target2[i]:warp(m,math.random(1,34),math.random(39,40))
					end


				end
			end
			
		elseif #target2 == 0 and #target2a > 0 then
			if wall2 == 0 then
				for i = 1, #target2a do
					if target2a[i].state == 0 then
						target2a[i].health = 0
						target2a[i].state = 1
						target2a[i]:sendStatus()
						target2a[i]:updateState()
						target2a[i]:sendAnimationXY(94, target2a[i].x, target2a[i].y)
						if target2a[i].registry["bomber_war_team"] == 1 then
						target2a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target2a[i].registry["bomber_war_team"] == 2 then
						target2a[i]:warp(m,math.random(1,34),math.random(39,40))
						end


					end
				end
			end
			
		elseif #target2 == 0 and #target2a == 0 and #target2b >0 then
			if wall2 == 0 and wall2a == 0 then
				for i = 1, #target2b do
					if target2b[i].state == 0 then
						target2b[i].health = 0
						target2b[i].state = 1
						target2b[i]:sendStatus()
						target2b[i]:updateState()
						target2b[i]:sendAnimationXY(94, target2b[i].x, target2b[i].y)
					if target2b[i].registry["bomber_war_team"] == 1 then
						target2b[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target2b[i].registry["bomber_war_team"] == 2 then
						target2b[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end


		
		if #target3 > 0 then
			for i = 1, #target3 do
				if target3[i].state == 0 then
					target3[i].health = 0
					target3[i].state = 1
					target3[i]:sendStatus()
					target3[i]:updateState()
					target3[i]:sendAnimationXY(94, target3[i].x, target3[i].y)
					if target3[i].registry["bomber_war_team"] == 1 then
					target3[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target3[i].registry["bomber_war_team"] == 2 then
					target3[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target3 == 0 and #target3a > 0 then
			if wall3 == 0 then
				for i = 1, #target3a do
					if target3a[i].state == 0 then
						target3a[i].health = 0
						target3a[i].state = 1
						target3a[i]:sendStatus()
						target3a[i]:updateState()
						target3a[i]:sendAnimationXY(94, target3a[i].x, target3a[i].y)
						
						if target3a[i].registry["bomber_war_team"] == 1 then
						target3a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target3a[i].registry["bomber_war_team"] == 2 then
						target3a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
			
			
		elseif #target3 == 0 and #target3a == 0 and #target3b >0 then
			if wall3 == 0 and wall3a == 0 then
				for i = 1, #target3b do
					if target3b[i].state == 0 then
						target3b[i].health = 0
						target3b[i].state = 1
						target3b[i]:sendStatus()
						target3b[i]:updateState()
						target3b[i]:sendAnimationXY(94, target3b[i].x, target3b[i].y)
						if target3b[i].registry["bomber_war_team"] == 1 then
					target3b[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target3b[i].registry["bomber_war_team"] == 2 then
					target3b[i]:warp(m,math.random(1,34),math.random(39,40))
					end

					end
				end
			end
		end

		if #target4 > 0 then
			for i = 1, #target4 do
				if target4[i].state == 0 then
					target4[i].health = 0
					target4[i].state = 1
					target4[i]:sendStatus()
					target4[i]:updateState()
					target4[i]:sendAnimationXY(94, target4[i].x, target4[i].y)
					if target4[i].registry["bomber_war_team"] == 1 then
					target4[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target4[i].registry["bomber_war_team"] == 2 then
					target4[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target4 == 0 and #target4a > 0 then
			if wall4 == 0 then
				for i = 1, #target4a do
					if target4a[i].state == 0 then
						target4a[i].health = 0
						target4a[i].state = 1
						target4a[i]:sendStatus()
						target4a[i]:updateState()
						target4a[i]:sendAnimationXY(94, target4a[i].x, targeta4a[i].y)
						
						if target4a[i].registry["bomber_war_team"] == 1 then
					target4a[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target4a[i].registry["bomber_war_team"] == 2 then
					target4a[i]:warp(m,math.random(1,34),math.random(39,40))
					end

					end
				end
			end
			
			
		elseif #target4 == 0 and #target4a == 0 and #target4b >0 then
			if wall4 == 0 and wall4a == 0 then
				for i = 1, #target4b do
					if target4b[i].state == 0 then
						target4b[i].health = 0
						target4b[i].state = 1
						target4b[i]:sendStatus()
						target4b[i]:updateState()
						target4b[i]:sendAnimationXY(94, target4b[i].x, targeta4b[i].y)
							if target4b[i].registry["bomber_war_team"] == 1 then
					target4b[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target4b[i].registry["bomber_war_team"] == 2 then
					target4b[i]:warp(m,math.random(1,34),math.random(39,40))
					end

					end
				end
			end
		end

		if #target5 > 0 then
			for i = 1, #target5 do
				if target5[i].state == 0 then
					target5[i].health = 0
					target5[i].state = 1
					target5[i]:sendStatus()
					target5[i]:updateState()
					target5[i]:sendAnimationXY(94, target5[i].x, target5[i].y)
					if target5[i].registry["bomber_war_team"] == 1 then
					target5[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target5[i].registry["bomber_war_team"] == 2 then
					target5[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
		end

		
	elseif player.registry["bomb_distance"] == 1 then

		if #target1 > 0 then
			for i = 1, #target1 do
				if target1[i].state == 0 then
					target1[i].health = 0
					target1[i].state = 1
					target1[i]:sendStatus()
					target1[i]:updateState()
					target1[i]:sendAnimationXY(94, target1[i].x, target1[i].y)
					if target1[i].registry["bomber_war_team"] == 1 then
					target1[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target1[i].registry["bomber_war_team"] == 2 then
					target1[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target1 == 0 and #target1a > 0 then
			if wall1 == 0 then
				for i = 1, #target1a do
					if target1a[i].state == 0 then
						target1a[i].health = 0
						target1a[i].state = 1
						target1a[i]:sendStatus()
						target1a[i]:updateState()
						target1a[i]:sendAnimationXY(94, target1a[i].x, target1a[i].y)
						if target1a[i].registry["bomber_war_team"] == 1 then
						target1a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target1a[i].registry["bomber_war_team"] == 2 then
						target1a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end

		if #target2 > 0 then
			for i = 1, #target2 do
				if target2[i].state == 0 then
					target2[i].health = 0
					target2[i].state = 1
					target2[i]:sendStatus()
					target2[i]:updateState()
					target2[i]:sendAnimationXY(94, target2[i].x, target2[i].y)
					if target2[i].registry["bomber_war_team"] == 1 then
					target2[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target2[i].registry["bomber_war_team"] == 2 then
					target2[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target2 == 0 and #target2a > 0 then
			if wall2 == 0 then
				for i = 1, #target2a do
					if target2a[i].state == 0 then
						target2a[i].health = 0
						target2a[i].state = 1
						target2a[i]:sendStatus()
						target2a[i]:updateState()
						target2a[i]:sendAnimationXY(94, target2a[i].x, target2a[i].y)
						if target2a[i].registry["bomber_war_team"] == 1 then
						target2a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target2a[i].registry["bomber_war_team"] == 2 then
						target2a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end

		if #target3 > 0 then
			for i = 1, #target3 do
				if target3[i].state == 0 then
					target3[i].health = 0
					target3[i].state = 1
					target3[i]:sendStatus()
					target3[i]:updateState()
					target3[i]:sendAnimationXY(94, target3[i].x, target3[i].y)
					if target3[i].registry["bomber_war_team"] == 1 then
					target3[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target3[i].registry["bomber_war_team"] == 2 then
					target3[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target3 == 0 and #target3a > 0 then
			if wall3 == 0 then
				for i = 1, #target3a do
					if target3a[i].state == 0 then
						target3a[i].health = 0
						target3a[i].state = 1
						target3a[i]:sendStatus()
						target3a[i]:updateState()
						target3a[i]:sendAnimationXY(94, target3a[i].x, target3a[i].y)
						if target3a[i].registry["bomber_war_team"] == 1 then
						target3a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target3a[i].registry["bomber_war_team"] == 2 then
						target3a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end

		if #target4 > 0 then
			for i = 1, #target4 do
				if target4[i].state == 0 then
					target4[i].health = 0
					target4[i].state = 1
					target4[i]:sendStatus()
					target4[i]:updateState()
					target4[i]:sendAnimationXY(94, target4[i].x, target4[i].y)
					if target4[i].registry["bomber_war_team"] == 1 then
					target4[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target4[i].registry["bomber_war_team"] == 2 then
					target4[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
			
		elseif #target4 == 0 and #target4a > 0 then
			if wall4 == 0 then
				for i = 1, #target4a do
					if target4a[i].state == 0 then
						target4a[i].health = 0
						target4a[i].state = 1
						target4a[i]:sendStatus()
						target4a[i]:updateState()
						target4a[i]:sendAnimationXY(94, target4a[i].x, target4a[i].y)
						if target4a[i].registry["bomber_war_team"] == 1 then
						target4a[i]:warp(m,math.random(1,34),math.random(1,2))
						elseif target4a[i].registry["bomber_war_team"] == 2 then
						target4a[i]:warp(m,math.random(1,34),math.random(39,40))
						end

					end
				end
			end
		end
		
		if #target5 > 0 then
			for i = 1, #target5 do
				if target5[i].state == 0 then
					target5[i].health = 0
					target5[i].state = 1
					target5[i]:sendStatus()
					target5[i]:updateState()
					target5[i]:sendAnimationXY(94, target5[i].x, target5[i].y)
					if target5[i].registry["bomber_war_team"] == 1 then
					target5[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target5[i].registry["bomber_war_team"] == 2 then
					target5[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
		end
		
	elseif player.registry["bomb_distance"] == 0 then

		if #target1 > 0 then
			for i = 1, #target1 do
				if target1[i].state == 0 then
					target1[i].health = 0
					target1[i].state = 1
					target1[i]:sendStatus()
					target1[i]:updateState()
					target1[i]:sendAnimationXY(94, target1[i].x, target1[i].y)
					if target1[i].registry["bomber_war_team"] == 1 then
					target1[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target1[i].registry["bomber_war_team"] == 2 then
					target1[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
		end
		
		if #target2 > 0 then
			for i = 1, #target2 do
				if target2[i].state == 0 then
					target2[i].health = 0
					target2[i].state = 1
					target2[i]:sendStatus()
					target2[i]:updateState()
					target2[i]:sendAnimationXY(94, target2[i].x, target2[i].y)
						if target2[i].registry["bomber_war_team"] == 1 then
					target2[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target2[i].registry["bomber_war_team"] == 2 then
					target2[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
		end
		
		if #target3 > 0 then
			for i = 1, #target3 do
				if target3[i].state == 0 then
					target3[i].health = 0
					target3[i].state = 1
					target3[i]:sendStatus()
					target3[i]:updateState()
					target3[i]:sendAnimationXY(94, target3[i].x, target3[i].y)
					if target3[i].registry["bomber_war_team"] == 1 then
					target3[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target3[i].registry["bomber_war_team"] == 2 then
					target3[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
		end
		if #target4 > 0 then
			for i = 1, #target4 do
				if target4[i].state == 0 then
					target4[i].health = 0
					target4[i].state = 1
					target4[i]:sendStatus()
					target4[i]:updateState()
					target4[i]:sendAnimationXY(94, target4[i].x, target4[i].y)
					if target4[i].registry["bomber_war_team"] == 1 then
					target4[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target4[i].registry["bomber_war_team"] == 2 then
					target4[i]:warp(m,math.random(1,34),math.random(39,40))
					end

				end
			end
		end
		
		if #target5 > 0 then
			for i = 1, #target5 do
				if target5[i].state == 0 then
					target5[i].health = 0
					target5[i].state = 1
					target5[i]:sendStatus()
					target5[i]:updateState()
					target5[i]:sendAnimationXY(94, target5[i].x, target5[i].y)
					if target5[i].registry["bomber_war_team"] == 1 then
					target5[i]:warp(m,math.random(1,34),math.random(1,2))
					elseif target5[i].registry["bomber_war_team"] == 2 then
					target5[i]:warp(m,math.random(1,34),math.random(39,40))
					end


				end
			end
		end
	end
end, 


breakBoxes = function(player)

	local m = 15050
	local x = core.gameRegistry["bombx2"..player.name]
	local y = core.gameRegistry["bomby2"..player.name]
	
	local boxNorth = getObject(m, x, y-1)
	local boxSouth = getObject(m, x, y+1)
	local boxEast = getObject(m, x+1, y)
	local boxWest = getObject(m, x-1, y)
	
	local boxNorth2 = getObject(m, x, y-2)
	local boxSouth2 = getObject(m, x, y+2)
	local boxEast2 = getObject(m, x+2, y)
	local boxWest2 = getObject(m, x-2, y)
	
	local boxNorth3 = getObject(m, x, y-3)
	local boxSouth3 = getObject(m, x, y+3)
	local boxEast3 = getObject(m, x+3, y)
	local boxWest3 = getObject(m, x-3, y)
	
	local boxNorth4 = getObject(m, x, y-4)
	local boxSouth4 = getObject(m, x, y+4)
	local boxEast4 = getObject(m, x+4, y)
	local boxWest4 = getObject(m, x-4, y)

	local bomb = player:getObjectsInCell(m, x, y, BL_ITEM)
	local r1 = math.random(1, 25)
	local r2 = math.random(1, 25)
	local r3 = math.random(1, 25)
	local r4 = math.random(1, 25)


	if player.registry["bomb_distance"] == 3 then
		if boxNorth == 15802 then 
			setObject(m, x, y-1, 0)
			if r1 == 1 then
				setTile(m, x, y-1, 31154)
			elseif r1 == 2 then
				setTile(m, x, y-1, 31123)
			elseif r1 == 3 then
				setTile(m, x, y-1, 29745)
			end 
		elseif boxNorth == 0 then
			if boxNorth2 == 15802 then
				setObject(m, x, y-2, 0)
				if r1 == 1 then
					setTile(m, x, y-2, 31154)
				elseif r1 == 2 then
					setTile(m, x, y-2, 31123)
				elseif r1 == 3 then
					setTile(m, x, y-2, 29745)
				end 
			elseif boxNorth2 == 0 then
				if boxNorth3 == 15802 then
					setObject(m, x, y-3, 0)
					if r1 == 1 then
						setTile(m, x, y-3, 31154)
					elseif r1 == 2 then
						setTile(m, x, y-3, 31123)
					elseif r1 == 3 then
						setTile(m, x, y-3, 29745)
					end 
				elseif boxNorth3 == 0 then
					if boxNorth4 == 15802 then
						setObject(m, x, y-4, 0)
						if r1 == 1 then
							setTile(m, x, y-4, 31154)
						elseif r1 == 2 then
							setTile(m, x, y-4, 31123)
						elseif r1 == 3 then
							setTile(m, x, y-4, 29745)
						end
					end 

				end
			end
		end

		if boxSouth == 15802 then 
			setObject(m, x, y+1, 0)
			if r2 == 1 then
				setTile(m, x, y+1, 31154)
			elseif r2 == 2 then
				setTile(m, x, y+1, 31123)
			elseif r2 == 3 then
				setTile(m, x, y+1, 29745)
			end 
		elseif boxSouth == 0 then
			if boxSouth2 == 15802 then
				setObject(m, x, y+2, 0)
				if r2 == 1 then
					setTile(m, x, y+2, 31154)
				elseif r2 == 2 then
					setTile(m, x, y+2, 31123)
				elseif r2 == 3 then
					setTile(m, x, y+2, 29745)
				end 
			elseif boxSouth2 == 0 then
				if boxSouth3 == 15802 then
					setObject(m, x, y+3, 0)
					if r2 == 1 then
						setTile(m, x, y+3, 31154)
					elseif r2 == 2 then
						setTile(m, x, y+3, 31123)
					elseif r2 == 3 then
						setTile(m, x, y+3, 29745)
					end 
				elseif boxSouth3 == 0 then
					if boxSouth4 == 15802 then
						setObject(m, x, y+4, 0)
						if r2 == 1 then
							setTile(m, x, y+4, 31154)
						elseif r2 == 2 then
							setTile(m, x, y+4, 31123)
						elseif r2 == 3 then
							setTile(m, x, y+4, 29745)
						end
					end
				end

			end
		end

		if boxEast == 15802 then 
			setObject(m, x+1, y, 0)
			if r3 == 1 then
				setTile(m, x+1, y, 31154)
			elseif r3 == 2 then
				setTile(m, x+1, y, 31123)
			elseif r3 == 3 then
				setTile(m, x+1, y, 29745)
			end 
		elseif boxEast == 0 then
			if boxEast2 == 15802 then
				setObject(m, x+2, y, 0)
				if r3 == 1 then
					setTile(m, x+2, y, 31154)
				elseif r3 == 2 then
					setTile(m, x+2, y, 31123)
				elseif r3 == 3 then
					setTile(m, x+2, y, 29745)
				end 
			elseif boxEast2 == 0 then
				if boxEast3 == 15802 then
					setObject(m, x+3, y, 0)
					if r3 == 1 then
						setTile(m, x+3, y, 31154)
					elseif r3 == 2 then
						setTile(m, x+3, y, 31123)
					elseif r3 == 3 then
						setTile(m, x+3, y, 29745)
					end 
				elseif boxEast3 == 0 then
					if boxEast4 == 15802 then
						setObject(m, x+4, y, 0)
						if r3 == 1 then
							setTile(m, x+4, y, 31154)
						elseif r3 == 2 then
							setTile(m, x+4, y, 31123)
						elseif r3 == 3 then
							setTile(m, x+4, y, 29745)
						end
					end
				end

			end
		end

		if boxWest == 15802 then 
			setObject(m, x-1, y, 0)
			if r4 == 1 then
				setTile(m, x-1, y, 31154)
			elseif r4 == 2 then
				setTile(m, x-1, y, 31123)
			elseif r4 == 3 then
				setTile(m, x-1, y, 29745)
			end 
		elseif boxWest == 0 then
			if boxWest2 == 15802 then
				setObject(m, x-2, y, 0)
				if r4 == 1 then
					setTile(m, x-2, y, 31154)
				elseif r4 == 2 then
					setTile(m, x-2, y, 31123)
				elseif r4 == 3 then
					setTile(m, x-2, y, 29745)
				end 
			elseif boxWest2 == 0 then
				if boxWest3 == 15802 then
					setObject(m, x-3, y, 0)
					if r4 == 1 then
						setTile(m, x-3, y, 31154)
					elseif r4 == 2 then
						setTile(m, x-3, y, 31123)
					elseif r4 == 3 then
						setTile(m, x-3, y, 29745)
					end 
				elseif boxWest3 == 0 then
					if boxWest4 == 15802 then
						setObject(m, x-4, y, 0)
						
						if r4 == 1 then
							setTile(m, x-4, y, 31154)
						elseif r4 == 2 then
							setTile(m, x-4, y, 31123)
						elseif r4 == 3 then
							setTile(m, x-4, y, 29745)
						end
						
					end
				end

			end 
		end


	elseif player.registry["bomb_distance"] == 2 then

		if boxNorth == 15802 then 
			setObject(m, x, y-1, 0)
			if r1 == 1 then
				setTile(m, x, y-1, 31154)
			elseif r1 == 2 then
				setTile(m, x, y-1, 31123)
			elseif r1 == 3 then
				setTile(m, x, y-1, 29745)
			end 
		elseif boxNorth == 0 then
			if boxNorth2 == 15802 then
				setObject(m, x, y-2, 0)
				if r1 == 1 then
					setTile(m, x, y-2, 31154)
				elseif r1 == 2 then
					setTile(m, x, y-2, 31123)
				elseif r1 == 3 then
					setTile(m, x, y-2, 29745)
				end 
			elseif boxNorth2 == 0 then
				if boxNorth3 == 15802 then
					setObject(m, x, y-3, 0)
					if r1 == 1 then
						setTile(m, x, y-3, 31154)
					elseif r1 == 2 then
						setTile(m, x, y-3, 31123)
					elseif r1 == 3 then
						setTile(m, x, y-3, 29745)
					end 
				end
			end
		end

		if boxSouth == 15802 then 
			setObject(m, x, y+1, 0)
			if r2 == 1 then
				setTile(m, x, y+1, 31154)
			elseif r2 == 2 then
				setTile(m, x, y+1, 31123)
			elseif r2 == 3 then
				setTile(m, x, y+1, 29745)
			end 
		elseif boxSouth == 0 then
			if boxSouth2 == 15802 then
				setObject(m, x, y+2, 0)
				if r2 == 1 then
					setTile(m, x, y+2, 31154)
				elseif r2 == 2 then
					setTile(m, x, y+2, 31123)
				elseif r2 == 3 then
					setTile(m, x, y+2, 29745)
				end 
			elseif boxSouth2 == 0 then
				if boxSouth3 == 15802 then
					setObject(m, x, y+3, 0)
					if r2 == 1 then
						setTile(m, x, y+3, 31154)
					elseif r2 == 2 then
						setTile(m, x, y+3, 31123)
					elseif r2 == 3 then
						setTile(m, x, y+3, 29745)
					end 
				end

			end
		end

		if boxEast == 15802 then 
			setObject(m, x+1, y, 0)
			if r3 == 1 then
				setTile(m, x+1, y, 31154)
			elseif r3 == 2 then
				setTile(m, x+1, y, 31123)
			elseif r3 == 3 then
				setTile(m, x+1, y, 29745)
			end 
		elseif boxEast == 0 then
			if boxEast2 == 15802 then
				setObject(m, x+2, y, 0)
				if r3 == 1 then
					setTile(m, x+2, y, 31154)
				elseif r3 == 2 then
					setTile(m, x+2, y, 31123)
				elseif r3 == 3 then
					setTile(m, x+2, y, 29745)
				end 
			elseif boxEast2 == 0 then
				if boxEast3 == 15802 then
					setObject(m, x+3, y, 0)
					if r3 == 1 then
						setTile(m, x+3, y, 31154)
					elseif r3 == 2 then
						setTile(m, x+3, y, 31123)
					elseif r3 == 3 then
						setTile(m, x+3, y, 29745)
					end 
				end
			end
		end

		if boxWest == 15802 then 
			setObject(m, x-1, y, 0)
			if r4 == 1 then
				setTile(m, x-1, y, 31154)
			elseif r4 == 2 then
				setTile(m, x-1, y, 31123)
			elseif r4 == 3 then
				setTile(m, x-1, y, 29745)
			end 
		elseif boxWest == 0 then
			if boxWest2 == 15802 then
				setObject(m, x-2, y, 0)
				if r4 == 1 then
					setTile(m, x-2, y, 31154)
				elseif r4 == 2 then
					setTile(m, x-2, y, 31123)
				elseif r4 == 3 then
					setTile(m, x-2, y, 29745)
				end 
			elseif boxWest2 == 0 then
				if boxWest3 == 15802 then
					setObject(m, x-3, y, 0)
					if r4 == 1 then
						setTile(m, x-3, y, 31154)
					elseif r4 == 2 then
						setTile(m, x-3, y, 31123)
					elseif r4 == 3 then
						setTile(m, x-3, y, 29745)
					end 
				end

			end 
		end


	elseif player.registry["bomb_distance"] == 1 then
		if boxNorth == 15802 then 
			setObject(m, x, y-1, 0)
			if r1 == 1 then
				setTile(m, x, y-1, 31154)
			elseif r1 == 2 then
				setTile(m, x, y-1, 31123)
			elseif r1 == 3 then
				setTile(m, x, y-1, 29745)
			end 
		elseif boxNorth == 0 then
			if boxNorth2 == 15802 then
				setObject(m, x, y-2, 0)
				if r1 == 1 then
					setTile(m, x, y-2, 31154)
				elseif r1 == 2 then
					setTile(m, x, y-2, 31123)
				elseif r1 == 3 then
				setTile(m, x, y-2, 29745)
				end 
			end
		end

		if boxSouth == 15802 then 
			setObject(m, x, y+1, 0)
			if r2 == 1 then
				setTile(m, x, y+1, 31154)
			elseif r2 == 2 then
				setTile(m, x, y+1, 31123)
			elseif r2 == 3 then
				setTile(m, x, y+1, 29745)
			end 
		elseif boxSouth == 0 then
			if boxSouth2 == 15802 then
				setObject(m, x, y+2, 0)
				if r2 == 1 then
					setTile(m, x, y+2, 31154)
				elseif r2 == 2 then
					setTile(m, x, y+2, 31123)
				elseif r2 == 3 then
					setTile(m, x, y+2, 29745)
				end 
			end
		end

		if boxEast == 15802 then 
			setObject(m, x+1, y, 0)
			if r3 == 1 then
				setTile(m, x+1, y, 31154)
			elseif r3 == 2 then
				setTile(m, x+1, y, 31123)
			elseif r3 == 3 then
				setTile(m, x+1, y, 29745)
			end 
		elseif boxEast == 0 then
			if boxEast2 == 15802 then
				setObject(m, x+2, y, 0)
				if r3 == 1 then
					setTile(m, x+2, y, 31154)
				elseif r3 == 2 then
					setTile(m, x+2, y, 31123)
				elseif r3 == 3 then
					setTile(m, x+2, y, 29745)
				end 
			end
		end

		if boxWest == 15802 then 
			setObject(m, x-1, y, 0)
			if r4 == 1 then
				setTile(m, x-1, y, 31154)
			elseif r4 == 2 then
				setTile(m, x-1, y, 31123)
			elseif r4 == 3 then
				setTile(m, x-1, y, 29745)
			end 
		elseif boxWest == 0 then
			if boxWest2 == 15802 then
				setObject(m, x-2, y, 0)
				if r4 == 1 then
					setTile(m, x-2, y, 31154)
				elseif r4 == 2 then
					setTile(m, x-2, y, 31123)
				elseif r4 == 3 then
					setTile(m, x-2, y, 29745)
				end 
			end 
		end
	elseif player.registry["bomb_distance"] == 0 then
		if boxNorth == 15802 then 
			setObject(m, x, y-1, 0)
			bomb_game.powerups()
			if r1 == 1 then
				setTile(m, x, y-1, 31154)
			elseif r1 == 2 then
				setTile(m, x, y-1, 31123)
			elseif r1 == 3 then
				setTile(m, x, y-1, 29745)
			end 
		end

		if boxSouth == 15802 then 
			setObject(m, x, y+1, 0) 
			if r2 == 1 then
				setTile(m, x, y+1, 31154)
			elseif r2 == 2 then
				setTile(m, x, y+1, 31123)
			elseif r2 == 3 then
				setTile(m, x, y+1, 29745)

			end
		end

		if boxEast == 15802 then 
			setObject(m, x+1, y, 0)
			if r3 == 1 then
				setTile(m, x+1, y, 31154)
			elseif r3 == 2 then
				setTile(m, x+1, y, 31123)
			elseif r3 == 3 then
				setTile(m, x+1, y, 29745)

			end
		end

		if boxWest == 15802 then 
			setObject(m, x-1, y, 0)
			if r4 == 1 then
				setTile(m, x-1, y, 31154)
			elseif r4 == 2 then
				setTile(m, x-1, y, 31123)
			elseif r4 == 3 then
				setTile(m, x-1, y, 29745)

			end
		end
	end
end,

cleanup = function(player)

	local m = player.m
	local x = core.gameRegistry["bombx2"..player.name]
	local y = core.gameRegistry["bomby2"..player.name]
	bomb = player:getObjectsInCell(15050, x, y, BL_ITEM)

	for i = 1, #bomb do 
		bomb[i]:delete() 
	end
	setPass(15050, x, y, 0)
	core.gameRegistry["bombx2"..player.name] = 0
	core.gameRegistry["bomby2"..player.name] = 0
end
}