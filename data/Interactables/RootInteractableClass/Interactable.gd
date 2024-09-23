extends Node3D

class_name Interactable


@export var isMovable: bool
@export var objectId: int

var isMoving := false

func interact():
	#print("Interacted!")
	pass
	
func moveIfPossible(position):
	if (isMovable):	
		isMoving = true
		global_transform.origin = position
		
func setIsMoving(isMoving: bool):
	self.isMoving = isMoving
	
func onStoppedInteracting():
	pass
		
