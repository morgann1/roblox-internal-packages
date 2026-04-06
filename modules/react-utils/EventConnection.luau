local useEventConnection = require(script.Parent.useEventConnection)

export type Props = {
	event: RBXScriptSignal,
	callback: (any) -> (),
}

local function EventConnection(props: Props)
	useEventConnection(props.event, props.callback, { props.event, props.callback } :: { any })
end

return EventConnection
