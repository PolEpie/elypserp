AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if (IsValid(phys)) then
        phys:Wake()
    end

    self:SetHealth(self.BaseHealth)
end

function SSaveItems(ply, tbl)
    local tabl = {
        ["nom"] = ply:GetNWString("Nom"),
        ["prenom"] = ply:GetNWString("Prenom"),
        ["model"] = ply:GetNWString("Model"),
        ["money"] = ply:GetNWInt("Money"),
        ["bodygroup"] = ply:GetNWInt("Bodygroup"),
        ["item"] = tbl
    }
    local json = util.TableToJSON(tabl)
    file.Write( "elypse/" .. ply:SteamID64() .. "/database.txt", json )
end

function ENT:SpawnFunction(ply,tr,ClassName)
    if (!tr.Hit) then return end

    local SpawnPos = ply:GetShootPos() + ply:GetForward() * 80

    self.Owner = ply

    local ent = ents.Create(ClassName)
    ent:SetPos(SpawnPos)
    ent:Spawn()
    ent:Activate()

    return ent
end

function ENT:OnTakeDamage(damage)
    self:SetHealth(self:Health() - damage:GetDamage())

    if (self:Health() <= 0 ) then
        self:Remove()
        
    end
end

function ENT:AcceptInput( name, activator, caller )
    if name == "Use" and caller:IsPlayer() then --< Verifie si USE et ulisier par un joueur
        if caller == self:GetNWString("owner") then
            self:Remove()
            local brut = util.JSONToTable( file.Read( "elypse/" .. caller:SteamID64() .. "/database.txt", "DATA") )
            local itm = brut["item"]
            if itm[self:GetNWInt("id")] == nil then
                itm[self:GetNWInt("id")] = 1
            else
                itm[self:GetNWInt("id")] = itm[self:GetNWInt("id")] + 1
            end
            SaveItems(caller, itm)
        end
    end
  end