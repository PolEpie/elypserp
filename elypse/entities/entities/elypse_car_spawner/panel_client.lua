include("config.lua")


function CarSP_Panel_Open(car,ending)
    local ncar = ending

    local Frame = vgui.Create("DFrame")
        Frame:SetSize(700,700)
        Frame:MakePopup()
        Frame:Center()


    local l = vgui.Create( "DPanelList", Frame )
        l:SetSize( 690, 1000 )
        l:SetPos( 0, 50)
        l:SetSpacing( 5 )
        l:EnableHorizontal( false ) -- Only vertical items
        l:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis


    for k,v in pairs(car) do
        local lcar = v
        local CarInfos = list.Get("Vehicles")[ lcar["name"] ]
        local p = vgui.Create("DPanel")
            p:SetSize(690,150)

        local MD = vgui.Create("DModelPanel", p)
            local v = 500
            MD:SetSize(200,200)
            MD:SetPos(0,-15)
            MD:SetModel(CarInfos.Model)
            MD:SetAnimSpeed(0.1)
            MD:SetAmbientLight(Color(50,50,50))
            MD:SetDirectionalLight(BOX_TOP, Color(255,255,255))
            MD:SetCamPos(Vector(v,v,v))
            MD:SetLookAt(Vector(0,0,0))
            MD:SetFOV(20)

        local DBB = vgui.Create("DButton", p)
            DBB:SetSize(100,50)
            DBB:SetPos(590,100)
            DBB:SetText("Spawner")

        DBB.DoClick = function()
            print(ncar)
            if ncar == false then
                Frame:Close()
                net.Start( "Spawncar" )
                net.WriteString( lcar["name"])
                net.WriteColor(string.ToColor(lcar["color"]))
                net.SendToServer()
            else
                local pop = vgui.Create("DFrame",Frame)
                pop:SetPos(gui.MousePos())
                pop:SetSize(300,100)
                pop:Center()
                pop:SetTitle("Voiturier")

                local poplb = vgui.Create("DLabel", pop)
                poplb:SetPos(60,30)
                poplb:SetText("Voulez vous rentrer celle déja sortie ?")
                poplb:SizeToContents()

                local popbo = vgui.Create("DButton", pop)
                popbo:SetSize(50,30)
                popbo:SetPos(210,60)
                popbo:SetText("Non")
                popbo.DoClick = function()
                    pop:Close()
                end

                local popbn = vgui.Create("DButton", pop)
                popbn:SetSize(50,30)
                popbn:SetPos(50,60)
                popbn:SetText("Oui")
                popbn.DoClick = function()
                    Frame:Close()
                    net.Start( "Spawncar" )
                    net.WriteString( lcar["name"])
                    net.WriteColor(string.ToColor(lcar["color"]))
                    net.SendToServer()
                end
                


            end
        end

        local LN = vgui.Create("DLabel", p)
            LN:SetPos(330,50)
            LN:SetText( CarInfos.Name )
            LN:SizeToContents()

        l:AddItem(p)
    end
end