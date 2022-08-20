
insert_new_warps = {
    
    
cast = function(player)

    local t = {graphic = convertGraphic(1, "monster"), color = npc.lookColor}
    player.npcGraphic = t.graphic
    player.npcColor = t.color
    player.dialogType = 0

    local opts = {"Yes", "No"}

-- menu = player:menuString("Add a new warp to the Database?\nMap: ..player.m.."  X: "..player.x.."  Y: "..player.y.."", opts)

-- if menu == "Yes" then

        
        local m, x, y = player.m, player.x, player.y
        local luasql = require "luasql.mysql"

        DBHOST = 'adm' or '127.0.0.1'
        DBNAME = 'Test'
        DBUSER = 'root'
        DBPASS = '$c72cTQ&'


        env = assert(luasql.mysql())
        db_connection = env:connect(DBNAME, DBUSER, DBPASS, DBHOST)
        query = "INSERT INTO `Warps` (`SourceMapId`, `SourceX`, `SourceY`) VALUES ("..m..", "..x..", "..y..")"
        check = db_connection:execute(query.."")
        
        player:talk(0,"Warp added at Map: "..m.."| X: "..x.."| Y: "..y)
        player:popUp("Warp added at Map: "..m.."| X: "..x.."| Y: "..y)
-- end  
        local opts = {"Yes", "No"}

-- menu = player:menuString("Add the destination warp?")

-- if menu == "Yes" then

        m = read("Enter the Destination Map ID: ")
        x = read("Enter the Destination X: ")
        y = read("Enter the Destination Y: ")


        query = "INSERT INTO `Warps` (`DestinationMapId`, `DestinationX`, `DestinationY`) VALUES ("..m..", "..x..", "..y..")"
        check = db_connection:execute(query.."")
        db_connection:close()
        env:close()

        player:talk(0,"Warp added at Destination: "..m.."| X: "..x.."| Y: "..y)
        player:popUp("Warp added at Destination: "..m.."| X: "..x.."| Y: "..y)
        
-- end
end
}