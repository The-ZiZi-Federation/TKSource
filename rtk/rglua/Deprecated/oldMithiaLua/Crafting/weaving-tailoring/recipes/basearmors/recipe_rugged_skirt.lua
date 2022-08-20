recipe_rugged_skirt = {
	use = async(function(player)
	local opts = { }
	table.insert(opts,"Yes")
	table.insert(opts,"No")

	local t={graphic=convertGraphic(3052,"item"),color=10}
                player.npcGraphic=t.graphic
	        player.npcColor=t.color

	if(player.registry["tailor"]<2200) then
			player:sendMinitext("You are not skilled enough to learn this recipe [Adept Tailor Required].")
			return
	end
	if(player.registry["reciperuggedskirt"]==1) then
			player:sendMinitext("You already how to forge Rugged Skirt.")
			return
	end

	player:dialogSeq({t,"Rugged Skirt:\n\nA standard female mage Skirt.",t,"Requires:\n\n-Adept tailor\n-10 Perendale fabric\n-1 Shetland fabric\n-1200 coins\n\nto be forged."},1)
	local choice=player:menuString2("Do you wish to learn how to tailor Rugged Skirt?\n((This action is definitive and will consume your recipe))",opts)
		if(player:hasItem("recipe_rugged_skirt",1)) then
		if(choice=="Yes") then
			player.registry["reciperuggedskirt"]=1
			player.registry["totalrecipenumber"]=player.registry["totalrecipenumber"]+1
			player.registry["recipetailoring"]=player.registry["recipetailoring"]+1
			player:removeItem("recipe_rugged_skirt",1)
			player:dialogSeq({t,"You now know how to tailor Rugged Skirt."})
		end
		end	
	end)
}