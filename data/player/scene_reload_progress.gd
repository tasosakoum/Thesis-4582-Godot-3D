extends ProgressBar

@onready var timer: Timer = $"../../../Timer"

func _ready():
	max_value = timer.wait_time
	
func _process(delta):
	visible = timer.time_left != 0
	value = max_value - timer.time_left
