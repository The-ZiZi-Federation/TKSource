
--Lortz Armor Smith
lortz_armor_smith = {

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
	
	menu = player:menuString(name.."I am smith, I buy and sell armor. I can also repair your equipment if it is not FUBAR.", options)	
	
	if menu == "Buy" then
		armor_smith.buy(player)
	elseif menu == "Sell" then
		armor_smith.sell(player)
	elseif menu == "Repair Item" then
		player:repairExtend()
	elseif menu == 	"Repair All" then
		player:repairAll(player, npc)
	end
end)
}