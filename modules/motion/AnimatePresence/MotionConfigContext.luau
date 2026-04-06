local Motion = script.Parent.Parent
local Packages = Motion.Parent
local React = require(Packages.React)

-- Default configuration with Roblox-specific options
local defaultConfig = {
	-- Configuration options can be added here as needed
}

local MotionConfigContext = React.createContext(defaultConfig)

return MotionConfigContext
