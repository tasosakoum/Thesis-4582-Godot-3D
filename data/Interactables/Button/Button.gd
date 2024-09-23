extends Interactable

@export var affectedObjectIds: Array[int]
@export var state: Array[Enums.ObjectInteractBehavior]
@onready var animationPlayer: AnimationPlayer = $RigidBody3D/AnimationPlayer

func _ready():
	isMovable = false
	
func interact(): 
	Signals.buttonPressed.emit(affectedObjectIds, state)
	animationPlayer.play("Button_Press")
	
