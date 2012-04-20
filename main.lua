EPGPSlave_x = 200
EPGPSlave_y = 400
EPGPSlave_visible = true


EPGPSlave = {
	
	version = "0.0.1",
	UI = {
		settings = {
			alpha = 0.70,
			name = "HuR EPGP v" .. "0.0.1",
			width = 250,
		},
		context = nil,
		interface = nil,
	},
}

function EPGPSlave.Init(addon)
	if addon == "EPGPSlave" then
		-- Initialize the UI
		EPGPSlave.UI.context = UI.CreateContext("EPGPSlave")
		EPGPSlave.UI.interface = Interface:new()
		print(EPGPSlave.version .. " Loaded.")
	end
end



table.insert(Event.Addon.Load.End, {EPGPSlave.Init, "EPGPSlave", "Addon Loaded"})
