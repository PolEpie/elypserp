--Liste des paramètres
--Nom de la commande + numero du popup
local CP1 = {"Ban1", "Deban2", "Kick3", "Tuer3", "Résuciter3", "Give4", "Ajouter de l'argent4", "Retier de l'argent4", "Changer de métier", "Spec3", "Teleporter vers soi3", "Se teleporter vers3", "Ramener avant le tp3","Freeze3", "Defreeze3", "Modifier la vie4", "Modifier l'armure4", "God3", "Ungod3", "Ragdoll3"}

--Popup 1 = player + reason + timer
function Popup1(ply)
    local nb = ply
    local popup = vgui.Create("DFrame")
        popup:SetSize(300, 350)
        popup:Center() 
        popup:MakePopup()
        popup:SetTitle("Outil d'Administration")

    local lp = vgui.Create("DLabel", popup)
        lp:SetPos(96,40)
        lp:SetText("Selectionner un joueur")
        lp:SizeToContents()

    local cb1 = vgui.Create("DComboBox", popup)
        cb1:SetSize(280, 30)
        cb1:SetPos(10, 70)
        cb1:SetValue("Joueurs")
        for i, Value in pairs( player.GetAll() ) do
            cb1:AddChoice(Entity(i):GetName())
        end

    local lr = vgui.Create("DLabel", popup)
        lr:SetPos(106,120)
        lr:SetText("Donner une raison")
        lr:SizeToContents()

    local txt1 = vgui.Create("DTextEntry", popup)
        txt1:SetSize(280, 30)
        txt1:SetPos(10, 150)

    local lt = vgui.Create("DLabel", popup)
        lt:SetPos(106,200)
        lt:SetText("Selectionner le temps")
        lt:SizeToContents()

    local txt2 = vgui.Create("DTextEntry", popup)
        txt2:SetSize(150, 30)
        txt2:SetPos(10, 235)
        txt2:SetDisabled(true)
        txt2:SetNumeric(true)

    local time = 0
    
    local cb2 = vgui.Create("DComboBox", popup)
        cb2:SetSize(110, 30)
        cb2:SetPos(180, 235)
        cb2:SetValue("Permanant")
        cb2:AddChoice("Permanant")
        cb2:AddChoice("Mois")
        cb2:AddChoice("Semaine")
        cb2:AddChoice("Jour")
        cb2:AddChoice("Heure")
        cb2:AddChoice("Minute")
        cb2.OnSelect = function(_,_,value)
            if value == "Permanant" then
                txt2:SetDisabled(true)
            else
                txt2:SetDisabled(false)
            end
        end
    local ok = vgui.Create("DButton", popup)
        ok:SetSize(280,30)
        ok:SetPos(10,300)
        ok:SetText("C'est bon!")
        ok.DoClick = function()
            if cb2:GetSelected() == "Mois" then
                time = txt2:GetValue() * 43800
            elseif cb2:GetSelected() == "Semaine" then
                time = txt2:GetValue() * 10080
            elseif cb2:GetSelected() == "Jour" then
                time = txt2:GetValue() * 1440
            elseif cb2:GetSelected() == "Heure" then
                time = txt2:GetValue() * 60
            elseif cb2:GetSelected() == "Minute" then
                time = txt2:GetValue()
            end
            Player(nb):ConCommand("ulx ban " .. cb1:GetValue() .. " ".. time .. " " .. txt1:GetValue())
            popup:Close()
        end
    return true
end


--Popup 2 = SteamID
function Popup2(ply)
    local nb = ply
    local popup = vgui.Create("DFrame")
        popup:SetSize(300, 170)
        popup:Center() 
        popup:MakePopup()
        popup:SetTitle("Outil d'Administration")

    local lp = vgui.Create("DLabel", popup)
        lp:SetPos(96,40)
        lp:SetText("Entrer un SteamID")
        lp:SizeToContents()
        print(lp:GetSize())

    local txt1 = vgui.Create("DTextEntry", popup)
        txt1:SetSize(280, 30)
        txt1:SetPos(10, 70)   

    local ok = vgui.Create("DButton", popup)
        ok:SetSize(280,30)
        ok:SetPos(10,120)
        ok:SetText("C'est bon!")
        ok.DoClick = function()
            Player(nb):ConCommand("ulx unban ".. txt1:GetValue())
            popup:Close()
        end
    return true
end

--Popup 3 = Player
function Popup3(ply,command)
    local nb = ply
    local popup = vgui.Create("DFrame")
        popup:SetSize(300, 170)
        popup:Center() 
        popup:MakePopup()
        popup:SetTitle("Outil d'Administration")

    local lp = vgui.Create("DLabel", popup)
        lp:SetPos(96,40)
        lp:SetText("Selectionner un joueur")
        lp:SizeToContents()

    local cb1 = vgui.Create("DComboBox", popup)
        cb1:SetSize(280, 30)
        cb1:SetPos(10, 70)
        cb1:SetValue("Joueurs")
        for i, Value in pairs( player.GetAll() ) do
            cb1:AddChoice(Entity(i):GetName())
        end 

    local ok = vgui.Create("DButton", popup)
        ok:SetSize(280,30)
        ok:SetPos(10,120)
        ok:SetText("C'est bon!")
        ok.DoClick = function()
            if command == "Kick" then
                Player(nb):ConCommand("ulx kick " .. cb1:GetSelected() )
            elseif command == "Tuer" then
                Player(nb):ConCommand("kill " .. cb1:GetSelected() )
            elseif command == "Spec" then
                net.Start( "Spec" )
                net.WriteEntity(Entity(cb1:GetSelectedID()))
                net.SendToServer()
            elseif command == "Teleporter vers soi" then
                Player(nb):ConCommand("ulx bring " .. cb1:GetSelected() )
            elseif command == "Se teleporter vers" then
                Player(nb):ConCommand("ulx goto " .. cb1:GetSelected() )
            elseif command == "Freeze" then
                Player(nb):ConCommand("ulx freeze " .. cb1:GetSelected() )
            elseif command == "Defreeze" then
                Player(nb):ConCommand("ulx unfreeze " .. cb1:GetSelected() )
            elseif command == "Ramener avant le tp" then
                Player(nb):ConCommand("ulx return " .. cb1:GetSelected() )
            elseif command == "God" then
                Player(nb):ConCommand("ulx god " .. cb1:GetSelected() )
            elseif command == "Ungod" then
                Player(nb):ConCommand("ulx ungod " .. cb1:GetSelected() )
            elseif command == "Ragdoll" then
                Player(nb):ConCommand("ulx ragdoll " .. cb1:GetSelected() )
            end
            popup:Close()
        end
    return true
end

--Popup 4 = Player + txt
function Popup4(ply,command)
    local nb = ply
    local popup = vgui.Create("DFrame")
        popup:SetSize(300, 230)
        popup:Center() 
        popup:MakePopup()
        popup:SetTitle("Outil d'Administration")

    local lp = vgui.Create("DLabel", popup)
        lp:SetPos(96,40)
        lp:SetText("Selectionner un joueur")
        lp:SizeToContents()

    local cb1 = vgui.Create("DComboBox", popup)
        cb1:SetSize(280, 30)
        cb1:SetPos(10, 70)
        cb1:SetValue("Joueurs")
        for i, Value in pairs( player.GetAll() ) do
            cb1:AddChoice(Entity(i):GetName())
        end 

    local lp = vgui.Create("DLabel", popup)

    local txt1 = vgui.Create("DTextEntry", popup)
        txt1:SetSize(280, 30)
        txt1:SetPos(10, 140) 

    if command == "Give" then
        lp:SetPos(115,110)
        lp:SetText("Entrer un Item")
    elseif command == "Ajouter de l'argent" then
        lp:SetPos(115,110)
        lp:SetText("Combien Ajouter ?")
        txt1:SetNumeric(true)
    elseif command == "Retirer de l'argent" then
        lp:SetPos(115,110)
        lp:SetText("Combien Retirer ?")
        txt1:SetNumeric(true)
    elseif command == "Modifier la vie" then
        lp:SetPos(115,110)
        lp:SetText("Entrer la vie souhaité")
        txt1:SetNumeric(true)
    elseif command == "Modifier l'armure" then
        lp:SetPos(115,110)
        lp:SetText("Entrer l'armure souhaité")
        txt1:SetNumeric(true)
    end

        lp:SizeToContents()

    local ok = vgui.Create("DButton", popup)
        ok:SetSize(280,30)
        ok:SetPos(10,190)
        ok:SetText("C'est bon!")
        ok.DoClick = function()
            if command == "Give" then
                net.Start( "Give" )
                net.WriteEntity(Entity(cb1:GetSelectedID()))
                net.WriteString(txt1:GetValue())
                net.SendToServer()
            elseif command == "Ajouter de l'argent" then
                return
            elseif command == "Retirer de l'argent" then
                return
            elseif command == "Modifier la vie" then
                Player(nb):ConCommand("ulx hp " .. cb1:GetSelected() .. " " .. txt1:GetValue() )
            elseif command == "Modifier l'armure" then
                Player(nb):ConCommand("ulx armor " .. cb1:GetSelected() .. " " .. txt1:GetValue() )
            elseif command == "Ajouter de l'argent" then
                Player(cb1:GetSelected()):SetNWInt("Money",txt1:GetValue())
            end
            popup:Close()
        end
    return true
end



--VGUI Du panel
function PanelA_Open(ply)
    local player = ply:UserID()
    if ply:IsSuperAdmin() then
        local FP = vgui.Create("DFrame")
            FP:SetSize(400, 500)
            FP:Center()
            FP:MakePopup()
            FP:SetDraggable(true)
            FP:SetTitle("Outil D'administration")



        --Menu de subdivisoon des outil



        local Menu = vgui.Create( "DPropertySheet", FP )
            Menu:Dock(FILL)

        local p1 = vgui.Create("DPanel", Menu)
        local p2 = vgui.Create("DPanel", Menu)
        local p3 = vgui.Create("DPanel", Menu)

        Menu:AddSheet("Joueurs", p1, "icon16/user.png" )
        Menu:AddSheet("Serveur", p2, "icon16/server.png" )
        Menu:AddSheet("Serveur", p3, "icon16/server.png" )

        local sp1 = vgui.Create("DScrollPanel", p1)
            sp1:Dock(FILL)


        --Panel Joueurs


        for i, Value in pairs( CP1 ) do
            local bp1 = vgui.Create("DButton", sp1)
                bp1:SetSize(360,30)
                bp1:SetPos(0,(i-1)*30)
                bp1:SetText(string.sub(CP1[i],1,-2))
                bp1.DoClick = function()
                    if tonumber(string.sub(CP1[i],-1)) == 1 then
                        Popup1(player)
                    elseif tonumber(string.sub(CP1[i],-1)) == 2 then
                        Popup2(player)
                    elseif tonumber(string.sub(CP1[i],-1)) == 3 then
                        Popup3(player, string.sub(CP1[i],1,-2))
                    elseif tonumber(string.sub(CP1[i],-1)) == 4 then
                        Popup4(player, string.sub(CP1[i],1,-2))
                    end
                end         
        end
        
        return true

    else
        return
    end
end