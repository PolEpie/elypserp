function InitializeDB(ply)
    print("Connect Db...")
    if file.Exists( "elypse/" .. ply:SteamID64() .. "/database.txt", "DATA" ) then
        
        local tbl = util.JSONToTable( file.Read( "elypse/" .. ply:SteamID64() .. "/database.txt", "DATA") )
        ply:SetNWString("Nom", tbl["nom"])
        ply:SetNWString("Prenom", tbl["prenom"])
        ply:SetNWInt("Bodygroup", tbl["bodygroup"])
        ply:SetNWInt("Money", tbl["money"],32)
        ply:SetNWString("Model", tbl["model"])
    else
        local t = {
            ["cars"] = {""},
            ["model"] = "",
            ["money"] = "20000",
            ["nom"] = "",
            ["prenom"] = "",
            ["bodygroup"] = "",
            ["item"] = {""},
            ["car"] = {""}
        } 
        local json = util.TableToJSON(t)
        file.CreateDir( "elypse/"..ply:SteamID64() ) -- Create the directory
        file.Write( "elypse/" .. ply:SteamID64() .. "/database.txt", json )
        net.Start("FirstPanel")
        net.Send(ply)
    end
end

function SaveDB(ply)
    local tbll = util.JSONToTable( file.Read( "elypse/" .. ply:SteamID64() .. "/database.txt", "DATA") )
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
