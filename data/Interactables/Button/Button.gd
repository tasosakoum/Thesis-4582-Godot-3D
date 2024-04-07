extends Interactable

@export var affectedObjectIds: Array[int]
@export var state: Array[Enums.ObjectInteractBehavior]

var animationPlayer: AnimationPlayer

func _ready():
	isMovable = false
	animationPlayer = $AnimationPlayer
	
func interact(): 
	Signals.buttonPressed.emit(affectedObjectIds, state)
	animationPlayer.play("Button_Press")
