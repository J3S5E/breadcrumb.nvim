M = {}
local skeleton = require("breadcrumb.highlight.group")

local function get_color(hl_group, attribute)
	return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hl_group)), attribute)
end

local function highlight(group, properties, componentHighlight)
	local link = properties.link
	if link ~= nil then
		local cmd = "hi! link " .. group .. " " .. link
		vim.api.nvim_command(cmd)
	else
		local comBg = get_color(componentHighlight, "bg#")
		local comFg = get_color(componentHighlight, "fg#")
		local bg = "guibg=" .. (properties.bg == nil and comBg or properties.bg)
		local fg = "guifg=" .. (properties.fg == nil and comFg or properties.fg)
		local style = properties.style == nil and "" or "gui=" .. properties.style

		local cmd = table.concat({
			"highlight",
			group,
			bg,
			fg,
			style,
		}, " ")

		vim.api.nvim_command(cmd)
	end
end

function M.add_highlight(componentHighlight)
	local id = vim.fn.hlID(componentHighlight)
	if id <= 0 then
		return false
	end
	for group, properties in pairs(skeleton) do
		highlight(group, properties, componentHighlight)
	end
	return true
end

function M.initialise() end

return M
