AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("panel_client.lua")
AddCSLuaFile("config.lua")

include("shared.lua")
include("config.lua")

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

util.AddNetworkString( "NPCEmploi" ) --< Nom de la fonction ce trouvant dans le CL_INIT

function ENT:AcceptInput( name, activator, caller )
	local ply = caller
	if name == "Use" and ply:IsPlayer() then --< Verifie si USE et ulisier par un joueur
		local data = util.JSONToTable( file.Read( "elypse/" .. ply:SteamID64() .. "/database.txt", "DATA") )
		net.Start("NPCEmploi") --< Nom de la fonction ce trouvant dans le CL_INIT
		net.Send(caller) --< Envoie l'information au serveur
	end
end
