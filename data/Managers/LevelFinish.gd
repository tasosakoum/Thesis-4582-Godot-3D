extends Area3D

@export var nextScene: String
@onready var animationPlayer: AnimationPlayer = $CanvasLayer/Control/Label/AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isPlayerInFinishZone():
		handleLevelFinish()
		
	
func handleLevelFinish():
		animationPlayer.play("fade_in")
		Signals.levelFinished.emit()
		set_process(false)
		loadNextScene()
		
func loadNextScene():
	await animationPlayer.animation_finished
	get_tree().change_scene_to_file(nextScene)
	
func isPlayerInFinishZone() -> bool:
	for body in get_overlapping_bodies():
		if body is CharacterBody3D:
			return true	
			
	return false
