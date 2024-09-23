extends Area3D

@onready var rootNode: Node3D = $".."
@onready var movableItem: Interactable = $"../MovableItem"
@onready var objectId: int = rootNode.objectId

func _process(delta):
	if overlaps_body(movableItem) and not movableItem.isMoving:
		movableItem.transform = transform

