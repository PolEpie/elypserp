include("props.lua")
surface.CreateFont( "nb", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 20,
	weight = 1000,

} )

net.Receive("OpenInventory", function()
    local items = net.ReadTable()
    local models = {} 

    local panel = vgui.Create("DFrame")
    panel:SetSize(590,470)
    panel:Center()
    panel:MakePopup()
    panel:SetText("Inventaire")
    panel.Paint = function()
        draw.RoundedBox( 10, 0, 0, 590, 470, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 10, 15, 130, 550, 310, Color( 255, 255, 255, 255 ) )
    end

    local Scroll = vgui.Create( "DScrollPanel", panel ) -- Create the Scroll panel
    Scroll:SetSize(570,330)
    Scroll:SetPos(15,130)
    

    local List = vgui.Create( "DIconLayout", Scroll )
    List:Dock( FILL )
    List:SetBorder(5)
    List:SetSpaceY( 15 ) -- Sets the space in between the panels on the Y Axis by 5
    List:SetSpaceX( 15 ) -- Sets the space in between the panels on the X Axis by 5


    if items[1] != "" then
        for k,v in pairs(items) do
            if v != 0 then
                local obj = propslist[tonumber(k)]
                local mp = vgui.Create("DModelPanel")
                mp:SetSize(64,64)
                mp:SetModel(obj["model"])
                mp:SetAnimSpeed(0.1)
                mp:SetAmbientLight(Color(50,50,50))
                mp:SetDirectionalLight(BOX_TOP, Color(255,255,255))
                mp:SetCamPos(Vector(obj["vect1"],obj["vect2"],obj["vect3"]))
                mp:SetLookAt(Vector(0,0,0))
                mp:SetFOV(20)

                local nb = vgui.Create("DLabel",mp)
                nb:SetText(v)
                nb:SetPos(0,0)
                nb:SetFont("nb")
                nb:SizeToContents()
                nb:SetColor(Color(0,0,0,255))

                local b = vgui.Create("DButton", mp)
                b:Dock(FILL)
                b:SetText(" ")
                b.Paint = function()

                end

                b.DoClick = function()
                    local Menu = DermaMenu()
                    local sortir = Menu:AddOption( "Sortir", function()
                        --[[
                            if tonumber(v["qt"]) > 1 then
                                local pop = vgui.Create("DFrame",panel)
                                pop:MakePopup()
                                pop:SetSize(200,50)
                                pop:SetPos(700,500)
                                pop:SetTitle("")
                                pop:ShowCloseButton(false)

                                local nb = vgui.Create("DTextEntry", pop)
                                nb:SetPos(10,10)
                                nb:SetSize(100,30)
                                nb:SetText("Combien ?")
                                nb.OnGetFocus = function()
                                    nb:SetText( "" ) -- Clear the text box for user input
                                end

                                local bt = vgui.Create("DButton", pop)
                                bt:SetPos(120,10)
                                bt:SetSize(70,30)
                                bt:SetText("Ok")

                            end]]--
                            
                            --local prp = propslist[v["name"]]
                        net.Start("SpawnProps")
                        print(k)
                        net.WriteString(k)
                        net.SendToServer()
                        if v == 1 then
                            table.remove( items, k ) 
                        else
                            items[k] = tonumber(v) - 1
                        end
                        panel:Close()
                        net.Start("SaveItems")
                        net.WriteString()
                        net.SendToServer()
                    end)
                    
                    sortir:SetIcon( "icon16/arrow_left.png" )	-- Icons are in materials/icon16 folder
                    Menu:AddSpacer()
                    local vendre = Menu:AddOption( "Vendre" )
                    vendre:SetIcon( "icon16/money.png" )
                    Menu:Open()
                end
                List:Add( mp )
            end
        end

    end

    Scroll.Paint = function()
        draw.RoundedBox( 0,74, 0, 5, 100000, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,153, 0, 5, 100000, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,232, 0, 5, 100000, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,311, 0, 5, 100000, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,390, 0, 5, 100000, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,469, 0, 5, 100000, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,0, 74, 550, 5, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,0, 153, 550, 5, Color( 0, 0, 0, 255 ) )
        draw.RoundedBox( 0,0, 232, 550, 5, Color( 0, 0, 0, 255 ) )
        --draw.RoundedBox( 0,0, 311, 550, 5, Color( 0, 0, 0, 255 ) )
        local v = (math.Round(table.getn(items)/7)+1)
        if v > 4 then
            v = v - 4
            for i = 1, v do
                draw.RoundedBox( 0,0, 232+79*i, 550, 5, Color( 0, 0, 0, 255 ) )
            end     
        end
    end
end)