	
f4npc = {

click = async(function(player, npc)

	local header, PKstatus = "<b>[Extended Menu]\n\n", ""
	local cape = player:getEquippedItem(EQ_MANTLE)
	player.dialogType = 2
	
	if player.PK == 0 then PKstatus = "ON" else PKstatus = "OFF" end
	local opts = {"Vending Menu", "Switch PK Status to '"..PKstatus.."'", "Exit"}
	
	menu = player:menuString(header.."Character's extra menu..", opts)
	
	if menu ~= nil then
		if menu == "Vending Menu" then
			local att = {"vending_ransel", "vending_cart", "vending_troly"}
			if cape == nil then
				anim(player)
				player:popUp("You need to equip vending ransel")
			return else
				for i = 1, #att do
					if not cape.yname == att[i] then
						anim(player)
						player:popUp("You need to equip vending ransel")
					return else
						player:freeAsync()
						vending_menu.click(player, npc)
					end
				end
			end

		elseif menu == "Switch PK Status to '"..PKstatus.."'" then
			if player.PK == 0 then
				player.PK = 1
				player:sendMinitext("PK Status : ON")
			else
				player.PK = 0
				player:sendMinitext("PK Status : OFF")
			end
			player:refresh()
		end
	end
end)
}