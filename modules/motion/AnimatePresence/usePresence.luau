local Motion = script.Parent.Parent
local Packages = Motion.Parent
local React = require(Packages.React)
local PresenceContext = require(script.Parent.PresenceContext)
local PresenceUtils = require(script.Parent.PresenceUtils)
local isPresent = PresenceUtils.isPresent

-- Type definition for the usePresence hook's return value
type UsePresenceReturnType = {
	id: string,
	isPresent: boolean,
	passThroughData: any?,
	onExitComplete: () -> (),
}

local function usePresence(): UsePresenceReturnType
	local context = React.useContext(PresenceContext)

	-- Extract what we need from context
	local id = context.id
	local _isPresentValue = context.isPresent
	local onExitComplete = context.onExitComplete
	local passThroughData = context.passThroughData

	-- Create a safeToRemove function that calls onExitComplete with our ID
	local safeToRemove = React.useCallback(function()
		if onExitComplete then
			onExitComplete(id)
		end
	end, { onExitComplete :: any, id })

	return {
		isPresent = isPresent(context),
		id = id,
		onExitComplete = safeToRemove,
		passThroughData = passThroughData,
	}
end

return usePresence
