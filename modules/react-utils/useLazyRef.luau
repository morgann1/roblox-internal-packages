--!strict
local Packages = script.Parent.Parent
local React = require(Packages.React)

type ObjectRef<T> = { current: T }

local function useLazyRef<T>(initFunction: () -> T): ObjectRef<T>
	local ref = React.useRef(nil :: T?)
	if ref.current == nil then
		ref.current = initFunction()
	end
	assert(ref.current ~= nil, "Ref must be defined after initialization function is called")
	return ref :: ObjectRef<T>
end

return useLazyRef
