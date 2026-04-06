local Packages = script.Parent.Parent
local React = require(Packages.React)

local function useRefCache(): any
	local ref = React.useRef(nil :: any)
	if ref.current == nil then
		local refCache = {}
		setmetatable(refCache, {
			__index = function(_, key)
				local newRef = React.createRef()
				refCache[key] = newRef
				return newRef
			end,
			__tostring = function(self)
				local result = "{"
				for key, refValue in pairs(self) do
					result = ("%s\n\t%s -> %s"):format(result, tostring(key), tostring(refValue))
				end
				return result .. "\n}"
			end,
		})
		ref.current = refCache
	end
	return ref.current
end

return useRefCache
