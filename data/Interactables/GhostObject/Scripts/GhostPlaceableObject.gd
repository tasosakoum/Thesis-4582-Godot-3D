extends Area3D

var rootNode: Node3D
var movableItem: XRToolsPickable
var objectId: int

func _ready():
	rootNode = $".."
	objectId = rootNode.objectId
	movableItem = $"../PickableObject"

func _process(delta):
	if overlaps_body(movableItem):
		movableItem.transform = transform
		movableItem.FREEZE_MODE_KINEMATIC

