local drw = false
local model = ""
surface.CreateFont( "HUDName", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 30,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "HUDJob", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 700,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )





hook.Add( "HUDPaint", "ELRPHud", function()
	draw.RoundedBox( 20,30 ,ScrH()-180 , 400, 150,Color(255,255,255,50) )
	
    if drw == false then
        drawmodel()
	end
	
	if model != LocalPlayer():GetModel() then
		iconn:SetModel(LocalPlayer():GetModel())
		iconn.Entity:SetBodygroup(1, LocalPlayer():GetBodygroup(1))
		function iconn:LayoutEntity( Entity ) return end -- disables default rotation
		model = LocalPlayer():GetModel()
	end
	surface.SetFont( "HUDName" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 180, ScrH()-165 )
	surface.DrawText(LocalPlayer():GetNWString("Prenom").." ".. LocalPlayer():GetNWString("Nom") )

    surface.SetFont( "HUDJob" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 190, ScrH()-130 )
    surface.DrawText( team.GetName(LocalPlayer():Team()) )
    --
    surface.SetFont( "HUDJob" )
	surface.SetTextColor( 255, 255, 255 )
	surface.SetTextPos( 190, ScrH()-100 )
    surface.DrawText( LocalPlayer():GetNWInt("Money").." €" )
    
    draw.RoundedBox( 4,190 ,ScrH()-70 , 230, 10,Color(50,50,50,255) )
    draw.RoundedBox( 4,190 ,ScrH()-50 , 230, 10,Color(50,50,50,255) )

    draw.RoundedBox( 4,190 ,ScrH()-70 , LocalPlayer():Health()*230/100, 10,Color(255,0,0,255) )
    draw.RoundedBox( 4,190 ,ScrH()-50 , LocalPlayer():Armor()*230/100, 10,Color(5,80,252,255) )

end )

hook.Add( "HUDShouldDraw", "hide hud", function( name )
    if ( name == "CHudHealth" or name == "CHudBattery" ) then
        return false
    end
end)

function drawmodel()
    drw = true
    iconn = vgui.Create( "DModelPanel")
        iconn:SetPos(10,ScrH()-220)
        iconn:SetSize( 180, 180 )
        function iconn:LayoutEntity( Entity ) return end -- disables default rotation
		iconn:SetLookAt(Vector( 0, 0, 65 ) )
		iconn:SetCamPos( Vector( 30, 0, 65 ) )
		iconn:ParentToHUD()

    return
end
