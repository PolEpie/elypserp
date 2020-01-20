AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Clés"
    SWEP.Slot = 1
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
end

SWEP.WorldModel = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "ELRP"

SWEP.Primary.Delay = 0.3
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.Delay = 0.3
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:Deploy()
    if CLIENT or not IsValid(self:GetOwner()) then return true end
    self:GetOwner():DrawWorldModel(false)
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:PreDrawViewModel()
    return true
end

local TestingFunctions = {
	["func_door"] = function( self )
		return ( self:GetSaveTable().m_toggle_state == 0 )
	end,
	["func_door_rotating"] = function( self )
		return ( self:GetSaveTable().m_toggle_state == 0 )
	end,
	["prop_door_rotating"] = function( self )
		return ( self:GetSaveTable().m_eDoorState ~= 0 )
	end,
}

function SWEP:PrimaryAttack()
    local tr = self.Owner:GetEyeTrace()
    if IsValid(tr.Entity) then
        if tr.Entity:GetNWEntity( "Owner" ) == self.Owner then
            if tr.Entity:GetSaveTable().m_bLocked == false then
                local func = TestingFunctions[tr.Entity:GetClass()]
                if func then
                    if func( tr.Entity ) == false then 
                        tr.Entity:Fire( "Lock" )
                        sound.Play( "doors/door_latch1.wav", tr.Entity:GetPos(),75,200,1 )
                    end
                end
            end   
        end
	end
end

function SWEP:SecondaryAttack()
    local tr = self.Owner:GetEyeTrace()
    if IsValid(tr.Entity) then
        if tr.Entity:GetNWEntity( "Owner" ) == self.Owner then
            if tr.Entity:GetSaveTable().m_bLocked then
                local func = TestingFunctions[tr.Entity:GetClass()]
                if func then 
                    if func( tr.Entity ) == false then
                        tr.Entity:Fire( "Unlock" )
                        sound.Play( "doors/door_latch1.wav", tr.Entity:GetPos(),75,250,1 )
                    end
                end
            end
        end    
	end
end