recipe_strong_skirt = {
	use = async(function(player)
	local opts = { }
	table.insert(opts,"Yes")
	table.insert(opts,"No")

	local t={graphic=convertGraphic(3052,"item"),color=10}
                player.npcGraphic=t.graphic
	        player.npcColor=t.color


	if(player.registry["recipestrongskirt"]==1) then
			player:sendMinitext("You already know how to tailor a Strong Skirt.")
			return
	end

	player:dialogSeq({t,"Strong skirt:\n\nA standard mage Skirt.",t,"Requires:\n\n-4 Wool fabric\n-35 coins\n\nto be tailored."},1)
	local choice=player:menuString2("Do you wish to learn how to tailor a Strong Skirt?\n((This action is definitive and will consume your recipe))",opts)
		if(choice=="Yes") then
			player.registry["recipestrongskirt"]=1
			player.registry["totalrecipenumber"]=player.registry["totalrecipenumber"]+1
			player.registry["recipetailoring"]=player.registry["recipetailoring"]+1
			player:removeItem("recipe_strong_skirt",1)
			player:dialogSeq({t,"You now know how to tailor a Strong Skirt."})
		end	
	end)
}