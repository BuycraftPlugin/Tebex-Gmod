if not Tebex then
	Tebex = {}
	Tebex.commands = {}

	Tebex.nextCheck = 15 * 60
	Tebex.lastCalled = os.time() - 14 * 60

	Tebex.msg = function(msg)
		print(msg)
	end

	if not Tebex.consoleCommand then Tebex.consoleCommand = game.ConsoleCommand end

	file.CreateDir( "tebex" )

	Msg( "\n///////////////////////////////\n" )
	Msg( "//      TebexGmod v 0.2      //\n" )
	Msg( "//   https://www.tebex.io/   //\n" )
	Msg( "///////////////////////////////\n" )
	Msg( "// Loading...                //\n" )

	include( "tebex/client/apiclient.lua" )
	include( "tebex/models/config.lua" )

	include( "tebex/commands/secret.lua" )
	include( "tebex/commands/info.lua" )
	include( "tebex/commands/forcecheck.lua" )

	include( "tebex/models/information.lua" )
	include( "tebex/models/commandrunner.lua" )
	include( "tebex/models/buycommand.lua" )
	Msg( "///////////////////////////////\n\n" )

	config = TebexConfig:init()

	concommand.Add("tebex", function(ply, cmd, args)

		if (args[2] == nil) then
			--Help!
			return
		end

		if (Tebex.commands[args[2]] == nil) then
			Msg( "Unknown command \"tebex:" .. args[2] .. "\"" )
			return
		end

		Tebex.commands[args[2]](ply,args);

	end)


	Tebex.doCheck = function ()
		if ((os.time() - Tebex.lastCalled) > Tebex.nextCheck) then
			Tebex.lastCalled = os.time()
			Tebex.commands["forcecheck"](nil, {":", "forcecheck"})
		end
	end


	hook.Add( "Initialize", "TebexStartUp", function()
		if (config:get("secret") == "") then
			Tebex.msg( "You have not yet defined your secret key. Use tebex:secret <secret> to define your key" )
		else
			Tebex.msg("Starting Tebex_Gmod 0.2")
			timer.Simple(5, function()
				Tebex.commands["info"](nil, {":", "info"})
			end)

		end

		timer.Create( "checker", 10, 0, Tebex.doCheck )
		timer.Start("checker")
	end )

end
