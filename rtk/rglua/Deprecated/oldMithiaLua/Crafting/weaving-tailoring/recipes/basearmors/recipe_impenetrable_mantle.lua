recipe_impenetrable_mantle = {
	use = async(function(player)
	local opts = { }
	table.insert(opts,"Yes")
	table.insert(opts,"No")

	local t={graphic=convertGraphic(3052,"item"),color=10}
                player.npcGraphic=t.graphic
	        player.npcColor=t.color

	if(player.registry["tailor"]<6400) then
			player:sendMinitext("You are not skilled enough to learn this recipe [Talented Tailor Required].")
			return
	end
	if(player.registry["recipeimpenetrablemantle"]==1) then
			player:sendMinitext("You already how to forge Impenetrable Mantle.")
			return
	end

	player:dialogSeq({t,"Impenetrable Mantle:\n\nA standard poet Mantle.",t,"Requires:\n\n-Talented tailor\n-15 Perendale fabric\n-4 Shetland fabric\n-1500 coins\n\nto be forged."},1)
	local choice=player:menuString2("Do you wish to learn how to tailor Impenetrable Mantle?\n((This action is definitive and will consume your recipe))",opts)
		if(choice=="Yes") then
		if(player:hasItem("recipe_impenetrable_mantle",1)) then
			player.registry["recipeimpenetrablemantle"]=1
			player.registry["totalrecipenumber"]=player.registry["totalrecipenumber"]+1
			player.registry["recipetailoring"]=player.registry["recipetailoring"]+1
			player:removeItem("recipe_impenetrable_mantle",1)
			player:dialogSeq({t,"You now know how to tailor Impenetrable Mantle."})
		end
		end	
	end)
}