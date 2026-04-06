local Motion = script.Parent.Parent
local Packages = Motion.Parent
local React = require(Packages.React)

-- Type definition for presence context structure
export type PresenceContext = {
	-- Unique identifier for this presence instance
	id: string,
	-- Current presence state
	isPresent: boolean,
	-- Custom data passed through context
	passThroughData: any?,
	-- Callback for exit animation completion
	onExitComplete: ((string) -> ())?,
}

-- Create context with nil default value - components will warn if used outside provider
return React.createContext({
	isPresent = true,
	id = "",
	onExitComplete = nil,
	passThroughData = nil,
} :: PresenceContext)
