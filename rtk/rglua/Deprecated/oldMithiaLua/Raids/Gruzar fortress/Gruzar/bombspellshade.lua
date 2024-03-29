bomb_spellshade = {
	while_cast=function(player)
		player:sendAnimation(48)
		player:talk(2,"I have the bomb!!!")
	end,
	uncast=function(player)
		local check = {}
		player:sendAnimation(19)
		player.attacker=player.ID
		if(player.state~=1) then
			player:removeHealth(6000)
		end
		if(player.m~=20006) then
			return
		end
		player:addMana(-player.magic/2)
		for x=-2,2 do
			for y=-2,2 do
				check=player:getObjectsInCell(player.m,player.x+x,player.y+y,BL_PC)
				if(#check>0) then
					for z=1,#check do
						if(check[z].ID~=player.ID and check[z].state~=1) then
							check[z].attacker=player.ID
							check[z]:sendAnimation(19)
							check[z]:removeHealthExtend(1000000, 1, 1, 1, 1, 0)
						end
					end
				end
			end
		end
		player:broadcast(player.m,"-"..player.name.." explodes!-")
	end
}