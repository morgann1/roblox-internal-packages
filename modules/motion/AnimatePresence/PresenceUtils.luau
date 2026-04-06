local Motion = script.Parent.Parent
local Packages = Motion.Parent
local React = require(Packages.React)
local PresenceContext = require(script.Parent.PresenceContext)
type PresenceContext = PresenceContext.PresenceContext

local function isPresent(context: PresenceContext): boolean
	if context == nil then
		return true
	end
	return context.isPresent
end

local function useIsPresent(): boolean
	local context: PresenceContext = React.useContext(PresenceContext)
	return isPresent(context)
end

return {
	useIsPresent = useIsPresent,
	isPresent = isPresent,
}
