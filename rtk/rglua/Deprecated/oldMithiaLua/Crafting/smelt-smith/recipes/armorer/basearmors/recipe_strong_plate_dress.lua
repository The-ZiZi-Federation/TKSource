recipe_strong_plate_dress = {
	use = async(function(player)
	local opts = { }
	table.insert(opts,"Yes")
	table.insert(opts,"No")

	local t={graphic=convertGraphic(3052,"item"),color=0}
                player.npcGraphic=t.graphic
	        player.npcColor=t.color


	if(player.registry["recipestrongplatedress"]==1) then
			player:sendMinitext("You already how to forge a Strong Plate Dress.")
			return
	end

	player:dialogSeq({t,"Strong Plate Dress:\n\nA standard female warrior armor.",t,"Requires:\n\n-4 Tin bars\n-35 coins\n\nto be forged."},1)
	local choice=player:menuString2("Do you wish to learn how to forge a Strong Plate Dress?\n((This action is definitive and will consume your recipe))",opts)
		if(choice=="Yes") then
			player.registry["recipestrongplatedress"]=1
			player.registry["totalrecipenumber"]=player.registry["totalrecipenumber"]+1
			player.registry["recipearmorsmith"]=player.registry["recipearmorsmith"]+1
			player:removeItem("recipe_strong_plate_dress",1)
			player:dialogSeq({t,"You now know how to forge a Strong Plate Dress."})
		end	
	end)
}