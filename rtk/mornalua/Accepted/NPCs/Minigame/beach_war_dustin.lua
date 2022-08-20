beach_war_dustin = {


click = async(function(player,npc)

	local name = "<b>["..npc.name.."]\n\n"
	local t = {graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}	
	player.npcGraphic = t.graphic													 
	player.npcColor = t.color														
	player.dialogType = 0
	player.lastClick = npc.ID	

	player:dialogSeq({t, name.."Welp, if you're here, you must be a loser like me.",
						name.."You can at least have some Experience, but try not to lose next time."}, 1)
	player:leveledEXP("lose_minigame")
	player:warp(1031, math.random(13,17), math.random(4, 7))
	player:sendAnimation(16)
	player:playSound(29)
	
end)}