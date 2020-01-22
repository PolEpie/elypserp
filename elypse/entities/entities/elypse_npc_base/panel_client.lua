include("config.lua")


function Emploi_Panel_Open(car,ending)

    local Frame = vgui.Create("DFrame")
        Frame:SetSize(900,700)
        Frame:MakePopup()
        Frame:Center()


    local l = vgui.Create( "DPanelList", Frame )
        l:SetSize( 800, 1000 )
        l:SetPos( 50, 50)
        l:SetSpacing( 5 )
        l:EnableHorizontal( false ) -- Only vertical items
        l:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

    for k,v in pairs(Jobs) do
        local vjobs = v
        if LocalPlayer():Team() != tonumber(vjobs["Id"]) then
            local p = vgui.Create("DPanel")
                p:SetSize(690,150)

            local DBB = vgui.Create("DButton", p)
                DBB:SetSize(100,50)
                DBB:SetPos(700,100)
                DBB:SetText("Rejoindre")

            local Img = vgui.Create("DImage", p)
                Img:SetPos(25,25)
                Img:SetSize(80,80)
                Img:SetImage(vjobs["Img"])

            DBB.DoClick = function()
                Frame:Close()
                net.Start("ChangeJob")
                net.WriteFloat(v["Id"])
                net.WriteString("models/suits/male_03_shirt.mdl")
                net.SendToServer()
            end

            local LN = vgui.Create("DLabel", p)
                LN:SetPos(200,20)
                LN:SetText( team:GetName(vjobs["ID"]) )
                LN:SizeToContents()

            local LP = vgui.Create("DLabel", p)
                LP:SetPos(200,50)
                LP:SetText( vjobs["Desc"] )
                LP:SizeToContents()

            l:AddItem(p)
        end  
    end
end