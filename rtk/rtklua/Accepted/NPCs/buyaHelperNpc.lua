buyaHelperNpc = {

    click = async(function(player, npc)
        local name = "<b>[" ..npc.name.. "]\n\n"
        local t = { graphic = convertGraphic(npc.look, "monster"), color = npc.lookColor}
        player.npcGraphic = t.graphic
        player.npcColor = t.color
        player.dialogType = 0
        player.lastClick = npc.ID

        local opts = {
            "No...where the hell am I?",
            "That's fine.",
            
        }
        if (player.registry["login_count"] <= 100)
        then
            local menu = player:menuString("Ah,you're awake!I found you stumbling naked near the south gate and bought you here. Do you remember anything?", opts)
            if (menu == "No...where the hell am I") then
                local choice = player:menuString("Well that's unfortunate, memory loss sucks! Maybe somebody around town will spark your memory.",
                        name .. "The people around here are tight-lipped, but if you do something for them they will do",
                        name .. "do something for you.", opts)
                if choice == "That's fine." then
                    player:dialogSeq({ t, name .. "That's the spirit!Now, first order of business. I've heard chatter around town that the wasps",
                                       name .. "and bees are getting out of control. Please go to the wasp cave at 112,126 and slay 10 bees for me",
                                       name .. "But first, take these!" }, 1)
                    player:addItem("buyan_garb")
                    player:addItem("trainee_sword")
                    if player.registry["shadowed_roots"] < 1 then
                        player:addLegend("Shadowed Roots" .. curT(), 202, 1)
                        player.registry["shadowed_roots"] = 1
                        player:sendStatus()
                        player.quest["bee_quest"] = 1
                        finishedQuest(player)

                    end

                end

            end
            if (player.registry["bee_quest"]) and (player:killCount(9010)) < 10 then
                player:dialogSeq({ t, "You've still got work to do, come back when you have completed the task" }, 0)

            end

            if (player.registry["bee_quest"]) and (player:killCount(9010)) >= 10 then
                player:dialogSeq({ t, "Fine job with those baby bees." }, 0)
                player:giveXP(2500)
                player.registry["bee_quest"] = player.registry["bee_quest"] - 1
                player:addLegend("Helped control the hornet population" .. curT(), 8, 1)
                player.registry["bee_quest_complete"] = 1
                finishedQuest(player)
            end
        end

    end)
}