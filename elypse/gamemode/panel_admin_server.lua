net.Receive( "Spec", function( _, ply ) -- len is the net message length, which we don't care about, ply is the player who sent it.
    ply:Spectate( OBS_MODE_IN_EYE)
    ply:SpectateEntity( net.ReadEntity() )
    ply:StripWeapons()
    local spec = true

    hook.Add( "KeyPress", "Exit", function( ply, key )
        if ( key == IN_JUMP ) then
            if spec then
                ply:UnSpectate()
                ply:Spawn()
                spec = false
            end
            return
        end
        return
    end )
    return
end )

net.Receive( "Give", function( _, ply ) -- len is the net message length, which we don't care about, ply is the player who sent it.
    net.ReadEntity():Give(net.ReadString())
    return
end )