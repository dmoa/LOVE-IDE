local C = Object:extend()

function C:new()
	self.default = {
        "#2E3440", "#3B4252", "#434C5E", "#4C566A",
        "#D8DEE9", "#E5E9F0", "#ECEFF4", "#8FBCBB",
        "#88C0D0", "#81A1C1", "#5E81AC", "#BF616A",
        "#D08770", "#EBCB8B", "#A3BE8C", "#B48EAD",
    }
end

-- to_rgb functions return all values 0->1

function C:to_rgb (hex, _a)
	local r, g, b = hex:gsub('%#', ''):match('(..)(..)(..)') -- removes possible "#" and splits values
	r = math.floor(tonumber(r, 16) / 255 * 100) / 100
	g = math.floor(tonumber(g, 16) / 255 * 100) / 100
	b = math.floor(tonumber(b, 16) / 255 * 100) / 100
	a = _a and _a / 100 or 1
	return r, g, b, a
end

function C:rrgb_to_rgb (_r, _g, _b, _a)
	r = math.floor(_r / 255 * 100) / 100
	g = math.floor(_g / 255 * 100) / 100
	b = math.floor(_b / 255 * 100) / 100
	a = _a and _a / 100 or 1

	return r, g, b, a
end

return C