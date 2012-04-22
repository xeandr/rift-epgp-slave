local function dumptable(table, prev, depth)
	prev = prev or ""
	depth = depth or 1
	if depth < 1 then return end
	for l, u in pairs(table) do
		if type(u) == "table" then
			print(prev .. '.' .. l)
			dumptable(u, prev .. '.' .. l)
	 	else 
	 	 	print(prev .. '.' .. l .. '=' .. tostring(u))
		end 
	end
end

xUI = {
	Color = {
		Background = {},
		Class = {
			Cleric = {},
			Mage = {},
			Rogue = {},
			Warrior = {},
		},
	},
	Font = {},
	Frame = {
		Label = {},
		Window = {},
	},

}

function xUI.Color:new(r, g, b, a)
	local o = {
		r = r or 0.7,
		g = g or 0.7,
		b = b or 0.7,
		a = a or 0,
	}

	return o
end

function xUI.Font:new(size, color)
	local o = {
		size = size or 12,
		color = color or xUI.Color:new(),
	}
	
	return o
end

function xUI.Frame:new(type, name, parent, bgcolor, align, size)
	local frame = UI.CreateFrame(type, name, parent)
	frame:SetBackgroundColor(bgcolor.r, bgcolor.g, bgcolor.b, bgcolor.a)
	frame:SetPoint("TOPLEFT", parent, "TOPLEFT")
	frame:SetWidth(size.width)
	
	return frame
end

function xUI.Frame.Label:new(text, name, parent, font, align)
	bgcolor = xUI.Color.Background


	local frame = xUI.Frame:new("Text", name, parent)
	frame:SetFontSize(font.size)
	frame:SetFontColor(font.color.r, font.color.g, font.color.b)
	frame:SetText(text)
	frame:SetWordwrap(p.wordwrap)
	
	return frame
end

function xUI.Frame.Window:new(p)
	local o = {}
	
	setmetatable(o, p)
	p.__index = p
	
	o.background = xUI.Frame:new("Frame", "background", p)
	o.title = xUI.Frame.Label:new()
	
	--o.title = xUI.Frame.Label:new(title, nil, parent)
	
	
	return o
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

xUI.Color.Background = xUI.Color:new(1, 1, 1, 0.5)
xUI.Color.Class.Cleric = xUI.Color:new(0.41, 0.65, 0.25)
xUI.Color.Class.Mage = xUI.Color:new(0.41, 0.29, 0.52)
xUI.Color.Class.Rogue = xUI.Color:new(0.89, 0.80, 0.40)
xUI.Color.Class.Warrior = xUI.Color:new(0.58, 0.17, 0.16)
