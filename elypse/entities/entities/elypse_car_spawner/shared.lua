ENT.Base	    			= "base_ai"
ENT.Type	    			= "ai"
ENT.PrintName			= "NPC Voiturier"
ENT.Author				= "Alx_Dela"
ENT.Category			= "Elypse RP"
ENT.Contact				= "N/A"
ENT.Instructions			= "N/A"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.AutomaticFrameAdvance	= true

function ENT:SetAutomaticFrameAdvance(byUsingAnim)
	self.AutomaticFrameAdvance = byUsingAnim
end