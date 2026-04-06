--!strict
local useLazyRef = require(script.Parent.useLazyRef)

local function useInitializedValue<T>(initFunction: () -> T): T
	local ref = useLazyRef(initFunction)
	return ref.current
end

return useInitializedValue
