local Colors = {}

Colors.default = {
    "#2E3440", "#3B4252", "#434C5E", "#4C566A",
    "#D8DEE9", "#E5E9F0", "#ECEFF4", "#8FBCBB",
	"#88C0D0", "#81A1C1", "#5E81AC",
	"#BF616A", "#D08770", "#EBCB8B", "#A3BE8C", "#B48EAD",
}

function Colors.HEXToRGB(hex, returnTable)
	if (returnTable ~= false) then
		returnTable = true
	end

	local r, g, b = hex:gsub('%#', ''):match('(..)(..)(..)')
	r = math.floor(tonumber(r, 16) / 255 * 100) / 100
	g = math.floor(tonumber(g, 16) / 255 * 100) / 100
	b = math.floor(tonumber(b, 16) / 255 * 100) / 100
	return returnTable and {r, g, b, 1} or r, g, b, 1
end

function Colors.RGBByteToFloat(r, g, b, a)
	r = math.floor(r / 255 * 100) / 100
	g = math.floor(g / 255 * 100) / 100
	b = math.floor(b / 255 * 100) / 100
	a = a and a / 100 or 1

	return r, g, b, a
end

return Colors