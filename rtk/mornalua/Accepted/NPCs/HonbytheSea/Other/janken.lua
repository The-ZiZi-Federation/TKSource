
janken = {
	--[[
click = async(function(player,npc)
	
	
	if player:hasDuration("janken_choice") then
		janken.choice(player, npc)	
	else
		janken.menu(player, npc)
	end


	
	
end),

menu = function(player, npc)

	local name = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID

	local opts={}

	if npc.registry["playercount"] == 0 and player.registry["janken_player"] == 0 then table.insert(opts, "Play Janken for fun") end
	if npc.registry["playercount"] == 0 and player.registry["janken_player"] == 0 then table.insert(opts, "Play Janken for money") end
	if npc.registry["playercount"] == 1 and player.registry["janken_player"] == 0 then table.insert(opts, "Join a game") end


	if player.ID == 4 then table.insert(opts, "Reset") end
	table.insert(opts, "Disclaimer")
	table.insert(opts, "Leave")

	menu = player:menuString(name.."You can play a game of Janken for fun, or you can wager 3000 coins. Be sure to read the disclaimer!", opts)

	if menu == "Play Janken for fun" then
		if npc.registry["playercount"] == 0 then
			npc.registry["playercount"] = 1
			core.gameRegistry["player_one"] = player.ID
			player.registry["janken_player"] = 1
			broadcast(1038, "[JANKEN]: "..player.name.." wants to play Janken for fun!")
			npc.registry["timer2"] = os.time() + 60
		else
			player:popUp("Game already started!")
		end
	elseif menu == "Play Janken for money" then
		if npc.registry["playercount"] == 0 then
			if player:removeGold(3000) == true then
				npc.registry["bet_pot"] = 3000
				npc.registry["playercount"] = 1
				core.gameRegistry["player_one"] = player.ID
				player.registry["janken_player"] = 1
				broadcast(1038, "[JANKEN]: "..player.name.." wants to play Janken for a 3000 coin wager!")
				npc.registry["timer2"] = os.time() + 60
			else
				player:popUp("Try again when you have some money!")
			end
		else
			player:popUp("Game already started!")
		end
	elseif menu == "Join a game" then
		if npc.registry["playercount"] == 1 then
			if npc.registry["bet_pot"] > 0 then
				bet = player:menuString(name.."This game is for money. Is that ok?\n\n((3000 Coins))", {"Yes", "No"})
				if bet == "Yes" then
					if player:removeGold(3000) == true then
						npc.registry["timer2"] = 0
						npc.registry["bet_pot"] = npc.registry["bet_pot"] + 3000
						npc.registry["playercount"] = 2
						core.gameRegistry["player_two"] = player.ID
						player.registry["janken_player"] = 1
						broadcast(1038, "[JANKEN]: "..player.name.." has joined Janken")
						janken.play(npc)
						player:sendStatus()
						janken.choice(player)
					else
						player:popUp("Try again when you have some money!")
					end
				end
			else
				npc.registry["timer2"] = 0
				npc.registry["playercount"] = 2
				core.gameRegistry["player_two"] = player.ID
				player.registry["janken_player"] = 1
				broadcast(1038, "[JANKEN]: "..player.name.." has joined Janken")
				janken.play(npc)
				player:sendStatus()
				janken.choice(player)
			end
		else
			player:popUp("Too many players!")
		end
	elseif menu == "Play" then
		janken.play(npc)
	elseif menu == "Reset" then
		janken.reset(npc)
	elseif menu == "Disclaimer" then
		player:dialogSeq({t, name.."As soon as you select 'Start a game for money' your coins will be taken.",
							name.."If an opponent does not join the game within 60 seconds, the game will reset and your coins will be lost.",
							name.."If the result of the game is invalid, both players will have their coins returned.",
							name.."This game is for testing and entertainment purposes only.",
							name.."If any coins are lost to the game, whether due to glitch, attempted exploitation, or other error, they will not be returned.",
							name.."Again, coins lost to this game WILL NOT BE RETURNED UNDER ANY CIRCUMSTANCES.\n\nPLAY AT YOUR OWN RISK.",
							name.."Have fun!"}, 1)
	end


end,


play = function(npc)


	one = core.gameRegistry["player_one"]
	two = core.gameRegistry["player_two"]
	broadcast(1038, "[JANKEN]: "..Player(one).name.." is going to play against "..Player(two).name)
	npc.registry["janken_started"] = 1
	janken.start(npc)



end,

choice = function(player, npc)

local name = "<b>["..NPC("Carter").name.."]\n\n"
player.dialogType = 0
player.lastClick = NPC("Carter").ID
local opts2 = {}

if player.registry["janken_choice"] == 0 then table.insert(opts2, "Stone") end
if player.registry["janken_choice"] == 0 then table.insert(opts2, "Parchment") end
if player.registry["janken_choice"] == 0 then table.insert(opts2, "Blade") end


menu2 = player:menuString(name.."What is your choice?", opts2)

	if menu2 == "Stone" then
		if player:hasDuration("janken_choice") == true then
			player:msg(4, "You pick STONE!", player.ID)
			player.registry["janken_choice"] = 1
			
		else
			player:popUp("Too late!")
		end
	elseif menu2 == "Parchment" then
		if player:hasDuration("janken_choice") == true then
			player:msg(4, "You pick PARCHMENT!", player.ID)
			player.registry["janken_choice"] = 2
			
		else
			player:popUp("Too late!")
		end
	elseif menu2 == "Blade" then
		if player:hasDuration("janken_choice") == true then
			player:msg(4, "You pick BLADE!", player.ID)
			player.registry["janken_choice"] = 3
			
		else
			player:popUp("Too late!")
		end
	end

end,



reset = function(npc)

	local one = core.gameRegistry["player_one"]
	local two = core.gameRegistry["player_two"]
	if one > 0 then
		Player(one).registry["janken_player"] = 0
		Player(one).registry["janken_choice"] = 0
	end
	if two > 0 then
		Player(two).registry["janken_player"] = 0
		Player(two).registry["janken_choice"] = 0
	end
	NPC("Carter").registry["bet_pot"] = 0
	NPC("Carter").registry["player_one"] = 0
	NPC("Carter").registry["player_two"] = 0
	NPC("Carter").registry["playercount"] = 0
	NPC("Carter").registry["janken_started"] = 0
	NPC("Carter").registry["timer2"] = 0
	core.gameRegistry["player_one"] = 0
	core.gameRegistry["player_two"] = 0
end,

start = function(npc)

one = core.gameRegistry["player_one"]
two = core.gameRegistry["player_two"]

core.gameRegistry["janken_choice_timer"] = os.time() + 15
Player(one):setDuration("janken_choice", 15000)
Player(two):setDuration("janken_choice", 15000)
broadcast(1038, "[JANKEN]: "..Player(one).name.." and "..Player(two).name.." have 15 seconds to make a choice!")
janken.click(Player(one))
janken.click(Player(two))

end,

results = function()

local one = core.gameRegistry["player_one"]
local two = core.gameRegistry["player_two"] 
local p1 = Player(one).registry["janken_choice"]
local p2 = Player(two).registry["janken_choice"]

if p1 ~= 0 and p2 ~=0 then
	if p1 ~= p2 then
		if p1 == 1 and p2 == 2 then
			broadcast(1038, "[JANKEN]: "..Player(one).name.."'s STONE is covered by "..Player(two).name.."'s PARCHMENT!")
			broadcast(1038, "[JANKEN]: "..Player(two).name.." is the winner!")
			Player(one):sendAnimation(191)
			Player(two).registry["rps_wins"] = Player(two).registry["rps_wins"] + 1
			if NPC("Carter").registry["bet_pot"] == 6000 then
				Player(two):addGold(6000)
			end
		return else		
			if p1 == 1 and p2 == 3 then 
				broadcast(1038, "[JANKEN]: "..Player(one).name.."'s STONE smashes "..Player(two).name.."'s BLADE!")
				broadcast(1038, "[JANKEN]: "..Player(one).name.." is the winner!")
				Player(two):sendAnimation(342)
				Player(one).registry["rps_wins"] = Player(one).registry["rps_wins"] + 1
				if NPC("Carter").registry["bet_pot"] == 6000 then
					Player(one):addGold(6000)
				end
			return else
				if p1 == 2 and p2 == 1 then 
					broadcast(1038, "[JANKEN]: "..Player(one).name.."'s PARCHMENT covers "..Player(two).name.."'s STONE!")
					broadcast(1038, "[JANKEN]: "..Player(one).name.." is the winner!")
					Player(two):sendAnimation(191)
					Player(one).registry["rps_wins"] = Player(one).registry["rps_wins"] + 1
					if NPC("Carter").registry["bet_pot"] == 6000 then
						Player(one):addGold(6000)
					end
				return else
					if p1 == 2 and p2 == 3 then
						broadcast(1038, "[JANKEN]: "..Player(one).name.."'s PARCHMENT is cut by "..Player(two).name.."'s BLADE!")
						broadcast(1038, "[JANKEN]: "..Player(two).name.." is the winner!")
						Player(one):sendAnimation(342)
						Player(two).registry["rps_wins"] = Player(two).registry["rps_wins"] + 1
						if NPC("Carter").registry["bet_pot"] == 6000 then
							Player(two):addGold(6000)
						end
					return else
						if p1 == 3 and p2 == 1 then
							broadcast(1038, "[JANKEN]: "..Player(one).name.."'s BLADE is smashed by "..Player(two).name.."'s STONE!")
							broadcast(1038, "[JANKEN]: "..Player(two).name.." is the winner!")
							Player(one):sendAnimation(202)
							Player(two).registry["rps_wins"] = Player(two).registry["rps_wins"] + 1
							if NPC("Carter").registry["bet_pot"] == 6000 then
								Player(two):addGold(6000)
							end
						return else	
							if p1 == 3 and p2 == 2 then
								broadcast(1038, "[JANKEN]: "..Player(one).name.."'s BLADE cuts through "..Player(two).name.."'s PARCHMENT!")
								broadcast(1038, "[JANKEN]: "..Player(one).name.." is the winner!")
								Player(two):sendAnimation(342)
								Player(one).registry["rps_wins"] = Player(one).registry["rps_wins"] + 1
								if NPC("Carter").registry["bet_pot"] == 6000 then
									Player(one):addGold(6000)
								end
							end
						end
					end
				end
			end	
		end
	else
		broadcast(1038, "[JANKEN]: It's a draw!!")
		if NPC("Carter").registry["bet_pot"] == 6000 then
			Player(one):addGold(3000)
			Player(two):addGold(3000)
		end
	end
else
	broadcast(1038, "[JANKEN]: Someone didn't pick anything!")
	if NPC("Carter").registry["bet_pot"] == 6000 then
		Player(one):addGold(3000)
		Player(two):addGold(3000)
	end
end
		


end,


auto = function(npc)


local one = core.gameRegistry["player_one"]
local two = core.gameRegistry["player_two"]
if one > 0 then 
	local p1 = Player(one).registry["janken_choice"]
end
if two > 0 then
	local p2 = Player(two).registry["janken_choice"]
end
if p1 == 0 then c = "NOTHING" end
if p1 == 1 then c = "STONE" end
if p1 == 2 then c = "PARCHMENT" end
if p1 == 3 then c = "BLADE" end
if p2 == 0 then d = "NOTHING" end
if p2 == 1 then d = "STONE" end
if p2 == 2 then d = "PARCHMENT" end
if p2 == 3 then d = "BLADE" end

	if core.gameRegistry["janken_choice_timer"] > 0 and core.gameRegistry["janken_choice_timer"] < os.time() then
		broadcast(1038, "[JANKEN]: Time's up!")
		core.gameRegistry["janken_choice_timer"] = 0
		Player(one):talk(0, Player(one).name..": I choose "..c.."!")
		Player(two):talk(0, Player(two).name..": I choose "..d.."!")
--
--	if c == "STONE" then
--		Player(one):sendAnimation(202)
--	elseif c == "PARCHMENT" then
--		Player(one):sendAnimation(191)
--	elseif c == "BLADE" then
--		Player(one):sendAnimation(342)
--	end
--	if d == "STONE" then
--		Player(two):sendAnimation(202)
--	elseif d == "PARCHMENT" then
--		Player(two):sendAnimation(191)
--	elseif d == "BLADE" then
--		Player(two):sendAnimation(342)
--	end
--
		NPC("Carter").registry["timer2"] = 0
		janken.results()	
		janken.reset(npc)		
	end
	if NPC("Carter").registry["timer2"] > 0 and NPC("Carter").registry["timer2"] < os.time() then
		broadcast(1038, "[JANKEN]: Time's up! Game is reset!")
		janken.reset(npc)
	
	end
end
]]--
}