surface.CreateFont( "H1", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 60,
	weight = 800,

} )

surface.CreateFont( "H2", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 45,
	weight = 800,

} )

local pm = {"models/player/zelpa/female_01.mdl","models/player/zelpa/female_02.mdl","models/player/zelpa/female_03.mdl","models/player/zelpa/female_04.mdl", "models/player/zelpa/female_06.mdl","models/player/zelpa/female_07.mdl","models/player/zelpa/male_01.mdl","models/player/zelpa/male_01.mdl","models/player/zelpa/male_02.mdl","models/player/zelpa/male_03.mdl","models/player/zelpa/male_04.mdl","models/player/zelpa/male_05.mdl","models/player/zelpa/male_06.mdl","models/player/zelpa/male_07.mdl","models/player/zelpa/male_08.mdl","models/player/zelpa/male_09.mdl","models/player/zelpa/male_11.mdl"}
local cl = {0,1,2,3,4,10,11,12,13}


function FirstPanel()
    local nmpm = 1
    local nmcl = 1

	local DP1 = vgui.Create("DFrame")
    DP1:SetSize(ScrW(),ScrH())
		DP1:SetPos(0,0)
		DP1:ShowCloseButton(false)
		DP1:MakePopup()
        DP1:SetDraggable(false)
        DP1:SetTitle(" ")
        
    
    DP1.Paint = function()
        draw.RoundedBox( 0, 0, 0, DP1:GetWide(), DP1:GetTall(), Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 8, ScrW()/2-4, 150, 8, ScrH()-500, Color( 255, 255, 255, 255 ) )
    end

	local LBV = vgui.Create("DLabel", DP1)
        LBV:SetText("Bienvenue sur Elypse Roleplay")
        LBV:SetFont("H1")
		LBV:SetSize(800,70)
        LBV:SetPos(ScrW()/2- 400,50)
        
    local LBE = vgui.Create("DLabel", DP1)
        LBE:SetText("L'état civil de votre personnage Roleplay")
        LBE:SetFont("H2")
		LBE:SetSize(800,70)
        LBE:SetPos(50,180)

    local LBE2 = vgui.Create("DLabel", DP1)
        LBE2:SetText("L'apparence votre personnage Roleplay")
        LBE2:SetFont("H2")
		LBE2:SetSize(800,70)
        LBE2:SetPos(ScrW()-850,180)

    local LBN = vgui.Create("DLabel", DP1)
        LBN:SetText("Choisisez un nom")
        LBN:SetFont("H2")
		LBN:SetSize(800,70)
        LBN:SetPos(80,350)
  

    local LBP = vgui.Create("DLabel", DP1)
        LBP:SetText("Choisisez un prénom")
        LBP:SetFont("H2")
		LBP:SetSize(800,70)
        LBP:SetPos(70,600)

    local DTN = vgui.Create("DTextEntry", DP1)
        DTN:SetText( "Ex: Dupont" )
        DTN:SetFont("H2")
        DTN:SetSize(300,70)
        DTN:SetPos(450,350)
        DTN.OnGetFocus = function()
            DTN:SetText( "" ) -- Clear the text box for user input
        end

    local DTP = vgui.Create("DTextEntry", DP1)
        DTP:SetText( "Ex: Jean" )
        DTP:SetFont("H2")
        DTP:SetSize(300,70)
        DTP:SetPos(500,600)
        DTP.OnGetFocus = function()
            DTP:SetText( "" ) -- Clear the text box for user input
        end

    local icon = vgui.Create( "DModelPanel",DP1)
        icon:SetPos(1100,200)
        icon:SetSize( 600, 800 )
        icon:SetModel(pm[1] )
        icon.Entity:SetBodygroup(1,cl[1])


    local bt11 = vgui.Create("DButton", DP1)
    bt11:SetPos(1200,300)
    bt11:SetSize(25,25)
    bt11:SetText("<")
    bt11.DoClick = function()
        if nmpm == 1 then
            nmpm = table.getn(pm)
        else
            nmpm = nmpm - 1
        end
        icon:SetModel(pm[nmpm])
    end

    local bt12 = vgui.Create("DButton", DP1)
    bt12:SetPos(1570,300)
    bt12:SetSize(25,25)
    bt12:SetText(">")
    bt12.DoClick = function()
        if nmpm == table.getn(pm) then
            nmpm = 1
        else
            nmpm = nmpm + 1
        end
        icon:SetModel(pm[nmpm])
    end


    local bt21 = vgui.Create("DButton", DP1)
    bt21:SetPos(1200,500)
    bt21:SetSize(25,25)
    bt21:SetText("<")
    bt21.DoClick = function()
        if nmcl == 1 then
            nmcl = table.getn(cl)
        else
            nmcl = nmcl - 1
        end
        icon.Entity:SetBodygroup(1,cl[nmcl])
    end

    local bt22 = vgui.Create("DButton", DP1)
    bt22:SetPos(1570,500)
    bt22:SetSize(25,25)
    bt22:SetText(">")
    bt22.DoClick = function()
        if nmcl == table.getn(cl) then
            nmcl = 1
        else
            nmcl = nmcl + 1
        end
        icon.Entity:SetBodygroup(1,cl[nmcl])
    end

    local final = vgui.Create("DButton",DP1)
    final:SetPos(ScrW()/2-250,ScrH()-200)
    final:SetSize(500,100)
    final:SetText("J'ai Fini")
    final.DoClick = function()
        DP1:Close()
        net.Start("SetParams")
        net.WriteTable({icon.Entity:GetModel(),icon.Entity:GetBodygroup(1),DTN:GetValue(),DTP:GetValue()})
        net.SendToServer()
    end
    
end

net.Receive("FirstPanel", function()
    FirstPanel()
end)