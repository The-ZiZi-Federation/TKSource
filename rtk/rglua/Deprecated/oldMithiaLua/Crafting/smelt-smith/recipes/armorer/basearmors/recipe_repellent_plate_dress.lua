recipe_repellent_plate_dress = {
	use = async(function(player)
	local opts = { }
	table.insert(opts,"Yes")
	table.insert(opts,"No")

	local t={graphic=convertGraphic(3052,"item"),color=0}
                player.npcGraphic=t.graphic
	        player.npcColor=t.color

	if(player.registry["armorer"]<2200) then
			player:sendMinitext("You are not skilled enough to learn this recipe [Adept Armorer Required].")
			return
	end
	if(player.registry["reciperepellentplatedress"]==1) then
			player:sendMinitext("You already how to forge a Repellent Plate Dress.")
			return
	end

	player:dialogSeq({t,"Repellent Plate Dress:\n\nA standard female warrior Plate Dress.",t,"Requires:\n\n-Adept Armorer\n-12 Copper bars\n-2 Silver bar\n-1200 coins\n\nto be forged."},1)
	local choice=player:menuString2("Do you wish to learn how to forge a Repellent Plate Dress?\n((This action is definitive and will consume your recipe))",opts)
		if(choice=="Yes") then
		if(player:hasItem("recipe_repellent_plate_dress",1)) then
			player.registry["reciperepellentplatedress"]=1
			player.registry["totalrecipenumber"]=player.registry["totalrecipenumber"]+1
			player.registry["recipearmorsmith"]=player.registry["recipearmorsmith"]+1
			player:removeItem("recipe_repellent_plate_dress",1)
			player:dialogSeq({t,"You now know how to forge a Repellent Plate Dress."})
		end
		end	
	end)
}