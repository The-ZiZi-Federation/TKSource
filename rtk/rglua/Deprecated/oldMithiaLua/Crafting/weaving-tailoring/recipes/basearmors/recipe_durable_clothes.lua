recipe_durable_clothes = {
	use = async(function(player)
	local opts = { }
	table.insert(opts,"Yes")
	table.insert(opts,"No")

	local t={graphic=convertGraphic(3052,"item"),color=10}
                player.npcGraphic=t.graphic
	        player.npcColor=t.color

	if(player.registry["tailor"]<840) then
			player:sendMinitext("You are not skilled enough to learn this recipe [Accomplished Tailor Required].")
			return
	end
	if(player.registry["recipedurableclothes"]==1) then
			player:sendMinitext("You already how to forge Durable Clothes.")
			return
	end

	player:dialogSeq({t,"Durable Clothes:\n\nA standard mage armor.",t,"Requires:\n\n-Accomplished tailor\n-12 Wool fabric\n-6 Romney fabric\n-1000 coins\n\nto be forged."},1)
	local choice=player:menuString2("Do you wish to learn how to tailor Durable Clothes?\n((This action is definitive and will consume your recipe))",opts)
		if(choice=="Yes") then
			player.registry["recipedurableclothes"]=1
			player.registry["totalrecipenumber"]=player.registry["totalrecipenumber"]+1
			player.registry["recipetailoring"]=player.registry["recipetailoring"]+1
			player:removeItem("recipe_durable_clothes",1)
			player:dialogSeq({t,"You now know how to tailor Durable Clothes."})
		end	
	end)
}