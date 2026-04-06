--!strict
local Packages = script.Parent.Parent
local React = require(Packages.React)
local useEventConnection = require(script.Parent.useEventConnection)

local function useSelection(mockService: any?): { Instance }
	local selectionService = mockService or game:GetService("Selection")
	local selection, setSelection = React.useState(function()
		return selectionService:Get()
	end)
	useEventConnection(selectionService.SelectionChanged, function()
		setSelection(selectionService:Get())
	end, {})
	return selection
end

return useSelection
