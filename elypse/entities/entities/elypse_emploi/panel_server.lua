include("config.lua")

function BuyCar(model,ply)

    local tbll = util.JSONToTable( file.Read( "elypse/" .. ply:SteamID64() .. "/database.txt", "DATA") )
    local tb = {
        ["bodygroup"] = {""},
        ["name"] = model,
        ["color"] = "0 0 0 255"
    }
    table.insert(tbll["car"], tb)
    local tabl = {
        ["nom"] = ply:GetNWString("Nom"),
        ["prenom"] = ply:GetNWString("Prenom"),
        ["model"] = ply:GetNWString("Model"),
        ["money"] = ply:GetNWInt("Money"),
        ["bodygroup"] = ply:GetNWInt("Bodygroup"),
        ["item"] = tbll["item"],
        ["car"] = tbll["car"]
        }
    local json2 = util.TableToJSON(tabl)
    file.Write( "elypse/" .. ply:SteamID64() .. "/database.txt", json2 )

end

net.Receive("BuyCar", function(_,ply)
    BuyCar(net.ReadString(),ply)
end)
