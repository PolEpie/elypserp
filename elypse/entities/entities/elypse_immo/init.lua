AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("panel_client.lua")
AddCSLuaFile("config.lua")


include("shared.lua")
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

util.AddNetworkString( "NPCImm" ) --< Nom de la fonction ce trouvant dans le CL_INIT
util.AddNetworkString( "BuyDoor" )

function ENT:AcceptInput( name, activator, caller )
  if name == "Use" and caller:IsPlayer() then --< Verifie si USE et ulisier par un joueur
	net.Start("NPCImm") --< Nom de la fonction ce trouvant dans le CL_INIT
	net.Send(caller) --< Envoie l'information au serveur
  end
end
