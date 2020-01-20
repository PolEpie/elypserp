include("config.lua")

function PlaceDispo( vect ) -- len is the net message length, which we don't care about, ply is the player who sent it.
    local objm = false 
    local vect = Vector(vect[1],vect[2],vect[3])
    for k,v in pairs(ents.GetAll()) do
        if v:GetPos():Distance(vect) <= 180 then
            objm = true
        end
    end
    if objm == true then
        return false
    else
        return true
    end
end 

function Spawncar(model,ply,color)

    for k,v in pairs(ents.FindByClass( "prop_vehicle_jeep")) do
        if v:GetNWEntity("owner") == ply then
            v:Remove()
        end         
    end

    dispo = {}
    for k,v in pairs(Places) do
        if PlaceDispo(v) then
            dispo[1] = v[1]
            dispo[2] = v[2]
            dispo[3] = v[3]
            dispo[4] = v[4]
            dispo[5] = v[5]
            dispo[6] = v[6]
        end
    end
    if dispo != nil then
        local CarInfos = list.Get("Vehicles")[ model ]
        local car1 = ents.Create(CarInfos.Class)
        car1:SetModel( CarInfos.Model )
        PrintTable(dispo)
        car1:SetPos(Vector(dispo[1],dispo[2],dispo[3]))
        car1:SetAngles(Angle(dispo[4],dispo[5],dispo[6]))
        car1:SetColor( color )
        car1:SetHealth(100)
        if CarInfos.KeyValues then
            for k, v in pairs( CarInfos.KeyValues ) do
                car1:SetKeyValue( k, v )
            end
        end
        car1.Hurt = false
        car1:Spawn()
        car1:Activate()
        car1:SetNWEntity("owner", ply)
    end
end

net.Receive("Spawncar", function(_,ply)
    Spawncar(net.ReadString(),ply,net.ReadColor())
end)
