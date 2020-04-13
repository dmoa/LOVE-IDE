-- modified by Stan O (dmoa) from https://github.com/andrewyavors/Lua-Color-Converter

local M = {
    default = {
        "#2E3440", "#3B4252", "#434C5E", "#4C566A",
        "#D8DEE9", "#E5E9F0", "#ECEFF4", "#8FBCBB",
        "#88C0D0", "#81A1C1", "#5E81AC", "#BF616A",
        "#D08770", "#EBCB8B", "#A3BE8C", "#B48EAD",
    }
}

local function to_rgb (hex, alpha)
    hex = hex:gsub('%#', '')
	local redColor,greenColor,blueColor=hex:match('(..)(..)(..)')
	redColor, greenColor, blueColor = tonumber(redColor, 16)/255, tonumber(greenColor, 16)/255, tonumber(blueColor, 16)/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end

local function to_hex (r, g, b, alpha)
	local redColor,greenColor,blueColor=r/255, g/255, b/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end

M.to_rgb = to_rgb
M.to_hex = to_hex

return M