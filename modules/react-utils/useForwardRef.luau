local Packages = script.Parent.Parent
local React = require(Packages.React)

type CleanupFunc = () -> ()
type UpdateFunc<T> = (T) -> CleanupFunc?

local function useForwardRef<T>(forwardRef: React.Ref<T>?, update: UpdateFunc<T>): React.Ref<T>
	local value = React.useRef(nil :: T?)
	local cleanup = React.useRef(nil :: CleanupFunc?)

	local ref = React.useCallback(function(instance: T?)
		if cleanup.current then
			cleanup.current()
			cleanup.current = nil
		end
		if instance then
			value.current = instance
			cleanup.current = update(instance)
		end
	end, { update })

	React.useImperativeHandle(forwardRef, function()
		return value.current
	end)

	return ref
end

return useForwardRef
