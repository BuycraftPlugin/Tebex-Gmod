Msg( "// Buy Command v0.1          //\n" )

hook.Add( "PlayerSay", "TebexBuyCommand", function( ply, text, public )
    if ( string.lower( text ) == config:get("buyCommand") ) then
        ply:ChatPrint( "To buy packages from our webstore, please visit: " .. TebexInformation.domain )
        ply:SendLua("gui.OpenURL( '" .. TebexInformation.domain .. "' )")
        return ""
    end
end )
