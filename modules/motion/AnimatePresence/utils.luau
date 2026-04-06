local Motion = script.Parent.Parent
local Packages = Motion.Parent
local React = require(Packages.React)

-- Type definitions
type ReactElement = {
	["$$typeof"]: any,
	key: string?,
	props: { [string]: any }?,
	type: any,
}

local function getChildKey(child: any): string?
	if child == nil then
		return nil
	end

	if type(child) ~= "table" then
		return nil
	end

	-- For React elements, key is a property on the element itself, not in props
	if child.key ~= nil then
		return child.key
	end

	-- Fallback for non-React objects that might have key in props
	if child.props and child.props.key ~= nil then
		return child.props.key
	end

	return nil
end

local function useIdFallback(): string
	local id = tostring(math.random(1000000))
	if id == nil then
		return "id-" .. id
	end
	return id
end

local function onlyElements(children: any): { ReactElement }
	local filtered: { ReactElement } = {}

	React.Children.forEach(children, function(child: any)
		if React.isValidElement(child) then
			table.insert(filtered, child :: ReactElement)
		end
	end)

	return filtered
end

return {
	getChildKey = getChildKey,
	onlyElements = onlyElements,
	useIdFallback = useIdFallback,
}
