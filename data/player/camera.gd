extends Camera3D

const RAY_RANGE = 5

signal stoppedInteracting

var detectedObject = null

func _input(event):
	if event.is_action_pressed("Shoot"):
		GetIntersectedObject()
		
	if event.is_action_released("Shoot"):
		stoppedInteracting.emit()
		await stoppedInteracting
		if detectedObject is Interactable:
			detectedObject.isMoving = false
		detectedObject = null
		
func _process(delta): 
	if detectedObject is Interactable:
		detectedObject.moveIfPossible($StaticBody3D.global_transform.origin)	

func GetIntersectedObject():
	var center = get_viewport().size / 2
	
	var rayOrigin = project_ray_origin(center)
	var rayEnd = rayOrigin + project_ray_normal(center) * RAY_RANGE
	
	var newIntersection = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var intersection = get_world_3d().direct_space_state.intersect_ray(newIntersection)
	
	if not intersection.is_empty():
		detectedObject = intersection.collider
		if detectedObject is Interactable:
			stoppedInteracting.connect(detectedObject.onStoppedInteracting)
			detectedObject.interact()
