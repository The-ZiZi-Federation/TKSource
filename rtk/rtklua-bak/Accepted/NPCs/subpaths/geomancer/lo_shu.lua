NpcSubpathGeomancerLoShuNpc = {
	click = async(function(player, npc)
		local t = {
			graphic = convertGraphic(npc.look, "monster"),
			color = npc.lookColor
		}
		player.npcGraphic = t.graphic
		player.npcColor = t.color
		player.dialogType = 0
		player.lastClick = npc.ID

		local opts = {"Buy", "Sell", "Deposit Item", "Withdraw Item"}

		if player.money > 0 then
			table.insert(opts, "Deposit Money")
		end

		if player.bankMoney > 0 then
			table.insert(opts, "Withdraw Money")
		end

		table.insert(opts, "War Paint")
		table.insert(opts, "Observe")
		table.insert(opts, "Reincarnate")

		local buysellopts = {"limestone", "obsidian", "book"}

		local menu = player:menuString("Hello! How can I help you today?", opts)

		if menu == "Buy" then
			player:buyExtend(
				"I think I can accomodate some of the things you need. What would you like?",
				buysellopts
			)
		elseif menu == "Sell" then
			player:sellExtend(
				"What are you willing to sell today?",
				buysellopts
			)
		elseif menu == "Deposit Money" then
			player:bankAddMoney(npc)
		elseif menu == "Withdraw Money" then
			player:bankWithdrawMoney(npc)
		elseif menu == "Deposit Item" then
			player:showBankDeposit(npc)
		elseif menu == "Withdraw Item" then
			player:showBankWithdraw(npc)
		elseif menu == "War Paint" then
			ArenaMasterNpc.warPaint(player, npc)
		elseif menu == "Reincarnate" then
			general_npc_funcs.reincarnate(player, npc)
		elseif menu == "Observe" then
			general_npc_funcs.observe(player, npc)
		end
	end),

	move = function(npc)
		npc.side = math.random(0, 3)
		npc:sendSide()
	end,

	buyItems = function()
		local buyItems = {"limestone", "obsidian", "book"}
		return buyItems
	end,

	sellItems = function()
		return NpcSubpathGeomancerLoShuNpc.buyItems()
	end
}
