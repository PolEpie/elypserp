AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("panel_admin_client.lua")
AddCSLuaFile("panel_admin_server.lua")
AddCSLuaFile("jobs.lua")
AddCSLuaFile("database.lua")
AddCSLuaFile("hud.lua")
AddCSLuaFile("firstpanel.lua")
AddCSLuaFile("inventaire_client.lua")
AddCSLuaFile("inventaire_server.lua")
AddCSLuaFile("props.lua")

include("shared.lua")
include("panel_admin_server.lua")
include("database.lua")
include("inventaire_server.lua")
include("props.lua")

util.AddNetworkString( "Spec" )
util.AddNetworkString( "Give" )
util.AddNetworkString( "BuyDoor" )
util.AddNetworkString( "SetParams" )
util.AddNetworkString( "FirstPanel" )
util.AddNetworkString( "OpenInventory" )
util.AddNetworkString( "SaveItems" )
util.AddNetworkString( "SpawnProps" )
util.AddNetworkString( "ChangeJob" )

function GM:PlayerSpawn(ply)
    ply:StripWeapons()
    ply:Give("weapon_physcanon")
    ply:Give("weapon_physgun")
    ply:Give("elrp_key")
end

function GM:ShowTeam(ply)
    net.Start("OpenInventory")
    net.WriteTable(GetItems(ply))
	net.Send(ply)
end

function GM:PlayerInitialSpawn(ply)
    ply:SetGravity(.80)
    ply:SetMaxHealth(100)
    ply:SetRunSpeed(500)
    ply:SetWalkSpeed(300)
    ply:SetTeam( 2 )
    InitializeDB(ply)
    ply:SetModel( ply:GetNWString("Model"))
    if ply:GetNWInt("Bodygroup") != null then
        ply:SetBodygroup(1,tonumber(ply:GetNWInt("Bodygroup")))
    end
end

function GM:PlayerDisconnected(ply)
    SaveDB(ply)
end

net.Receive( "BuyDoor", function( _, ply ) -- len is the net message length, which we don't care about, ply is the player who sent it.
    Entity(net.ReadInt(32)):SetOwner(ply)
    return
end )

net.Receive( "SetParams", function( _, ply ) -- len is the net message length, which we don't care about, ply is the player who sent it.
    local table =  net.ReadTable() 
    ply:SetNWString("Nom",table[3] )
    ply:SetNWString("Prenom",table[4] )
    ply:SetNWString("Model",table[1] )
    ply:SetNWInt("Bodygroup", table[2])
    ply:SetModel( ply:GetNWString("Model"))
    ply:SetBodygroup(1,tonumber(ply:GetNWInt("Bodygroup")))
    return
end )

net.Receive("SpawnProps", function(_,ply)
    local id = tonumber(net.ReadString())
    local obj = propslist[id]
    local barrel = ents.Create("props")
    barrel:SetModel(obj["model"])
    barrel:SetPos(ply:GetShootPos() + ply:GetForward() * 80)
    barrel:SetNWEntity("owner",ply)
    barrel:SetNWInt("id", id)
    barrel:SetHealth(obj["health"])
    barrel:Spawn()
end)

function Salaire(ply)
    ply:SetNWInt("Money",ply:GetNWInt("Money") + 800 )
end