Interface = {}
function Interface:new()
	local o = {
		window = {
			main = {
				background = {
					color = xUI.Color.Background,
				},
				title = {
					font = xUI.Font:new(12, xUI.Color:new())
					text = "EPGP Main Window",
				},
				parent = EPGPSlave.UI.context,
				width = 250,
			},
		},
	}
	setmetatable(o, self)
	self.__index = self
	
	local settings = EPGPSlave.UI.settings
	
	
	o.window.main = xUI.Frame.Window:new(o.window.main)
	print(o.window.main)
	
	
	--o.frame = UI.CreateFrame("Frame", "EPGPSlave Main Window", EPGPSlave.UI.context)
	--o.frame:SetPoint("TOPLEFT", EPGPSlave.UI.context, "TOPLEFT", EPGPSlave_x, EPGPSlave_y)
	--o.frame:SetLayer(0)
	--o.frame:SetBackgroundColor(0, 0, 0, settings.alpha)
	--o.frame:SetWidth(settings.width)
	--o.frame:SetVisible(EPGPSlave_visible)
	
	--o.title = Interface.CreateFrame({
	--	type = "Text", name = "Title", parent = o.frame,
	--	text = settings.name, font = xUI.Font:new(16),
	--	alignTarget = o.frame, alignTo = "TOPCENTER", align = "TOPCENTER", x = 0, y = 0,
	--})
	
	--o.more = xUI.Frame.Label:new("Testing", nil, o.window.main)
	
	return o
end