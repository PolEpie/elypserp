include("config.lua")


function CarBuy_Panel_Open(car,ending)

    local strcar = {}
    
    for k,v in pairs(cars) do
        table.insert(strcar,v["Id"] )
    end

    for k,v in pairs(car) do
        table.RemoveByValue(strcar,v["name"])
    end
    PrintTable(strcar)

    local Frame = vgui.Create("DFrame")
        Frame:SetSize(900,700)
        Frame:MakePopup()
        Frame:Center()


    local l = vgui.Create( "DPanelList", Frame )
        l:SetSize( 640, 1000 )
        l:SetPos( 250, 50)
        l:SetSpacing( 5 )
        l:EnableHorizontal( false ) -- Only vertical items
        l:EnableVerticalScrollbar( true ) -- Allow scrollbar if you exceed the Y axis

    local brand = vgui.Create( "DListView", Frame )
        brand:SetSize(200,1000)
        brand:SetPos(0,25)
        brand:SetMultiSelect( true )
        brand:AddColumn( "Marque" )

    local marques = {}

    for k,v in pairs(cars) do
        if table.HasValue(strcar, v["Id"]) == true then
            if table.HasValue(marques, v["Marque"]) == false then
                table.insert(marques, v["Marque"])
            end
        end
    end

    table.sort(marques)

    for k,v in pairs(marques) do
        brand:AddLine( v , v)
    end
        
    brand.OnClickLine = function( lst, index, pnl )
        print(lst)
        l:Clear()
        for k,v in pairs(cars) do
            local vloc = v
            if table.HasValue(strcar, vloc["Id"]) then
                if index:GetValue(1) == vloc["Marque"] then
                    local CarInfos = list.Get("Vehicles")[ vloc["Id"] ]
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
                        DBB:SetPos(540,100)
                        DBB:SetText("Acheter")

                    DBB.DoClick = function()
                            local pop = vgui.Create("DFrame",Frame)
                            pop:SetPos(gui.MousePos())
                            pop:SetSize(300,100)
                            pop:Center()
                            pop:SetTitle("Achat de véhicule")

                            local poplb = vgui.Create("DLabel", pop)
                            poplb:SetPos(60,30)
                            poplb:SetText("Voulez vous vraiment faire cet achat ?")
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
                                net.Start("BuyCar")
                                net.WriteString(vloc["Id"])
                                net.SendToServer()
                            end
                    end

                    local LN = vgui.Create("DLabel", p)
                        LN:SetPos(200,20)
                        LN:SetText( CarInfos.Name )
                        LN:SizeToContents()

                    local LP = vgui.Create("DLabel", p)
                        LP:SetPos(200,50)
                        LP:SetText( "Prix : "..vloc["Prix"].."€" )
                        LP:SizeToContents()

                    l:AddItem(p)
                end
            end
        end
    end
end