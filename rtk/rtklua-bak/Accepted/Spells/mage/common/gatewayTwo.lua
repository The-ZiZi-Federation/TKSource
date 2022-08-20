gatewayTwo = {
    cast = function(player, question)
        local q = string.lower(player.question)
        local m
        local y

        local map = 0
        local city = ""
        local gate = ""

        if player.health <= 0 then
            player.sendMinitext("Spirits cannot use Gateway")
            return
        end
        if not player:canCast(1, 1, 0) then
            return
        end
        if player.warpOut == 0 then
            player:sendAnimation(246)
            player:sendMinitext("It doesn't work here")
            return
        end

        if player.region ~= 6 then
            player:sendMinitext("This spell only works in Cathay!")
            return
        end

        if player.region == 6 then
            -- 6: City of cathay/outlying areas
            map = 54001
            city = "Cathay"

            if string.sub(q, 1, 1) == "n" then
                x = math.random(72, 76)
                y = math.random(22, 25)
                player:sendAnimationXY(16, player.x, player.y)
                gate = "North"
            elseif string.sub(q, 1, 1) == "e" then
                x = math.random(128, 135)
                y = math.random(87, 90)
                gate = "East"
            elseif string.sub(q, 1, 1) == "w" then
                x = math.random(8, 13)
                y = math.random(88, 93)
                gate = "West"
            elseif string.sub(q, 1, 1) == "s" then
                x = math.random(73, 80)
                y = math.random(146, 142)
                gate = "South"
            end
        end

        player:sendAnimation(350, player.x, player.y)
        player:warp(map, x, y)
        player:sendMinitext("You have arrived at " .. gate .. "Gate of Cathay.")
        player:playSound(28)
        player:sendAnimation(350)
        player:sendAction(6, 20)
    end,

    requirements = function(player)
        local level = 5
        local item = {"acorn", "antler"}
        local amounts = {50,15}
        local txt = "In order to learn this spell, gimme uhhh:\n\n"
        for i = 1, #item do
            txt = txt .. "" .. amounts[i] .. " " .. Item(item[i]).name .. "\n"
        end

        local desc = "This spell is used to get around Cathay"
        return level, item, amounts, desc
    end
}