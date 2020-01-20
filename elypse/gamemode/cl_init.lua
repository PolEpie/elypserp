include("shared.lua")
include("panel_admin_client.lua")
include("hud.lua")
include("firstpanel.lua")
include("inventaire_client.lua")

--Panel Admin fonction !panel
hook.Add( "OnPlayerChat", "MenuAdmin", function( ply, text, bTeam, bDead )
    if ( ply != LocalPlayer() ) then return end

    if ( string.lower(text) == "!panel" ) then
        PanelA_Open(ply)
        return true
	end
end )

		
concommand.Add("creationid", function(ply)
	local tr = ply:GetEyeTrace()
	if tr.Entity then
		print( tr.Entity:EntIndex() )
	end
end)



surface.CreateFont( "NamePlayer", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 32,
	weight = 100,

} )


--Nom au dessus têtes joueurs
local function DrawName( ply )
	if ( !IsValid( ply ) ) then return end
	if ( ply == LocalPlayer() ) then return end -- Don't draw a name when the player is you
	if ( !ply:Alive() ) then return end -- Check if the player is alive

	local Distance = LocalPlayer():GetPos():Distance( ply:GetPos() ) --Get the distance between you and the player

	if ( Distance < 500 ) then --If the distance is less than 1000 units, it will draw the name

		local offset = Vector( 0, 0, 85 )
		local ang = LocalPlayer():EyeAngles()
		local pos = ply:GetPos() + offset + ang:Up()

		ang:RotateAroundAxis( ang:Forward(), 90 )
		ang:RotateAroundAxis( ang:Right(), 90 )


		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 0.25 )
			draw.DrawText( ply:GetName(), "NamePlayer", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER )
		cam.End3D2D()
	end
end
hook.Add( "PostPlayerDraw", "DrawName", DrawName )