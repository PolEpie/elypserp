include("config.lua")

net.Receive( "BuyDoor", function( _, ply ) -- len is the net message length, which we don't care about, ply is the player who sent it.
    for k,v in pairs(net.ReadTable()) do
        Entity(v):SetNWEntity( "Owner", ply)
    end
end )
