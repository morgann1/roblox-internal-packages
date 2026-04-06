local Motion = script.Parent.Parent
local Packages = Motion.Parent
local React = require(Packages.React)
local PresenceContext = require(script.Parent.PresenceContext)
local useIdFallback = require(script.Parent.utils).useIdFallback

export type PresenceProviderProps = {
	-- Child components to receive presence context
	children: any,
	-- Whether children should be considered present
	isPresent: boolean?,
	-- Custom data to pass through context
	passThroughData: any?,
	-- Callback when all children have exited
	onExitComplete: (() -> ())?,
}

local function PresenceProvider(props: PresenceProviderProps)
	-- Validate props
	if props == nil then
		error("PresenceProvider: props cannot be nil")
	end

	local children = props.children
	local isPresent = props.isPresent
	if isPresent == nil then
		isPresent = true
	end
	local passThroughData = props.passThroughData

	-- Generate a unique ID for this provider
	local id
	local success, result = pcall(function()
		id = useIdFallback()
	end)

	if not success then
		warn("PresenceProvider: Error generating ID:", result)
		id = "presence-" .. useIdFallback()
	end

	-- Create child registration map
	local childrenPresence
	success, result = pcall(function()
		childrenPresence = React.useRef({})
	end)

	if not success then
		warn("PresenceProvider: Error creating childrenPresence ref:", result)
		childrenPresence = { current = {} }
	end

	-- Handler for when a child exits
	local function onExitComplete(childId)
		if childrenPresence.current then
			childrenPresence.current[childId] = true
		end

		-- Check if all children have completed exit
		local allComplete = true
		for _childKey, completed in pairs(childrenPresence.current) do
			if not completed then
				allComplete = false
				break
			end
		end

		-- If we have a parent context, notify it that we're done
		if allComplete and props.onExitComplete then
			props.onExitComplete()
		end
	end

	-- Handler for children to register themselves
	local function register(childId)
		childrenPresence.current[childId] = false

		-- Return cleanup function
		return function()
			childrenPresence.current[childId] = nil
		end
	end

	-- Create context value
	local contextValue = {
		id = id,
		isPresent = isPresent,
		register = register,
		onExitComplete = onExitComplete,
		passThroughData = passThroughData,
	}

	local _presenceResult
	success, result = pcall(function()
		_presenceResult = React.createElement(PresenceContext.Provider, {
			value = contextValue,
		}, children)
	end)

	if not success then
		warn("PresenceProvider: Error creating PresenceContext.Provider:", result)
	end

	return _presenceResult or React.createElement(React.Fragment, {}, children)
end

return PresenceProvider
