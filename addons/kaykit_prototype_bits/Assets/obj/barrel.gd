extends Node3D

var maxDuplicates := 1000
var timesDuplicated := 0

var isDuplicated = false
@onready var rigidBody: RigidBody3D = $RigidBody3D

func _ready():
	rigidBody.body_entered.connect(onBodyEntered)
	
func onBodyEntered(body):
	if body is DuplicatingBoulder:
		duplicateSelf()
		
func duplicateSelf():
	if isDuplicated: return
	if timesDuplicated >= maxDuplicates:
		isDuplicated = true
		
	timesDuplicated += 1
	var duplicate := self.duplicate()
	duplicate.isDuplicated = true
	get_parent().add_child(duplicate)
	duplicate.global_transform.origin += Vector3(1, 0, 0)
	
