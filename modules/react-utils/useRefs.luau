--!strict
local Packages = script.Parent.Parent
local React = require(Packages.React)

local function useRefs<T>(count: number, default: T): { { current: T } }
	local createdRefsRef = React.useRef({} :: { { current: T } })
	local lastCountRef = React.useRef(count)

	if #createdRefsRef.current < count then
		for _ = 1, count - #createdRefsRef.current do
			local newRef = React.createRef()
			newRef.current = default
			table.insert(createdRefsRef.current, newRef)
		end
	elseif lastCountRef.current > count then
		for index = count + 1, lastCountRef.current do
			createdRefsRef.current[index].current = default
		end
	end

	lastCountRef.current = count

	local limitedRefs = React.useMemo(function(): { { current: T } }
		return table.move(createdRefsRef.current, 1, count, 1, {})
	end, { count })

	return limitedRefs
end

return useRefs
