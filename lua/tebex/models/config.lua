Msg( "// Config Library 0.1        //\n" )

TebexConfig = {}
TebexConfig.__index = TebexConfig

function TebexConfig:init()
    local config = {
        cfg = {
            buyEnabled = false,
            secret = "",
            buyCommand = "!donate",
            baseUrl = "https://plugin.buycraft.net"
        }
    }


    if (file.Exists("tebex/config.txt", "DATA") == false) then
       print ( "No config exists, create" )

        configJson = util.TableToJSON(config)

        file.Write("tebex/config.txt", configJson)

    else
        configJson = file.Read("tebex/config.txt")
        config = util.JSONToTable(configJson)

        print( "Config Loaded" )

    end

    setmetatable(config,TebexConfig)

    return config

end

function TebexConfig:get(key)
    if !IsValid(self.cfg[key]) then
        return false
    end

    return self.cfg[key]
end

function TebexConfig:set(key, value)
    self.cfg[key] = value
    configJson = util.TableToJSON(self)
    file.Write("tebex/config.txt", configJson)
end