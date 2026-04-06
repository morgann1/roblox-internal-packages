--!strict
local Packages = script.Parent.Parent
local React = require(Packages.React)

local function useRefToState<T>(state: T): { current: T }
	local ref = React.useRef(state) :: { current: T }
	ref.current = state
	return ref
end

return useRefToState
