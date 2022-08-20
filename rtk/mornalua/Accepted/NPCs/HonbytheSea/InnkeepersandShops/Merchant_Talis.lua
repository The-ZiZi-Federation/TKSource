--Merchant Talis - Finer Things - Hon
hon_finer_seller = {

click = async(function(player, npc)				
	
	local name = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID																
	
	local options = {}				
	table.insert(options, "Buy")		
	table.insert(options, "Sell")
	table.insert(options, "Repair Item")
	table.insert(options, "Repair All")
	if player.quest["help_joe"] == 1 and player.quest["joes_clothes"] == 0 then table.insert(options, "I'm here for Joe's clothes") end
	
	menu = player:menuString(name.."I am Talis, I buy and sell finery.", options)	
	
	if menu == "Buy" then
		finery_shop.buy(player, npc)
	elseif menu == "Sell" then
		finery_shop.sell(player, npc)
	elseif menu == "Repair Item" then
		player:repairExtend()
	elseif menu == 	"Repair All" then
		player:repairAll(player, npc)
	elseif menu == "I'm here for Joe's clothes" then
		player:dialogSeq({t, name.."Great! I was wondering when he would get this out of my shop. Here, take this back to him."}, 1)
		player.quest["joes_clothes"] = 1
		player:msg(4, "[Quest Updated] Obtained Joe's Suit!", player.ID)
	end
end),

say = function(player, npc)
	local speech = string.lower(player.speech)
	local item
	local number
	
	if string.sub(speech, 1, 6) == "i buy " and string.sub(speech, 7, 24) == "beginner tunic (m)" or string.sub(speech, 7, 24) == "beginner tunic (f)" or string.sub(speech, 7, 27) == "beginner leathers (m)" or string.sub(speech, 7, 27) == "beginner leathers (f)" 
		or string.sub(speech, 7, 23) == "trainee tunic (m)" or string.sub(speech, 7, 23) == "trainee tunic (f)" or string.sub(speech, 7, 26) == "trainee leathers (m)" or string.sub(speech, 7, 26) == "trainee leathers (f)" 
		or string.sub(speech, 7, 22) == "novice tunic (m)" or string.sub(speech, 7, 22) == "novice tunic (f)" or string.sub(speech, 7, 25) == "novice leathers (m)" or string.sub(speech, 7, 25) == "novice leathers (f)" 
		or string.sub(speech, 7, 24) == "initiate tunic (m)" or string.sub(speech, 7, 24) == "initiate tunic (f)" or string.sub(speech, 7, 27) == "initiate leathers (m)" or string.sub(speech, 7, 27) == "initiate leathers (f)" 
		or string.sub(speech, 7, 26) == "apprentice tunic (m)" or string.sub(speech, 7, 26) == "apprentice tunic (f)" or string.sub(speech, 7, 29) == "apprentice leathers (m)" or string.sub(speech, 7, 29) == "apprentice leathers (f)" 
		or string.sub(speech, 7, 26) == "journeyman tunic (m)" or string.sub(speech, 7, 26) == "journeyman tunic (f)" or string.sub(speech, 7, 29) == "journeyman leathers (m)" or string.sub(speech, 7, 29) == "journeyman leathers (f)" 
		or string.sub(speech, 7, 26) == "adventurer tunic (m)" or string.sub(speech, 7, 26) == "adventurer tunic (f)" or string.sub(speech, 7, 29) == "adventurer leathers (m)" or string.sub(speech, 7, 29) == "adventurer leathers (f)" 
		or string.sub(speech, 7, 20) == "hero tunic (m)" or string.sub(speech, 7, 20) == "hero tunic (f)" or string.sub(speech, 7, 23) == "hero leathers (m)" or string.sub(speech, 7, 23) == "hero leathers (f)" 
		or string.sub(speech, 7, 22) == "master tunic (m)" or string.sub(speech, 7, 22) == "master tunic (f)" or string.sub(speech, 7, 25) == "master leathers (m)" or string.sub(speech, 7, 25) == "master leathers (f)" 
		or string.sub(speech, 7, 22) == "beginner buckler" or string.sub(speech, 7, 21) == "trainee buckler" or string.sub(speech, 7, 20) == "novice buckler" or string.sub(speech, 7, 22) == "initiate buckler" or string.sub(speech, 7, 24) == "apprentice buckler" or string.sub(speech, 7, 24) == "journeyman buckler" or string.sub(speech, 7, 24) == "adventurer buckler" or string.sub(speech, 7, 18) == "hero buckler" or string.sub(speech, 7, 20) == "master buckler" or string.sub(speech, 7, 21) == "paragon buckler" 
		or string.sub(speech, 7, 23) == "beginner headband" or string.sub(speech, 7, 22) == "trainee headband" or string.sub(speech, 7, 21) == "novice headband" or string.sub(speech, 7, 23) == "initiate headband" or string.sub(speech, 7, 25) == "apprentice headband" or string.sub(speech, 7, 25) == "journeyman headband" or string.sub(speech, 7, 25) == "adventurer headband" or string.sub(speech, 7, 19) == "hero headband" or string.sub(speech, 7, 21) == "master headband" or string.sub(speech, 7, 22) == "paragon headband" 		
		or string.sub(speech, 7, 20) == "beginner glove" or string.sub(speech, 7, 19) == "trainee glove" or string.sub(speech, 7, 18) == "novice glove" or string.sub(speech, 7, 20) == "initiate glove" or string.sub(speech, 7, 22) == "apprentice glove" or string.sub(speech, 7, 22) == "journeyman glove" or string.sub(speech, 7, 22) == "adventurer glove" or string.sub(speech, 7, 16) == "hero glove" or string.sub(speech, 7, 18) == "master glove" or string.sub(speech, 7, 19) == "paragon glove" 
		or string.sub(speech, 7, 20) == "beginner boots" or string.sub(speech, 7, 19) == "trainee boots" or string.sub(speech, 7, 18) == "novice boots" or string.sub(speech, 7, 20) == "initiate boots" or string.sub(speech, 7, 22) == "apprentice boots" or string.sub(speech, 7, 22) == "journeyman boots" or string.sub(speech, 7, 22) == "adventurer boots" or string.sub(speech, 7, 16) == "hero boots" or string.sub(speech, 7, 18) == "master boots" or string.sub(speech, 7, 19) == "paragon boots" 
		or string.sub(speech, 7, 25) == "beginner shroud (m)" or string.sub(speech, 7, 25) == "beginner shroud (f)" or string.sub(speech, 7, 23) == "beginner robe (m)" or string.sub(speech, 7, 23) == "beginner robe (f)" 
		or string.sub(speech, 7, 24) == "trainee shroud (m)" or string.sub(speech, 7, 24) == "trainee shroud (f)" or string.sub(speech, 7, 22) == "trainee robe (m)" or string.sub(speech, 7, 22) == "trainee robe (f)" 
		or string.sub(speech, 7, 23) == "novice shroud (m)" or string.sub(speech, 7, 23) == "novice shroud (f)" or string.sub(speech, 7, 21) == "novice robe (m)" or string.sub(speech, 7, 21) == "novice robe (f)" 
		or string.sub(speech, 7, 25) == "initiate shroud (m)" or string.sub(speech, 7, 25) == "initiate shroud (f)" or string.sub(speech, 7, 23) == "initiate robe (m)" or string.sub(speech, 7, 23) == "initiate robe (f)" 
		or string.sub(speech, 7, 27) == "apprentice shroud (m)" or string.sub(speech, 7, 27) == "apprentice shroud (f)" or string.sub(speech, 7, 25) == "apprentice robe (m)" or string.sub(speech, 7, 25) == "apprentice robe (f)" 
		or string.sub(speech, 7, 27) == "journeyman shroud (m)" or string.sub(speech, 7, 27) == "journeyman shroud (f)" or string.sub(speech, 7, 25) == "journeyman robe (m)" or string.sub(speech, 7, 25) == "journeyman robe (f)" 
		or string.sub(speech, 7, 27) == "adventurer shroud (m)" or string.sub(speech, 7, 27) == "adventurer shroud (f)" or string.sub(speech, 7, 25) == "adventurer robe (m)" or string.sub(speech, 7, 25) == "adventurer robe (f)" 
		or string.sub(speech, 7, 21) == "hero shroud (m)" or string.sub(speech, 7, 21) == "hero shroud (f)" or string.sub(speech, 7, 19) == "hero robe (m)" or string.sub(speech, 7, 19) == "hero robe (f)" 
		or string.sub(speech, 7, 23) == "master shroud (m)" or string.sub(speech, 7, 23) == "master shroud (f)" or string.sub(speech, 7, 21) == "master robe (m)" or string.sub(speech, 7, 21) == "master robe (f)" 
		or string.sub(speech, 7, 19) == "beginner ward" or string.sub(speech, 7, 18) == "trainee ward" or string.sub(speech, 7, 17) == "novice ward" or string.sub(speech, 7, 19) == "initiate ward" or string.sub(speech, 7, 21) == "apprentice ward" or string.sub(speech, 7, 21) == "journeyman ward" or string.sub(speech, 7, 21) == "adventurer ward" or string.sub(speech, 7, 15) == "hero ward" or string.sub(speech, 7, 17) == "master ward" or string.sub(speech, 7, 18) == "paragon ward" 
		or string.sub(speech, 7, 18) == "beginner cap" or string.sub(speech, 7, 17) == "trainee cap" or string.sub(speech, 7, 16) == "novice cap" or string.sub(speech, 7, 18) == "initiate cap" or string.sub(speech, 7, 20) == "apprentice cap" or string.sub(speech, 7, 20) == "journeyman cap" or string.sub(speech, 7, 20) == "adventurer cap" or string.sub(speech, 7, 14) == "hero cap" or string.sub(speech, 7, 16) == "master cap" or string.sub(speech, 7, 17) == "paragon cap" 
		or string.sub(speech, 7, 19) == "beginner ring" or string.sub(speech, 7, 18) == "trainee ring" or string.sub(speech, 7, 17) == "novice ring" or string.sub(speech, 7, 19) == "initiate ring" or string.sub(speech, 7, 21) == "apprentice ring" or string.sub(speech, 7, 21) == "journeyman ring" or string.sub(speech, 7, 21) == "adventurer ring" or string.sub(speech, 7, 15) == "hero ring" or string.sub(speech, 7, 17) == "master ring" or string.sub(speech, 7, 18) == "paragon ring" 
		or string.sub(speech, 7, 20) == "beginner shoes" or string.sub(speech, 7, 19) == "trainee shoes" or string.sub(speech, 7, 18) == "novice shoes" or string.sub(speech, 7, 20) == "initiate shoes" or string.sub(speech, 7, 22) == "apprentice shoes" or string.sub(speech, 7, 22) == "journeyman shoes" or string.sub(speech, 7, 22) == "adventurer shoes" or string.sub(speech, 7, 16) == "hero shoes" or string.sub(speech, 7, 18) == "master shoes" or string.sub(speech, 7, 19) == "paragon shoes" then
		item = Item(string.sub(speech, 7, 24))

		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 29))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 29))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 29))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 29))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 29))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 29))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 16))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 19))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 18))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 20))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 22))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 22))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 22))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 16))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 18))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 15))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 16))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 14))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 16))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 18))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 17))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 19))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 21))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 21))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 21))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 15))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 17))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 16))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 7, 19))
		end

		if (item ~= nil) then
			number = tonumber(string.match(speech, "i buy "..string.lower(item.name).." number (%d+)"))
			
			if (number == nil) then
				number = 1
			end
			
			if (player:removeGold(item.price * number) == true) then
				player:addItem(item.yname, number)
				npc:talk(0, ""..npc.name..": I sold you "..number.." "..item.name.." for "..(item.price * number).." coins.")
			end
		end
	elseif string.sub(speech, 1, 7) == "buy my " and string.sub(speech, 8, 25) == "beginner tunic (m)" or string.sub(speech, 8, 25) == "beginner tunic (f)" or string.sub(speech, 8, 28) == "beginner leathers (m)" or string.sub(speech, 8, 28) == "beginner leathers (f)" 
		or string.sub(speech, 8, 24) == "trainee tunic (m)" or string.sub(speech, 8, 24) == "trainee tunic (f)" or string.sub(speech, 8, 27) == "trainee leathers (m)" or string.sub(speech, 8, 27) == "trainee leathers (f)" 
		or string.sub(speech, 8, 23) == "novice tunic (m)" or string.sub(speech, 8, 23) == "novice tunic (f)" or string.sub(speech, 8, 26) == "novice leathers (m)" or string.sub(speech, 8, 26) == "novice leathers (f)" 
		or string.sub(speech, 8, 25) == "initiate tunic (m)" or string.sub(speech, 8, 25) == "initiate tunic (f)" or string.sub(speech, 8, 28) == "initiate leathers (m)" or string.sub(speech, 8, 28) == "initiate leathers (f)" 
		or string.sub(speech, 8, 27) == "apprentice tunic (m)" or string.sub(speech, 8, 27) == "apprentice tunic (f)" or string.sub(speech, 8, 30) == "apprentice leathers (m)" or string.sub(speech, 8, 30) == "apprentice leathers (f)" 
		or string.sub(speech, 8, 27) == "journeyman tunic (m)" or string.sub(speech, 8, 27) == "journeyman tunic (f)" or string.sub(speech, 8, 30) == "journeyman leathers (m)" or string.sub(speech, 8, 30) == "journeyman leathers (f)" 
		or string.sub(speech, 8, 27) == "adventurer tunic (m)" or string.sub(speech, 8, 27) == "adventurer tunic (f)" or string.sub(speech, 8, 30) == "adventurer leathers (m)" or string.sub(speech, 8, 30) == "adventurer leathers (f)" 
		or string.sub(speech, 8, 21) == "hero tunic (m)" or string.sub(speech, 8, 21) == "hero tunic (f)" or string.sub(speech, 8, 24) == "hero leathers (m)" or string.sub(speech, 8, 24) == "hero leathers (f)" 
		or string.sub(speech, 8, 23) == "master tunic (m)" or string.sub(speech, 8, 23) == "master tunic (f)" or string.sub(speech, 8, 26) == "master leathers (m)" or string.sub(speech, 8, 26) == "master leathers (f)" 
		or string.sub(speech, 8, 23) == "beginner buckler" or string.sub(speech, 8, 22) == "trainee buckler" or string.sub(speech, 8, 21) == "novice buckler" or string.sub(speech, 8, 23) == "initiate buckler" or string.sub(speech, 8, 25) == "apprentice buckler" or string.sub(speech, 8, 25) == "journeyman buckler" or string.sub(speech, 8, 25) == "adventurer buckler" or string.sub(speech, 8, 19) == "hero buckler" or string.sub(speech, 8, 21) == "master buckler" or string.sub(speech, 8, 22) == "paragon buckler" 
		or string.sub(speech, 8, 24) == "beginner headband" or string.sub(speech, 8, 23) == "trainee headband" or string.sub(speech, 8, 22) == "novice headband" or string.sub(speech, 8, 24) == "initiate headband" or string.sub(speech, 8, 26) == "apprentice headband" or string.sub(speech, 8, 26) == "journeyman headband" or string.sub(speech, 8, 26) == "adventurer headband" or string.sub(speech, 8, 20) == "hero headband" or string.sub(speech, 8, 22) == "master headband" or string.sub(speech, 8, 23) == "paragon headband" 		
		or string.sub(speech, 8, 21) == "beginner glove" or string.sub(speech, 8, 20) == "trainee glove" or string.sub(speech, 8, 19) == "novice glove" or string.sub(speech, 8, 21) == "initiate glove" or string.sub(speech, 8, 23) == "apprentice glove" or string.sub(speech, 8, 23) == "journeyman glove" or string.sub(speech, 8, 23) == "adventurer glove" or string.sub(speech, 8, 17) == "hero glove" or string.sub(speech, 8, 19) == "master glove" or string.sub(speech, 8, 20) == "paragon glove" 
		or string.sub(speech, 8, 21) == "beginner boots" or string.sub(speech, 8, 20) == "trainee boots" or string.sub(speech, 8, 19) == "novice boots" or string.sub(speech, 8, 21) == "initiate boots" or string.sub(speech, 8, 23) == "apprentice boots" or string.sub(speech, 8, 23) == "journeyman boots" or string.sub(speech, 8, 23) == "adventurer boots" or string.sub(speech, 8, 17) == "hero boots" or string.sub(speech, 8, 19) == "master boots" or string.sub(speech, 8, 20) == "paragon boots" 
		or string.sub(speech, 8, 26) == "beginner shroud (m)" or string.sub(speech, 8, 26) == "beginner shroud (f)" or string.sub(speech, 8, 24) == "beginner robe (m)" or string.sub(speech, 8, 24) == "beginner robe (f)" 
		or string.sub(speech, 8, 25) == "trainee shroud (m)" or string.sub(speech, 8, 25) == "trainee shroud (f)" or string.sub(speech, 8, 23) == "trainee robe (m)" or string.sub(speech, 8, 23) == "trainee robe (f)" 
		or string.sub(speech, 8, 24) == "novice shroud (m)" or string.sub(speech, 8, 24) == "novice shroud (f)" or string.sub(speech, 8, 22) == "novice robe (m)" or string.sub(speech, 8, 22) == "novice robe (f)" 
		or string.sub(speech, 8, 26) == "initiate shroud (m)" or string.sub(speech, 8, 26) == "initiate shroud (f)" or string.sub(speech, 8, 24) == "initiate robe (m)" or string.sub(speech, 8, 24) == "initiate robe (f)" 
		or string.sub(speech, 8, 28) == "apprentice shroud (m)" or string.sub(speech, 8, 28) == "apprentice shroud (f)" or string.sub(speech, 8, 26) == "apprentice robe (m)" or string.sub(speech, 8, 26) == "apprentice robe (f)" 
		or string.sub(speech, 8, 28) == "journeyman shroud (m)" or string.sub(speech, 8, 28) == "journeyman shroud (f)" or string.sub(speech, 8, 26) == "journeyman robe (m)" or string.sub(speech, 8, 26) == "journeyman robe (f)" 
		or string.sub(speech, 8, 28) == "adventurer shroud (m)" or string.sub(speech, 8, 28) == "adventurer shroud (f)" or string.sub(speech, 8, 26) == "adventurer robe (m)" or string.sub(speech, 8, 26) == "adventurer robe (f)" 
		or string.sub(speech, 8, 22) == "hero shroud (m)" or string.sub(speech, 8, 22) == "hero shroud (f)" or string.sub(speech, 8, 20) == "hero robe (m)" or string.sub(speech, 8, 20) == "hero robe (f)" 
		or string.sub(speech, 8, 24) == "master shroud (m)" or string.sub(speech, 8, 24) == "master shroud (f)" or string.sub(speech, 8, 22) == "master robe (m)" or string.sub(speech, 8, 22) == "master robe (f)" 
		or string.sub(speech, 8, 20) == "beginner ward" or string.sub(speech, 8, 19) == "trainee ward" or string.sub(speech, 8, 18) == "novice ward" or string.sub(speech, 8, 20) == "initiate ward" or string.sub(speech, 8, 22) == "apprentice ward" or string.sub(speech, 8, 22) == "journeyman ward" or string.sub(speech, 8, 22) == "adventurer ward" or string.sub(speech, 8, 16) == "hero ward" or string.sub(speech, 8, 18) == "master ward" or string.sub(speech, 8, 19) == "paragon ward" 
		or string.sub(speech, 8, 19) == "beginner cap" or string.sub(speech, 8, 18) == "trainee cap" or string.sub(speech, 8, 17) == "novice cap" or string.sub(speech, 8, 19) == "initiate cap" or string.sub(speech, 8, 21) == "apprentice cap" or string.sub(speech, 8, 21) == "journeyman cap" or string.sub(speech, 8, 21) == "adventurer cap" or string.sub(speech, 8, 15) == "hero cap" or string.sub(speech, 8, 17) == "master cap" or string.sub(speech, 8, 18) == "paragon cap" 
		or string.sub(speech, 8, 20) == "beginner ring" or string.sub(speech, 8, 19) == "trainee ring" or string.sub(speech, 8, 18) == "novice ring" or string.sub(speech, 8, 20) == "initiate ring" or string.sub(speech, 8, 22) == "apprentice ring" or string.sub(speech, 8, 22) == "journeyman ring" or string.sub(speech, 8, 22) == "adventurer ring" or string.sub(speech, 8, 16) == "hero ring" or string.sub(speech, 8, 18) == "master ring" or string.sub(speech, 8, 19) == "paragon ring" 
		or string.sub(speech, 8, 21) == "beginner shoes" or string.sub(speech, 8, 20) == "trainee shoes" or string.sub(speech, 8, 19) == "novice shoes" or string.sub(speech, 8, 21) == "initiate shoes" or string.sub(speech, 8, 23) == "apprentice shoes" or string.sub(speech, 8, 23) == "journeyman shoes" or string.sub(speech, 8, 23) == "adventurer shoes" or string.sub(speech, 8, 17) == "hero shoes" or string.sub(speech, 8, 19) == "master shoes" or string.sub(speech, 8, 20) == "paragon shoes" then
		item = Item(string.sub(speech, 8, 25))

		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 30))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 30))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 30))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 30))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 27))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 30))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 30))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 20))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 19))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 21))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 23))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 23))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 23))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 17))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 19))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 25))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 28))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 26))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 24))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 22))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 16))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 15))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 18))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 19))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 18))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 20))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 22))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 22))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 22))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 16))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 18))
		end                                   
		                                      
		if (item == nil) then                 
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 21))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 23))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 17))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 19))
		end
		
		if (item == nil) then
			item = Item(string.sub(speech, 8, 20))
		end

		if (item ~= nil) then
			number = tonumber(string.match(speech, "buy my "..string.lower(item.name).." number (%d+)"))
			
			if (number == nil) then
				number = 1
			end
			
			if (player:removeItem(item.yname, number) == true) then
				player:addGold(item.sell * number)
				npc:talk(0, ""..npc.name..": I bought your "..number.." "..item.name.." for "..(item.sell * number).." coins.")
			end
		end
	end
end
}