function GetItems(ply)  
    local tbl = util.JSONToTable( file.Read( "elypse/" .. ply:SteamID64() .. "/database.txt", "DATA") )
        return tbl["item"]
end

function SaveItems(ply, tbl)
    local tabl = {
        ["nom"] = ply:GetNWString("Nom"),
        ["prenom"] = ply:GetNWString("Prenom"),
        ["model"] = ply:GetNWString("Model"),
        ["money"] = ply:GetNWInt("Money"),
        ["bodygroup"] = ply:GetNWInt("Bodygroup"),
        ["item"] = tbl
    }
    local json = util.TableToJSON(tabl)
    file.Write( "elypse/" .. ply:SteamID64() .. "/database.txt", json )
end

net.Receive("SaveItems", function(_,ply)
    SaveItems(ply,net.ReadTable())
end)