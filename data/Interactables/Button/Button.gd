extends Interactable

@onready var affectedObjectIds = $"..".affectedObjectIds
@onready var state = $"..".state
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready():
	isMovable = false
	
func interact(): 
	Signals.buttonPressed.emit(affectedObjectIds, state)
	animationPlayer.play("Button_Press")
	
