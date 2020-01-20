AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("panel_client.lua")
AddCSLuaFile("config.lua")
AddCSLuaFile("panel_server.lua")

include("shared.lua")
include("config.lua")
include("panel_server.lua")

function ENT:Initialize()
	self:SetModel("models/suits/male_07_open_tie.mdl")
	self:SetHullType(HULL_HUMAN) --< NE PAS TOUCHER
	self:SetHullSizeNormal() --< NE PAS TOUCHER
	self:SetNPCState(NPC_STATE_SCRIPT) --< NE PAS TOUCHER
	self:SetSolid(SOLID_BBOX) --< NE PAS TOUCHER
	self:CapabilitiesAdd(CAP_ANIMATEDFACE) --< NE PAS TOUCHER
	self:SetUseType(SIMPLE_USE) --< NE PAS TOOUCHER
	self:DropToFloor() --< NE PAS TOUCHER
	self:SetMaxYawSpeed(90) --< NE PAS TOUCHER
end

function ENT:OnTakeDamage()
	return false
end

util.AddNetworkString( "NPCCarSP" ) --< Nom de la fonction ce trouvant dans le CL_INIT
util.AddNetworkString( "Spawncar" )

function PlaceDispo( vect ) -- len is the net message length, which we don't care about, ply is the player who sent it.
    local objm = false 
    local vect = Vector(vect[1],vect[2],vect[3])
    for k,v in pairs(ents.GetAll()) do
        if v:GetPos():Distance(vect) <= 180 then
            objm = true
        end
    end
    if objm == true then
        return false
    else
        return true
    end
end 

function ENT:AcceptInput( name, activator, caller )
	local ply = caller
	if name == "Use" and ply:IsPlayer() then --< Verifie si USE et ulisier par un joueur
		local data = util.JSONToTable( file.Read( "elypse/" .. ply:SteamID64() .. "/database.txt", "DATA") )
		local usd = false
		for k ,v in pairs(ents.FindByClass( "prop_vehicle_jeep")) do
			if v:GetNWEntity("owner") == ply then
				usd = true
			end
		end
		net.Start("NPCCarSP") --< Nom de la fonction ce trouvant dans le CL_INIT
		net.WriteTable(data["car"])
		net.WriteBool(usd)
		net.Send(caller) --< Envoie l'information au serveur
	end
end
