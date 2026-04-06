--!strict
local Packages = script.Parent.Parent
local React = require(Packages.React)
local useDebounce = require(script.Parent.useDebounce)

local function useDebouncedState<T>(initialState: T, delay: number?)
	local state, setState = React.useState(initialState)
	local debouncedState = useDebounce(state, delay)
	return debouncedState, setState
end

return useDebouncedState
