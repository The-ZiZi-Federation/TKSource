shepherd_shrine = {
	click = function(player,npc)

		local x=math.abs(player.x-npc.x)
		local y=math.abs(player.y-npc.y)
		local t = os.date('*t')

		if(t.hour==1 or t.hour==2 or t.hour==4 or t.hour==5 or t.hour==7 or t.hour==8 or t.hour==10 or t.hour==11 or t.hour==13 or t.hour==14 or t.hour==16 or t.hour==17 or t.hour==19 or t.hour==20 or t.hour==22 or t.hour==23) then
			player:sendMinitext("Shrines can only be captured during 15 minutes every 3 hours")
			return
		end
		if(t.min>15) then
			player:sendMinitext("Shrines can only be captured during 15 minutes every 3 hours")
			return
		end
		if(player.state==1) then
			player:sendMinitext("Spirits can't do that.")
			return
		end
		if((x+y)>1) then
			player:sendMinitext("You are too far to activate the Shrine.")
			return
		end
		if(t.hour==0 and player.mapRegistry["shepherdshrinecomplete"]==24) then
			player.mapRegistry["shepherdshrinecomplete"]=0
		end
		if(player.mapRegistry["shepherdshrinecomplete"]>t.hour and player.mapRegistry["shepherdshrinecompday"]==t.day) then
			player:sendMinitext("The Shrine has already been captured")
			return
		end

		if(os.time()>player.mapRegistry["shepherdshrinelastgrabtime"]+60*20 and player.mapRegistry["shepherdshrinedefenseclan"]==player.clan) then
				player.mapRegistry["shepherdshrinelastgrab"]=9999
		end

		player.paralyzed=true
		player:setDuration("shepherd_shrine_capture",18000)
		player.registry["shepherdshrinestart"]=os.time()
		


		
        end

}

hid3201164115 = {
	click=function(player,npc)
		local t = os.date('*t')


		if(player.mapRegistry["shepherdshrinedefenseclan"]==player.clan and player.mapRegistry["shepherdshrinecomplete"]>t.hour and player.mapRegistry["shepherdshrinecompday"]==t.day) then
			player:warp(3201,168,119)
		else
			player:sendMinitext("The Shrine does not currently belong to your clan!")
			player:warp(3201,163,114)
		end
	end

}

shepherd_shrine_capture = {
		cast = function(player,target)

		end,
		while_cast=function(player)
			player.paralyzed=true
			player:sendAnimation(133)
		end,
		uncast = function(player)
			local t = os.date('*t')
			player.paralyzed=false
			if(player.m~=3201) then
				player:sendMinitext("You left the Battlefield before the Capture was complete.")
				return
			end
			if(player.mapRegistry["shepherdshrinecomplete"]>t.hour and player.mapRegistry["shepherdshrinecompday"]==t.day) then
				player:sendMinitext("The Shrine has already been captured")
				return
			end
			if(os.time()>=player.registry["shepherdshrinestart"]+15) then
					if(player.mapRegistry["shepherdshrinelastgrab"]~=player.clan) then
						if(os.time()>=player.mapRegistry["shepherdshrineaether"]+20) then
							player.mapRegistry["shepherdshrinespeech"]=0
							player.mapRegistry["shepherdshrineaether"]=os.time()
							player.mapRegistry["shepherdshrinedefensestart"]=os.time()
							player.mapRegistry["shepherdshrinetrigger"]=0
							player.mapRegistry["shepherdshrinelastgrabtime"]=os.time()
							player.mapRegistry["shepherdshrinelastgrab"]=player.clan
							player.mapRegistry["shepherdshrinelegend"]=player.ID
							player.mapRegistry["shepherdshrinedefenseclan"]=player.clan
							local clan="[Neutrals]"
							if(player.mapRegistry["shepherdshrinedefenseclan"]==0) then
								clan="[Neutrals]"
							elseif(player.mapRegistry["shepherdshrinedefenseclan"]==1) then
								clan="[Immortals]"
							elseif(player.mapRegistry["shepherdshrinedefenseclan"]==2) then
								clan="[Testers]"
							elseif(player.mapRegistry["shepherdshrinedefenseclan"]==3) then
								clan="[Alpha-Testers]"
							elseif(player.mapRegistry["shepherdshrinedefenseclan"]==4) then
								clan="[Heroes of Aesir]"
							elseif(player.mapRegistry["shepherdshrinedefenseclan"]==5) then
								clan="[Patriot]"
							elseif(player.mapRegistry["shepherdshrinedefenseclan"]==6) then
								clan="[Avalanche]"
							end
							player:broadcast(player.m,"-"..player.name.." of "..clan.." has captured the Shepherd Shrine. It must be defended for 3 minutes.")
							return
						else
							player:sendMinitext("The Shrine can only be attacked every 20 seconds")
							return
						end
					else
							player:sendMinitext("Your clan is already defending this Shrine!")
							return
					end
			else
				player:sendMinitext("You were interrupted during the capture!")
				return
			end

		end
				
}
shepherd_ghost = {
	move = function(mob,target)
		local e= {}
		local f= {}
		local g= {}
		local h= {}
		e=target:getObjectsInCell(mob.m,mob.x+1,mob.y,BL_PC)
		f=target:getObjectsInCell(mob.m,mob.x,mob.y-1,BL_PC)
		g=target:getObjectsInCell(mob.m,mob.x-1,mob.y,BL_PC)
		h=target:getObjectsInCell(mob.m,mob.x,mob.y+1,BL_PC)

		if(#e>0) then
			for a=1,#e do
				if(e[a].state==1) then
					e[a]:warp(mob.m,mob.x+5,mob.y)
				end
			end
		end
		if(#f>0) then
			for a=1,#f do
				if(f[a].state==1) then
					f[a]:warp(mob.m,mob.x,mob.y-5)
				end
			end
		end
		if(#g>0) then
			for a=1,#g do
				if(g[a].state==1) then
					g[a]:warp(mob.m,mob.x-5,mob.y)
				end
			end
		end
		if(#h>0) then
			for a=1,#h do
				if(h[a].state==1) then
					h[a]:warp(mob.m,mob.x,mob.y+5)
				end
			end
		end

		local clan="[Neutrals]"
		if(mob.mapRegistry["shepherdshrinedefenseclan"]==0) then
			clan="[Neutrals]"
		elseif(mob.mapRegistry["shepherdshrinedefenseclan"]==1) then
			clan="[Immortals]"
		elseif(mob.mapRegistry["shepherdshrinedefenseclan"]==2) then
			clan="[Testers]"
		elseif(mob.mapRegistry["shepherdshrinedefenseclan"]==3) then
			clan="[Alpha-Testers]"
		elseif(mob.mapRegistry["shepherdshrinedefenseclan"]==4) then
			clan="[Heroes of Aesir]"
		elseif(mob.mapRegistry["shepherdshrinedefenseclan"]==5) then
			clan="[Patriot]"
		elseif(mob.mapRegistry["shepherdshrinedefenseclan"]==6) then
			clan="[Avalanche]"
		end
		
		local t = os.date('*t')
		if(os.time()>=mob.mapRegistry["shepherdshrinedefensestart"]+30 and mob.mapRegistry["shepherdshrinespeech"]==0) then
				mob:talk(0,"30 Seconds have passed")
				mob.mapRegistry["shepherdshrinespeech"]=1
		end
		if(os.time()>=mob.mapRegistry["shepherdshrinedefensestart"]+60 and mob.mapRegistry["shepherdshrinespeech"]==1) then
				mob:talk(0,"1 minute has passed")
				mob.mapRegistry["shepherdshrinespeech"]=2
		end
		if(os.time()>=mob.mapRegistry["shepherdshrinedefensestart"]+90 and mob.mapRegistry["shepherdshrinespeech"]==2) then
				mob:talk(0,"1 minute and 30 seconds have passed")
				mob.mapRegistry["shepherdshrinespeech"]=3
		end
		if(os.time()>=mob.mapRegistry["shepherdshrinedefensestart"]+120 and mob.mapRegistry["shepherdshrinespeech"]==3) then
				mob:talk(0,"2 minutes have passed")
				mob.mapRegistry["shepherdshrinespeech"]=4
		end
		if(os.time()>=mob.mapRegistry["shepherdshrinedefensestart"]+150 and mob.mapRegistry["shepherdshrinespeech"]==4) then
				mob:talk(0,"2 minutes and 30 seconds have passed")
				mob.mapRegistry["shepherdshrinespeech"]=5
		end
		if(os.time()>=mob.mapRegistry["shepherdshrinedefensestart"]+180 and mob.mapRegistry["shepherdshrinespeech"]==5) then
				mob:talk(0,"3 minutes have passed")
				mob.mapRegistry["shepherdshrinespeech"]=6
		end
		if(mob.mapRegistry["shepherdshrinetrigger"]==0 and mob.mapRegistry["shepherdshrinespeech"]==6 and os.time()>=(mob.mapRegistry["shepherdshrinedefensestart"]+(180)) and os.time()<=(mob.mapRegistry["shepherdshrinedefensestart"]+(200)) and mob.mapRegistry["shepherdshrinedefensestart"]~=0) then
			mob.mapRegistry["shepherdshrinetrigger"]=1
			target:broadcast(-1,"-The Shepherd Shrine has been captured by "..clan..".")

			if(t.hour==0 or t.hour==1 or t.hour==2) then
				mob.mapRegistry["shepherdshrinecomplete"]=3
			elseif(t.hour==3 or t.hour==4 or t.hour==5) then
				mob.mapRegistry["shepherdshrinecomplete"]=6
			elseif(t.hour==6 or t.hour==7 or t.hour==8) then
				mob.mapRegistry["shepherdshrinecomplete"]=9
			elseif(t.hour==9 or t.hour==10 or t.hour==11) then
				mob.mapRegistry["shepherdshrinecomplete"]=12
			elseif(t.hour==12 or t.hour==13 or t.hour==14) then
				mob.mapRegistry["shepherdshrinecomplete"]=15
			elseif(t.hour==15 or t.hour==16 or t.hour==17) then
				mob.mapRegistry["shepherdshrinecomplete"]=18
			elseif(t.hour==18 or t.hour==19 or t.hour==20) then
				mob.mapRegistry["shepherdshrinecomplete"]=21
			elseif(t.hour==21 or t.hour==22 or t.hour==23) then
				mob.mapRegistry["shepherdshrinecomplete"]=24
			end
			mob.mapRegistry["shepherdshrinecompday"]=t.day

			Player(mob.mapRegistry["shepherdshrinelegend"]).registry["battlefieldcapturedshrines"]=Player(mob.mapRegistry["shepherdshrinelegend"]).registry["battlefieldcapturedshrines"]+1
			local count=Player(mob.mapRegistry["shepherdshrinelegend"]).registry["battlefieldcapturedshrines"]
			Player(mob.mapRegistry["shepherdshrinelegend"]):removeLegendbyName("capturedshrines")
			Player(mob.mapRegistry["shepherdshrinelegend"]):addLegend("Captured "..count.." shrines on the Battlefield","capturedshrines",7,16)

				
		end
			
		
	end
}