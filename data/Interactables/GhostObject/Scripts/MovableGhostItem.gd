extends Interactable

@export var shouldResetAfterDrop := false

var isResetting := false
var rootNode: Node3D
var startingTransform: Transform3D

func _process(delta):
	if isResetting:
		transform = startingTransform
		
	if transform == startingTransform:
		isResetting = false

func _ready():
	isMovable = true
	rootNode = $".."
	objectId = rootNode.objectId
	startingTransform = transform
	
func onStoppedInteracting():
	resetTransform()

func resetTransform():
	isResetting = true
	transform = startingTransform
	
