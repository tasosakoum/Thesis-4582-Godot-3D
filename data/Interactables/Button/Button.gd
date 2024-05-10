extends Interactable

@export var affectedObjectIds: Array[int]
@export var state: Array[Enums.ObjectInteractBehavior]
@onready var pickable: XRToolsPickable = $PickableObject

var animationPlayer: AnimationPlayer

func _ready():
	isMovable = false
	animationPlayer = $AnimationPlayer
	pickable.dropped.connect(interact)
	
func interact(): 
	Signals.buttonPressed.emit(affectedObjectIds, state)
	animationPlayer.play("Button_Press")
	
