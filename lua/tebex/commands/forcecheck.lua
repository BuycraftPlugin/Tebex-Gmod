Msg( "// Command tebex:forcecheck  //\n" )


Tebex.commands["forcecheck"] = function(ply, args)
    Tebex.msg("Checking for commands to be executed...");
    apiclient = TebexApiClient:init(config:get("baseUrl"), config:get("secret"))
    apiclient:get("/queue", function(response)

        if (response["meta"]["next_check"] > 0) then
            Tebex.nextCheck = response["meta"]["next_check"]
        end

        if (response["meta"]["execute_offline"] == true) then
            TebexCommandRunner.doOfflineCommands()
        end

        players = response["players"]

        for key,plr in pairs(players) do
            steamId = plr["uuid"]
            targetPlayer = player.GetBySteamID64(steamId)

            if (targetPlayer and targetPlayer:IsFullyAuthenticated()) then
                Tebex.msg("Execute commands for " .. targetPlayer:Name() .. "(ID: " .. targetPlayer:SteamID64() .. ")");
                TebexCommandRunner.doOnlineCommands(plr["id"], targetPlayer:Name(), targetPlayer:SteamID64());
            end

        end
    end)

    apiclient = nil
end