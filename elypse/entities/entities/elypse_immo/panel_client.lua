include("config.lua")


function Imm_Panel_Open()
    local Frame = vgui.Create("DFrame")
        Frame:SetSize(700,700)
        Frame:MakePopup()
        Frame:Center()

    local DP1 = vgui.Create("DPanel", Frame)
    local DP2 = vgui.Create("DPanel", Frame)
    local DP3 = vgui.Create("DPanel", Frame)
    local DP4 = vgui.Create("DPanel", Frame)
    local DP5 = vgui.Create("DPanel", Frame)

    DP2:SetVisible(false)
    DP3:SetVisible(false)
    DP4:SetVisible(false)
    DP5:SetVisible(false)

    DP1:SetSize(690,665)
    DP1:SetPos(5,30)
    DP2:SetSize(690,665)
    DP2:SetPos(5,30)
    DP3:SetSize(690,665)
    DP3:SetPos(5,30)
    DP4:SetSize(690,665)
    DP4:SetPos(5,30)
    DP5:SetSize(690,665)
    DP5:SetPos(5,30)

    local B1 = vgui.Create("DButton", DP1)
    local B2 = vgui.Create("DButton", DP1)
    local B3 = vgui.Create("DButton", DP1)
    local B4 = vgui.Create("DButton", DP1)

    B1:SetSize(345,270)
    B1:SetPos(0,125)
    B1:SetText("Maison")
    B2:SetSize(345,270)
    B2:SetPos(345,125)
    B2:SetText("Appartement")
    B3:SetSize(345,270)
    B3:SetPos(0,395)
    B3:SetText("Boutique")
    B4:SetSize(345,270)
    B4:SetPos(345,395)
    B4:SetText("Hangar")

    B1.DoClick = function()
        DP1:SetVisible(false)
        DP2:SetVisible(true)
    end
    B2.DoClick = function()
        DP1:SetVisible(false)
        DP3:SetVisible(true)
    end
    B3.DoClick = function()
        DP1:SetVisible(false)
        DP4:SetVisible(true)
    end
    B4.DoClick = function()
        DP1:SetVisible(false)
        DP5:SetVisible(true)
    end

    --Bouton Back
    local BB1 = vgui.Create("DButton", DP2)
    local BB2 = vgui.Create("DButton", DP3)
    local BB3 = vgui.Create("DButton", DP4)
    local BB4 = vgui.Create("DButton", DP5)

    BB1:SetSize(50,50)
    BB1:SetPos(0,0)
    BB1:SetText("Retour")
    BB2:SetSize(50,50)
    BB2:SetPos(0,0)
    BB2:SetText("Retour")
    BB3:SetSize(50,50)
    BB3:SetPos(0,0)
    BB3:SetText("Retour")
    BB4:SetSize(50,50)
    BB4:SetPos(0,0)
    BB4:SetText("Retour")

    BB1.DoClick = function()
        DP2:SetVisible(false)
        DP1:SetVisible(true)
    end
    BB2.DoClick = function()
        DP3:SetVisible(false)
        DP1:SetVisible(true)
    end
    BB3.DoClick = function()
        DP4:SetVisible(false)
        DP1:SetVisible(true)
    end
    BB4.DoClick = function()
        DP5:SetVisible(false)
        DP1:SetVisible(true)
    end

    --Maison

    local l1 = vgui.Create( "DPanelList", DP2 )
        l1:SetSize( 690, 1000 )
        l1:SetPos( 0, 50)
        l1:SetSpacing( 5 )
        l1:EnableHorizontal( false ) -- Only vertical items
        l1:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

    local l2 = vgui.Create( "DPanelList", DP3 )
        l2:SetSize( 690, 1000 )
        l2:SetPos( 0, 50)
        l2:SetSpacing( 5 )
        l2:EnableHorizontal( false ) -- Only vertical items
        l2:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

    local l3 = vgui.Create( "DPanelList", DP4 )
        l3:SetSize( 690, 1000 )
        l3:SetPos( 0, 50)
        l3:SetSpacing( 5 )
        l3:EnableHorizontal( false ) -- Only vertical items
        l3:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

    local l4 = vgui.Create( "DPanelList", DP5 )
        l4:SetSize( 690, 1000 )
        l4:SetPos( 0, 50)
        l4:SetSpacing( 5 )
        l4:EnableHorizontal( false ) -- Only vertical items
        l4:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis


    for i, v in pairs(Immo) do
        if v["type"] == "Maison" then

            local p = vgui.Create("DPanel")
                p:SetSize(690,200)

            local PH = vgui.Create("DImage", p)
                PH:SetSize(200,200)
                PH:SetPos(0,0)
                PH:SetImage(v["image"])

            local DBB = vgui.Create("DButton", p)
                DBB:SetSize(100,50)
                DBB:SetPos(590,150)
                DBB:SetText("Acheter")

            DBB.DoClick = function()
                print("oKKK")
                net.Start( "BuyDoor" )
                net.WriteTable(v["portes"])
                net.SendToServer()
            end

            local LN = vgui.Create("DLabel", p)
                LN:SetPos(330,50)
                LN:SetText(v["nom"])
                LN:SizeToContents()

            local LD = vgui.Create("DLabel", p)
                LD:SetPos(330,70)
                LD:SetText(v["desc"])
                LD:SizeToContents()

            local LP = vgui.Create("DLabel", p)
                LP:SetPos(330,120)
                LP:SetText("Prix : "..v["prix"] .. "€")
                LP:SizeToContents()


            l1:AddItem(p)

        elseif v["type"] == "Appart" then
       

            local p = vgui.Create("DPanel")
                p:SetSize(690,200)

            local PH = vgui.Create("DImage", p)
                PH:SetSize(200,200)
                PH:SetPos(0,0)
                PH:SetImage(v["image"])

            local DBB = vgui.Create("DButton", p)
                DBB:SetSize(100,50)
                DBB:SetPos(590,150)
                DBB:SetText("Acheter")

            DBB.DoClick = function()
                print("oKKK")
                net.Start( "BuyDoor" )
                net.WriteTable(v["portes"])
                net.SendToServer()
            end

            local LN = vgui.Create("DLabel", p)
                LN:SetPos(330,50)
                LN:SetText(v["nom"])
                LN:SizeToContents()

            local LD = vgui.Create("DLabel", p)
                LD:SetPos(330,70)
                LD:SetText(v["desc"])
                LD:SizeToContents()

            local LP = vgui.Create("DLabel", p)
                LP:SetPos(330,120)
                LP:SetText("Prix : "..v["prix"] .. "€")
                LP:SizeToContents()


            l2:AddItem(p)
            
        elseif v["type"] == "Commerce" then

            local p = vgui.Create("DPanel")
                p:SetSize(690,200)

            local PH = vgui.Create("DImage", p)
                PH:SetSize(200,200)
                PH:SetPos(0,0)
                PH:SetImage(v["image"])

            local DBB = vgui.Create("DButton", p)
                DBB:SetSize(100,50)
                DBB:SetPos(590,150)
                DBB:SetText("Acheter")

            DBB.DoClick = function()
                print("oKKK")
                net.Start( "BuyDoor" )
                net.WriteString("A")
                net.WriteTable(v["portes"])
                net.SendToServer()
            end

            local LN = vgui.Create("DLabel", p)
                LN:SetPos(330,50)
                LN:SetText(v["nom"])
                LN:SizeToContents()

            local LD = vgui.Create("DLabel", p)
                LD:SetPos(330,70)
                LD:SetText(v["desc"])
                LD:SizeToContents()

            local LP = vgui.Create("DLabel", p)
                LP:SetPos(330,120)
                LP:SetText("Prix : "..v["prix"] .. "€")
                LP:SizeToContents()


            l3:AddItem(p)
            
        elseif v["type"] == "Hangar" then

            local p = vgui.Create("DPanel")
                p:SetSize(690,200)

            local PH = vgui.Create("DImage", p)
                PH:SetSize(200,200)
                PH:SetPos(0,0)
                PH:SetImage(v["image"])

            local DBB = vgui.Create("DButton", p)
                DBB:SetSize(100,50)
                DBB:SetPos(590,150)
                DBB:SetText("Acheter")

            DBB.DoClick = function()
                print("oKKK")
                net.Start( "BuyDoor" )
                net.WriteTable(v["portes"])
                net.SendToServer()
            end

            local LN = vgui.Create("DLabel", p)
                LN:SetPos(330,50)
                LN:SetText(v["nom"])
                LN:SizeToContents()

            local LD = vgui.Create("DLabel", p)
                LD:SetPos(330,70)
                LD:SetText(v["desc"])
                LD:SizeToContents()

            local LP = vgui.Create("DLabel", p)
                LP:SetPos(330,120)
                LP:SetText("Prix : "..v["prix"] .. "€")
                LP:SizeToContents()


            l4:AddItem(p)
            
        end
    end
end