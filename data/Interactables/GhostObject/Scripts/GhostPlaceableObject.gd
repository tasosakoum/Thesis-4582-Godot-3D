extends Area3D

var rootNode: Node3D
var movableItem: Interactable
var objectId: int

func _ready():
	rootNode = $".."
	objectId = rootNode.objectId
	movableItem = $"../MovableItem"

func _process(delta):
	if overlaps_body(movableItem):
		movableItem.transform = transform

