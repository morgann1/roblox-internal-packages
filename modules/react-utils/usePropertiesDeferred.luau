local Packages = script.Parent.Parent
local React = require(Packages.React)
local usePropertiesBase = require(script.Parent.usePropertiesBase)

type ChangeFunc = usePropertiesBase.ChangeFunc
type PropNames = usePropertiesBase.PropNames

local function usePropertiesDeferred<T>(forwardRef: React.Ref<T>, update: ChangeFunc, ...: PropNames): React.Ref<T>
	return usePropertiesBase(forwardRef, update, true, ...)
end

return usePropertiesDeferred
