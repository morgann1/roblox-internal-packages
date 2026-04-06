local Packages = script.Parent.Parent
local ReactRoblox = require(Packages.ReactRoblox)

local function waitForEvents()
	task.wait(0)
end

local function actWaitForEvents()
	ReactRoblox.act(function()
		waitForEvents()
	end)
end

type WaitWithAct = (() -> ()) & { act: () -> () }

return (setmetatable({ act = actWaitForEvents }, { __call = waitForEvents }) :: any) :: WaitWithAct
