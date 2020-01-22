include("shared.lua")
include("panel_client.lua")

surface.CreateFont( "NameNPC", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 60,
	weight = 500,

} )

net.Receive( "NPCEmploi", function()
	Emploi_Panel_Open()
end )

hook.Add("PostDrawTranslucentRenderables", "NPCEmploi", function()
	for _, ent in pairs (ents.FindByClass("elypse_car_buy")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 500 then
			
			local offset = Vector( 0, 0, 85 )
			local ang = LocalPlayer():EyeAngles()
			local pos = LocalPlayer():GetPos() + offset + ang:Up()

			ang:RotateAroundAxis( ang:Forward(), 90)
			ang:RotateAroundAxis( ang:Right(), 90)

			cam.Start3D2D(ent:GetPos()+ent:GetUp()*76, ang, 0.13)
				draw.SimpleTextOutlined( "Vendeur de voiture", "NameNPC", 0, 0, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255) )
			cam.End3D2D()
		end
	end
end)




