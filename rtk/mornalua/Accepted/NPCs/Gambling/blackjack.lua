blackjack = {
--[[
click = function(player, npc)		


	player:freeAsync()
	player.lastClick = player.ID
	blackjack.on_click(player, npc)

end,		

on_click = async(function(player, npc)


	local win_pct
	local total_players = 6

	if player.registry["Gambling_plays"] == 0 then
		win_pct = 0
	else 
		win_pct = (player.registry["Gambling_wins"]/player.registry["Gambling_plays"])*100
	end


	local name = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID				


	local options = {"Buy Chips", "Sell Chips", "Odds", "Wins/Losses"}
	local items = {6956, 6957, 6958, 6959, 6960, 6961, 6962, 6963, 6964, 6965}
	

	local id = blackjack.getPlayerNumber(npc,player)
		
		if id ~= nil then
			table.insert(options,"Bet")
			table.insert(options,"Unregister")
		elseif id == nil then
			table.insert(options,"Register")
		end

		if player.gmLevel > 0 then
		table.insert(options,"PlayerNumber")
		table.insert(options,"View Bets")
		end


	
	
	menu = player:menuString(name.."Good day to you, "..player.name.."!\nI run this Blackjack table.\n\nWhat would you like to do?", options)
	
	
	if menu == "Buy Chips" then
		player:buyExtend(name.."What chips would you like to buy?", items)
        
	elseif (menu == "Sell Chips") then
		player:sellExtend(name.."What chips would you like to buy?", items)

	elseif (menu == "Odds") then
		player:popUp("=====Odds of Winning=====\n1:49\n\nWinning Amount: Chip Value * 40")		

	elseif (menu == "Wins/Losses") then
		player:popUp("=====Gambling Statistics=====\n\nTotal Games Played: "..player.registry["Gambling_plays"].."\nTotal Gold Spent: "..player.registry["Gambling_spent"].."\n\nWins: "..player.registry["Gambling_wins"].." Losses: "..player.registry["Gambling_losses"].."\nWin "..win_pct.."%")		
	
	elseif (menu == "Bet") then
		blackjack.bet(player,npc,"Please select a chip to bet", items)
	elseif menu == "View Bets" then
		blackjack.viewBets(player,npc)


	elseif (menu == "Register") then
		
		for i=1, total_players do
			if npc.registry["blackjack_player"..i] == player.id then -- already registered
				player:popUp("You are already registered for blackjack. You are Player #"..i)
				return
			elseif npc.registry["blackjack_player"..i] == 0 then
				npc.registry["blackjack_player"..i] = player.id
				player:popUp("You are now registered for blackjack as Player #"..i.."\n\nPlease see the information section on the menu to learn how to play.")
				return
			end
			
		end


	elseif (menu == "Unregister") then
		
		for i=1, total_players do
			if npc.registry["blackjack_player"..i] == player.id then
				npc.registry["blackjack_player"..i] = 0
				player:popUp("You are no longer registered for the game.")
				return
			end
		end
	


	elseif (menu == "PlayerNumber") then
		local id = blackjack.getPlayerNumber(npc,player)
		
			if id ~= nil then
				player:talk(0,"Registered as Player #"..id)
			elseif id == nil then player:talk(0,"Not registered.")
			end

	end
end),


action = function(npc) --action based off timer
	local total_players = 6
	local dealTime = 10
	local hitTime = 20
	local hitTime2 = 30
	local hitTime3 = 40
	local flipTime = 45
	local endGameTime = 60

	local cardids = { 6901, 6902, 6903, 6904, 6905, 6906, 6907, 6908, 6909, 6910, 6911, 6912, 6913, 6914, 6915, 6916, 6917, 6918, 6919, 6920, 6921, 6922, 6923, 6924, 6925, 6926, 6927, 6928, 6929, 6930, 6931, 6932, 6933, 6934, 6935, 6936, 6937, 6938, 6939, 6940, 6941, 6942, 6943, 6944, 6945, 6946, 6947, 6948, 6949, 6950, 6951, 6952 }

	local players = npc:getObjectsInSameMap(BL_PC)
	npc.registry["timer"] = npc.registry["timer"] + 1


	

	---- Player Check Block----------------
	if #players == 0 then
		for i = 1, total_players do
			npc.registry["blackjack_player"..i] = 0
		end
		blackjack.endGame(npc)

	end


 	for i = 1, total_players do  -- If player warps or leaves, unregister player
	local id = npc.registry["blackjack_player"..i]
		if Player(id) == nil then
			npc.registry["blackjack_player"..i] = 0
		elseif Player(id).m ~= npc.m then
			npc.registry["blackjack_player"..i] = 0
		end
	end 
	-------------- End Player Check Block -----------------

	if npc.registry["timer"] == dealTime then
	blackjack.deal(player,npc, cardids)
	elseif npc.registry["timer"] == hitTime then
	npc:talk(2,"Hitting for those who asked.")
	blackjack.hit(player,npc, cardids)
	elseif npc.registry["timer"] == hitTime2 then
	npc:talk(2,"Hitting again for those who asked.")
	blackjack.hit(player,npc, cardids)
	elseif npc.registry["timer"] == hitTime3 then
	npc:talk(2,"Hitting a third time for those who asked.")
	blackjack.hit(player,npc, cardids)
	elseif npc.registry["timer"] == flipTime then
	blackjack.flipDealerCard(npc)
	elseif npc.registry["timer"] >= endGameTime then
	blackjack.endGame(npc)
	end



end,


viewBets = function(player,npc)
local total_players = 6

	for i = 1, total_players do
		if npc.registry["blackjack_player"..i] ~= 0 and npc.registry["blackjack_player"..i.."_amount"] ~= 0 then
		player:talkSelf(0,"Player: "..Player(npc.registry["blackjack_player"..i]).name.." Amount: "..npc.registry["blackjack_player"..i.."_amount"].." "..Item(npc.registry["blackjack_player"..i.."_itemid"]).name)
		
		end
		
	end






end,





bet = function(player,npc,dialog,items)

	local amount=1
	local choice=player:sell(dialog,items)
	local id = blackjack.getPlayerNumber(npc,player)
	

	if id == nil then
	return
	end

	local sell = player:getInventoryItem(choice-1)
	local sell_item = {id = sell.id, sell = sell.sell, name = sell.name, amount = sell.amount}
	if(sell_item.amount>1) then
		amount=math.abs(tonumber(math.ceil(player:input("How many chips would you like to bet?"))))

		if(amount>4000000000 or player:hasItem(sell_item.id,amount) ~= true) then player:sendMinitext("You can't do that.") return end
	else
		amount=1
	end
		
	local choice=player:menuString("Are you sure you would like to bet "..amount.." "..sell_item.name.."?", {"Yes","No"})
	if(choice=="Yes") then
		if player:hasItem(sell_item.id, amount) == true then
			if player:removeItem(sell_item.id, amount) == true then

				local selltable = {sell_item.id, sell_item.name, amount}
					npc.registry["blackjack_player"..id.."_amount"] = amount
					npc.registry["blackjack_player"..id.."_itemid"] = sell_item.id
				player:sendStatus()
				player:talk(0, "You have bet: ("..amount..") "..sell_item.name)
				
			else
				player:popUp("Where did it go?")
			end
		else
			player:popUp("Where did it go?")
		end
	end
end,


betitem = async(function(player,npc,itemid,chip_name)
	
local id = blackjack.getPlayerNumber(npc,player)
	
	if id == nil then
	return
	end

	local amount=1
			
		if player:hasItem(itemid, amount) == true then
			if player:removeItem(itemid, amount) == true then

				npc.registry["blackjack_player"..id.."_amount"] = amount
				npc.registry["blackjack_player"..id.."_itemid"] = itemid	
				player:sendStatus()
				player:talk(0, "You have bet: ("..amount..") Gambling Chip ("..chip_name..")")
			else
				player:popUp("Where did it go?")
			end
		else
			player:popUp("You do not have the bet chip.")
		end
end),


getPlayerNumber = function(npc,player)
local total_players = 6
	
		for i = 1, total_players do
			if npc.registry["blackjack_player"..i] == player.id then
				return i
			end			
		end
end,




say = function(player, npc)

local speech = string.lower(player.speech)
local items = {6956, 6957, 6958, 6959, 6960, 6961, 6962, 6963, 6964, 6965}
local cardids = { 6901, 6902, 6903, 6904, 6905, 6906, 6907, 6908, 6909, 6910, 6911, 6912, 6913, 6914, 6915, 6916, 6917, 6918, 6919, 6920, 6921, 6922, 6923, 6924, 6925, 6926, 6927, 6928, 6929, 6930, 6931, 6932, 6933, 6934, 6935, 6936, 6937, 6938, 6939, 6940, 6941, 6942, 6943, 6944, 6945, 6946, 6947, 6948, 6949, 6950, 6951, 6952 }

local itemid
local number
local chip_name



	if speech == "bet" then
		tradeTable = blackjack.bet(player,npc,"Please select a chip to bet", items)
	elseif string.len(speech) > 3 and string.sub(speech, 1, 3) == "bet" then
		if string.find(speech, "k",5) then
			chip_name = string.sub(speech, 5, 8)
			number = tonumber(string.match(speech, "%d+")) * 1000
		else -- two cases 100c and 500c 
			chip_name = string.sub(speech, 5, 7).."c"
			number = tonumber(string.match(speech, "%d+"))
		end
	
		if number < 0 then return end
		
		if number == 100 then itemid = items[1]
		elseif number == 500 then itemid = items[2]
		elseif number == 1000 then itemid = items[3]
		elseif number == 2000 then itemid = items[4]
		elseif number == 5000 then itemid = items[5]
		elseif number == 10000 then itemid = items[6]
		elseif number == 25000 then itemid = items[7]
		elseif number == 50000 then itemid = items[8]
		elseif number == 100000 then itemid = items[9]
		elseif number == 250000 then itemid = items[10]
		else return
		end

		if itemid == nil then return end

		blackjack.betitem(player,npc,itemid,chip_name)
	end


	local id = blackjack.getPlayerNumber(npc,player)
	
	if id == nil then
	return
	end


	if speech == "deal" and player.gmLevel > 0 then blackjack.deal(player, npc, cardids)
	elseif speech == "hit" and npc.registry["blackjack_player"..id.."_bust"] == 0 then
		npc.registry["blackjack_player"..id.."_hit"] = npc.registry["blackjack_player"..id.."_hit"] + 1
		player:talk(0,"Hit: "..npc.registry["blackjack_player"..id.."_hit"])
	elseif speech == "stand" and npc.registry["blackjack_bet_itemid"] ~= 0 and npc.registry["blackjack_cards_dealt"] ~= 0 then
	blackjack.stay(player,npc)

	end


end,




deal = function(player, npc, cardids)



local total_players = 6
local playerScore
local items = npc:getObjectsInSameMap(BL_ITEM)
local card_1 = 0
local card_2 = 0
local dealer_card1 = 0
local dealer_card2 = 0



npc:talk(0,"Dealing cards...")


npc.registry["blackjack_cards_left"] = 52

dealer_card1 = math.random(1,npc.registry["blackjack_cards_left"])
npc.registry["blackjack_dealer_card1id"] = cardids[dealer_card1]
table.remove(cardids, dealer_card1)

dealer_card2 = math.random(1,npc.registry["blackjack_cards_left"]-1)
npc.registry["blackjack_dealer_card2id"] = cardids[dealer_card2]
table.remove(cardids, dealer_card2)

npc:talk(0,"Dealer cards: "..Item(npc.registry["blackjack_dealer_card1id"]).name.." "..Item(npc.registry["blackjack_dealer_card2id"]).name)
npc:talk(0,"Dealer Score: "..(Item(npc.registry["blackjack_dealer_card1id"]).price + Item(npc.registry["blackjack_dealer_card2id"]).price))

---- Dealer checks if they have 21 and flops -----
if (Item(npc.registry["blackjack_dealer_card1id"]).price + Item(npc.registry["blackjack_dealer_card2id"]).price) == 21 then
	blackjack.flipDealerCard(npc)
	npc.registry["blackjack_dealer_flop"] = 1
end





npc.registry["blackjack_cards_left"] = npc.registry["blackjack_cards_left"] - 2



for i = 1, total_players do
	if npc.registry["blackjack_player"..i] ~= 0 then
		card_1 = math.random(1,npc.registry["blackjack_cards_left"])
		npc.registry["blackjack_player"..i.."_card1id"] = cardids[card_1]
		table.remove(cardids, card_1)
		
		card_2 = math.random(1,npc.registry["blackjack_cards_left"]-1)
		npc.registry["blackjack_player"..i.."_card2id"] = cardids[card_2]
		table.remove(cardids, card_2)
		Player(npc.registry["blackjack_player"..i]):msg(0,"Your Cards: "..Item(npc.registry["blackjack_player"..i.."_card1id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card2id"]).name, Player(npc.registry["blackjack_player"..i]).ID)
		
		npc.registry["blackjack_cards_left"] = npc.registry["blackjack_cards_left"] - 2
	end
end


--npc:talk(0,"cards left: "..npc.registry["blackjack_cards_left"])


npc:dropItemXY(6954, 1, npc.m, 20, 15, npc.ID) -- Dealer's cards
npc:dropItemXY(npc.registry["blackjack_dealer_card2id"], 1, npc.m, 20, 16, npc.ID) -- Dealer's cards



------- CARD PLACEMENT --------------
for i = 1, total_players do
	if npc.registry["blackjack_player"..i] ~= 0 then	
			npc:dropItemXY(npc.registry["blackjack_player"..i.."_card1id"], 1, npc.m, (20+i), 15, npc.ID) -- Player's cards
			npc:dropItemXY(npc.registry["blackjack_player"..i.."_card2id"], 1, npc.m, (20+i), 16, npc.ID) -- Player's cards	
	end
end

npc.registry["blackjack_cards_dealt"] = 52 - npc.registry["blackjack_cards_left"] 
--npc:talk(0,"cards dealt "..npc.registry["blackjack_cards_dealt"])


for i = 1, total_players do
	if npc.registry["blackjack_player"..i] ~= 0 then

		playerScore = blackjack.calcPScore(npc,i)
		Player(npc.registry["blackjack_player"..i]):msg(0,"Current Score: "..playerScore, Player(npc.registry["blackjack_player"..i]).ID)

		if playerScore > 21 then
			npc.registry["blackjack_player"..i.."_bust"] = 1
			Player(npc.registry["blackjack_player"..i]):talk(0,"BUST!")
		end
	end
end




end,


calcPScore = function(npc,i)
	
	local playerScore = (Item(npc.registry["blackjack_player"..i.."_card1id"]).price + Item(npc.registry["blackjack_player"..i.."_card2id"]).price + Item(npc.registry["blackjack_player"..i.."_card3id"]).price + Item(npc.registry["blackjack_player"..i.."_card4id"]).price + Item(npc.registry["blackjack_player"..i.."_card5id"]).price)

	local ace_detected = 0

	if playerScore > 21 then
		for j = 1, 5 do
 			if (npc.registry["blackjack_player"..i.."_card"..j.."id"] == 6901 or npc.registry["blackjack_player"..i.."_card"..j.."id"] == 6914 or npc.registry["blackjack_player"..i.."_card"..j.."id"] == 6927 or npc.registry["blackjack_player"..i.."_card"..j.."id"] == 6940) then
				ace_detected = 1
				break
			end
		end
		
		if ace_detected == 1 then
			npc.registry["blackjack_player"..i.."_score"] = npc.registry["blackjack_player"..i.."_score"] - 10
		elseif ace_detected == 0 then
			return playerScore
		end

	end

return playerScore

end,


hit = function(player,npc, cardids)


local total_players = 6
local card_3 = 0

	for i = 1, total_players do

		if npc.registry["blackjack_player"..i] ~= 0 and npc.registry["blackjack_player"..i.."_hit"] == 1 and npc.registry["blackjack_player"..i.."_hit1alreadyhit"] == 0  then
			card_3 = math.random(1,npc.registry["blackjack_cards_left"])
			npc.registry["blackjack_player"..i.."_card3id"] = cardids[card_3]
			table.remove(cardids, card_3)
			npc:dropItemXY(npc.registry["blackjack_player"..i.."_card3id"], 1, npc.m, (20+i), 17, npc.ID) -- Player's cards
			npc.registry["blackjack_cards_left"] = npc.registry["blackjack_cards_left"] - 1
			Player(npc.registry["blackjack_player"..i]):msg(0,"Your Cards: "..Item(npc.registry["blackjack_player"..i.."_card1id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card2id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card3id"]).name, Player(npc.registry["blackjack_player"..i]).ID)
			playerScore = blackjack.calcPScore(npc,i)
				if playerScore > 21 then
					npc.registry["blackjack_player"..i.."_bust"] = 1
					Player(npc.registry["blackjack_player"..i]):talk(0,"BUST!")
				end

			Player(npc.registry["blackjack_player"..i]):msg(0,"Current Score: "..playerScore, Player(npc.registry["blackjack_player"..i]).ID)
			npc.registry["blackjack_player"..i.."_hit1alreadyhit"] = 1

	
		elseif npc.registry["blackjack_player"..i] ~= 0 and npc.registry["blackjack_player"..i.."_hit"] == 2 and npc.registry["blackjack_player"..i.."_hit2alreadyhit"] == 0 then
			card_4 = math.random(1,npc.registry["blackjack_cards_left"])
			npc.registry["blackjack_player"..i.."_card4id"] = cardids[card_4]
			table.remove(cardids, card_4)
			npc:dropItemXY(npc.registry["blackjack_player"..i.."_card4id"], 1, npc.m, (20+i), 18, npc.ID) -- Player's cards
			npc.registry["blackjack_cards_left"] = npc.registry["blackjack_cards_left"] - 1
			Player(npc.registry["blackjack_player"..i]):msg(0,"Your Cards: "..Item(npc.registry["blackjack_player"..i.."_card1id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card2id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card3id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card4id"]).name, Player(npc.registry["blackjack_player"..i]).ID)
			playerScore = blackjack.calcPScore(npc,i)
				if playerScore > 21 then
					npc.registry["blackjack_player"..i.."_bust"] = 1
					Player(npc.registry["blackjack_player"..i]):talk(0,"BUST!")
				end
			Player(npc.registry["blackjack_player"..i]):msg(0,"Current Score: "..playerScore, Player(npc.registry["blackjack_player"..i]).ID)
			npc.registry["blackjack_player"..i.."_hit2alreadyhit"] = 1

		elseif npc.registry["blackjack_player"..i] ~= 0 and npc.registry["blackjack_player"..i.."_hit"] == 3 and npc.registry["blackjack_player"..i.."_hit3alreadyhit"] == 0 then
			card_5 = math.random(1,npc.registry["blackjack_cards_left"])
			npc.registry["blackjack_player"..i.."_card5id"] = cardids[card_5]
			table.remove(cardids, card_5)
			npc:dropItemXY(npc.registry["blackjack_player"..i.."_card5id"], 1, npc.m, (20+i), 19, npc.ID) -- Player's cards
			npc.registry["blackjack_cards_left"] = npc.registry["blackjack_cards_left"] - 1
			Player(npc.registry["blackjack_player"..i]):msg(0,"Your Cards: "..Item(npc.registry["blackjack_player"..i.."_card1id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card2id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card3id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card4id"]).name.."  ||  "..Item(npc.registry["blackjack_player"..i.."_card5id"]).name, Player(npc.registry["blackjack_player"..i]).ID)	
			playerScore = blackjack.calcPScore(npc,i)
				if playerScore > 21 then
					npc.registry["blackjack_player"..i.."_bust"] = 1
					Player(npc.registry["blackjack_player"..i]):talk(0,"BUST!")
				end
			Player(npc.registry["blackjack_player"..i]):msg(0,"Current Score: "..playerScore, Player(npc.registry["blackjack_player"..i]).ID)
			npc.registry["blackjack_player"..i.."_hit3alreadyhit"] = 1
		end
	end


end,



stay = function(player,npc)
local playerScore = calcPlayerScore(npc)
local dealerScore = calcDealerScore(npc)
--npc:talk(0, "Price: "..Item(npc.registry["blackjack_player_card1id"]).price)

	if playerScore > dealerScore then
		player:talk(0,"Win!")
	elseif playerScore == dealerScore then
		player:talk(0,"Tie!")
	elseif playerScore < dealerScore then
		player:talk(0,"Lose!")
	end

blackjack.flipDealerCard(player,npc)

npc:talk(0, "Dealer: "..dealerScore)
npc:talk(0, "Player: "..playerScore)

blackjack.endGame(player,npc)




end,

flipDealerCard = function(npc)

local items = npc:getObjectsInSameMap(BL_ITEM)


if #items > 0 then
	for i = 1, #items do
		if items[i].id == 6954 then
			items[i]:delete()
			npc:dropItemXY(npc.registry["blackjack_dealer_card1id"], 1, npc.m, 20, 15, npc.ID) -- Dealer's cards
		end
	end
end



dealerScore = calcDealerScore(npc)

npc:talk("score: "..dealerScore)



end,




calcDealerScore = function(npc)

local dealerScore = Item(npc.registry["blackjack_dealer_card1id"]).price + Item(npc.registry["blackjack_dealer_card2id"]).price

return dealerScore


end,







endGame = function(npc)

local total_players = 6

local items = npc:getObjectsInSameMap(BL_ITEM)
	if #items > 0 then
		for i = 1, #items do
		items[i]:delete()
		end

	end



npc.registry["blackjack_dealer_card1id"] = 0
npc.registry["blackjack_dealer_card2id"] = 0
npc.registry["blackjack_dealer_flop"] = 0
npc.registry["blackjack_cards_left"] = 0

for i = 1, total_players do
	npc.registry["blackjack_player"..i.."_card1id"] = 0
	npc.registry["blackjack_player"..i.."_card2id"] = 0
	npc.registry["blackjack_player"..i.."_card3id"] = 0
	npc.registry["blackjack_player"..i.."_card4id"] = 0
	npc.registry["blackjack_player"..i.."_card5id"] = 0
	npc.registry["blackjack_player"..i.."_hit"] = 0
	npc.registry["blackjack_player"..i.."_bust"] = 0
	npc.registry["blackjack_player"..i.."_hit1alreadyhit"] = 0
	npc.registry["blackjack_player"..i.."_hit2alreadyhit"] = 0
	npc.registry["blackjack_player"..i.."_hit3alreadyhit"] = 0
end

npc.registry["timer"] = 0

end



]]--

}



