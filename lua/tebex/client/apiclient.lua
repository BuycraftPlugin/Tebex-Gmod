Msg( "// API Client 0.1            //\n" )

TebexApiClient = {}
TebexApiClient.__index = TebexApiClient

function TebexApiClient:init(plugin, timeout)
    local apiclient = {}

    apiclient.plugin = plugin

    if (timeout == nil) then
        timeout = 5000
    end

    apiclient.timeout = timeout

    setmetatable(apiclient,TebexApiClient)

    return apiclient

end

function TebexApiClient:get(endpoint, success, failure)
    print( self.plugin.config.get("baseUrl") .. endpoint )
    print( self.plugin.config.get("secret") )
    HTTP(
        {
            failed = failure,
            success = success,
            method = "GET",
            url = self.plugin.config.get("baseUrl") .. endpoint,
            headers = {
                ['X-Buycraft-Secret'] = self.plugin.config.get("secret")
            }
        }
    )
end