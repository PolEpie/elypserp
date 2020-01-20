include("shared.lua")
include("panel_client.lua")

surface.CreateFont( "NameNPC", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 40,
	weight = 500,

} )

net.Receive( "NPCImm", function()
	Imm_Panel_Open(LocalPlayer())
end )

hook.Add("PostDrawOpaqueRenderables", "NPCImm", function()
	for _, ent in pairs (ents.FindByClass("elypse_immo")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
			
			local offset = Vector( 0, 0, 85 )
			local ang = LocalPlayer():EyeAngles()
			local pos = LocalPlayer():GetPos() + offset + ang:Up()

			ang:RotateAroundAxis( ang:Forward(), 90)
			ang:RotateAroundAxis( ang:Right(), 90)

			cam.Start3D2D(ent:GetPos()+ent:GetUp()*76, ang, 0.10)
				draw.SimpleTextOutlined( "Agent Immobilier", "NameNPC", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0, Color(255,255,255,255) )
			cam.End3D2D()
		end
	end
end)




