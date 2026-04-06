local Packages = script.Parent.Parent
local React = require(Packages.React)

local function useDelayedActionHandler(
	delayTimeSeconds: number,
	throttleTimeSeconds: number?,
	action: () -> ()
): () -> ()
	local currentThreadRef = React.useRef(nil :: thread?)
	local lastThreadStartTime = React.useRef(0)

	local function handleAction()
		local currentTime = os.clock()
		if throttleTimeSeconds ~= nil and lastThreadStartTime.current ~= nil then
			if currentTime - lastThreadStartTime.current < throttleTimeSeconds then
				return
			end
		end
		lastThreadStartTime.current = currentTime
		local currentThread = currentThreadRef.current
		if currentThread ~= nil then
			task.cancel(currentThread)
		end
		currentThreadRef.current = task.delay(delayTimeSeconds, function()
			action()
		end)
	end

	React.useEffect(function()
		return function()
			local currentThread = currentThreadRef.current
			if currentThread ~= nil then
				task.cancel(currentThread)
			end
		end
	end, { currentThreadRef } :: { any })

	return handleAction
end

return useDelayedActionHandler
