recipe_dark_drapery = {
	use = async(function(player)
	local opts = { }
	table.insert(opts,"Yes")
	table.insert(opts,"No")

	local t={graphic=convertGraphic(3052,"item"),color=10}
                player.npcGraphic=t.graphic
	        player.npcColor=t.color

	if(player.registry["tailor"]<18000) then
			player:sendMinitext("You are not skilled enough to learn this recipe [Skilled Tailor Required].")
			return
	end
	if(player.registry["recipedarkdrapery"]==1) then
			player:sendMinitext("You already how to forge Dark Drapery.")
			return
	end

	player:dialogSeq({t,"Dark Drapery:\n\nA standard female poet Drapery.",t,"Requires:\n\n-Skilled tailor\n-Impenetrable drapery\n-100 Soulstones\n-20 Perendale fabric\n-10 Merino fabric\n-5 Shetland fabric\n-1 Rambouillet fabric\n-5000 coins\n\nto be forged."},1)
	local choice=player:menuString2("Do you wish to learn how to tailor a Dark Drapery?\n((This action is definitive and will consume your recipe))",opts)
		if(choice=="Yes") then
		if(player:hasItem("recipe_dark_drapery",1)) then
			player.registry["recipedarkdrapery"]=1
			player.registry["totalrecipenumber"]=player.registry["totalrecipenumber"]+1
			player.registry["recipetailoring"]=player.registry["recipetailoring"]+1
			player:removeItem("recipe_dark_drapery",1)
			player:dialogSeq({t,"You now know how to tailor a Dark Drapery."})
		end
		end	
	end)
}