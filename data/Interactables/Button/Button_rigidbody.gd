extends RigidBody3D

@onready var parent_button := $".."

func pointer_event(event: XRToolsPointerEvent):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		parent_button.interact()
