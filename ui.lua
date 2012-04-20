Interface = {}
function Interface:new()
	local o = {
	
	}
	setmetatable(o, self)
	self.__index = self
	
	local settings = EPGPSlave.UI.settings
	
	o.frame = UI.CreateFrame("Frame", "EPGPSlave Main Window", EPGPSlave.UI.context)
	print("TOPLEFT")
	print(EPGPSlave.UI.context)
	print("TOPLEFT")
--	o.frame:SetPoint("TOPLEFT", EPGPSlave.UI.context, "TOPLEFT", EPGPSlave_x, EPGPSlave_y)
	o.frame:SetLayer(0)
	o.frame:SetBackgroundColor(0, 0, 0, settings.alpha)
	o.frame:SetWidth(settings.width)
	o.frame:SetVisible(EPGPSlave_visible)
	
	o.title = Interface.CreateFrame({
		type = "Text", name = "Title", parent = o.frame,
		text = settings.name, font = xUI.Font:new(16),
		alignTarget = o.frame, alignTo = "TOPCENTER", align = "TOPCENTER", x = 0, y = 0,
	})
	
	
	
	return o
end

xUI = {
	Color = {
		Cleric = {},
		Mage = {},
		Rogue = {},
		Warrior = {},
	},
	Font = {},
	Frame = {
		Label = {},
	},

}

function xUI.Color:new(r, g, b)
	local o = {
		r = r or 0.7,
		g = g or 0.7,
		b = b or 0.7,
	}
	setmetatable(o, self)
	self.__index = self
	
	return o
end
xUI.Color.Cleric = xUI.Color:new(0.41, 0.65, 0.25)
xUI.Color.Mage = xUI.Color:new(0.41, 0.29, 0.52)
xUI.Color.Rogue = xUI.Color:new(0.89, 0.80, 0.40)
xUI.Color.Warrior = xUI.Color:new(0.58, 0.17, 0.16)

function xUI.Font:new(size, color)
	local o = {
		size = size or 12,
		color = color or xUI.Color:new(),
	}
	setmetatable(o, self)
	self.__index = self
	
	return o
end

function xUI.Frame:new(type, name, parent)
	type = type or "Text"
	name = name or ""
	parent = parent or nil
	
	local frame = UI.CreateFrame(type, name, parent)
	
	setmetatable(frame, self)
	self.__index = self
	
	return frame
end

function xUI.Frame.Label:new(text, font)
	local frame = xUI.Frame:new("Text", "", nil)

	setmetatable(frame, self)
	self.__index = self
	
	return frame
end


-----------------------------------------
-- p = {
--		type, name, parent,
--		text, font,
--		layer
--		alignTarget, alignTo = "TOPCENTER", align = "TOPCENTER", x = 0, y = 0,
--	}
-----------------------------------------

function Interface.CreateFrame(p)
	p.type = p.type or "Text"
	p.name = p.name or "none"
	p.parent = p.parent or Interface.frame
	p.text = p.text or ""
	p.font = p.font or Font.Default
	p.layer = p.layer or 0
	p.wordwrap = p.wordwrap or false
	
	local frame = UI.CreateFrame(p.type, p.name, p.parent)

	frame:SetLayer(p.layer)

	if p.type == "Text" then
		frame:SetFontSize(p.font.size)
		frame:SetFontColor(p.font.color.r, p.font.color.g, p.font.color.b)
		frame:SetText(p.text)
		frame:SetWordwrap(p.wordwrap)
	elseif p.type == "Texture" then
		frame:SetTexture(p.source, p.texture)
	end

	if p.width then
		frame:SetWidth(p.width)
	end

	if p.height then
		frame:SetHeight(p.height)
	end

	if p.align then
		frame:SetPoint(p.align, p.alignTarget, p.alignTo, p.x, p.y)
	end

	if p.padTarget then
		frame:SetPoint("TOPLEFT", p.padTarget, "TOPLEFT", p.pad * -1, p.pad * -1)
		frame:SetPoint("BOTTOMRIGHT", p.padTarget, "BOTTOMRIGHT", p.pad, p.pad)
	end

	if p.border then
		frame.borderTop = UI.CreateFrame("Frame", p.name .. "_btop", frame)
		frame.borderTop:SetLayer(frame:GetLayer() + 1)
		frame.borderTop:SetBackgroundColor(p.borderR, p.borderG, p.borderB, p.borderA)
		frame.borderTop:SetPoint("TOPLEFT", frame, "TOPLEFT")
		frame.borderTop:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 0, p.border)

		frame.borderBot = UI.CreateFrame("Frame", p.name .. "_bbot", frame)
		frame.borderBot:SetLayer(frame:GetLayer() + 1)
		frame.borderBot:SetBackgroundColor(p.borderR, p.borderG, p.borderB, p.borderA)
		frame.borderBot:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, p.border * -1)
		frame.borderBot:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")

		frame.borderRt = UI.CreateFrame("Frame", p.name .. "_brt", frame)
		frame.borderRt:SetLayer(frame:GetLayer() + 1)
		frame.borderRt:SetBackgroundColor(p.borderR, p.borderG, p.borderB, p.borderA)
		frame.borderRt:SetPoint("TOPLEFT", frame, "TOPLEFT")
		frame.borderRt:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", p.border, 0)

		frame.borderLt = UI.CreateFrame("Frame", p.name .. "_blt", frame)
		frame.borderLt:SetLayer(frame:GetLayer() + 1)
		frame.borderLt:SetBackgroundColor(p.borderR, p.borderG, p.borderB, p.borderA)
		frame.borderLt:SetPoint("TOPLEFT", frame, "TOPRIGHT", p.border * -1, 0)
		frame.borderLt:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT")
	end

	if p.tooltip then
		function frame.Event:MouseIn()  SimpleMeter.UI.tooltip:Show(p.tooltip) end
		function frame.Event:MouseOut() SimpleMeter.UI.tooltip:Hide() end
	end

	return frame;
end