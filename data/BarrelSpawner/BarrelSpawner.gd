extends Node3D

@onready var timer: Timer = $Timer
@onready var label: Label = $CanvasLayer/Control/Label

var barrel = preload("res://addons/kaykit_prototype_bits/Assets/obj/Barrel_A.tscn")
var barrelsSpawned := 0

func _ready():
	timer.start()
	timer.timeout.connect(spawnBarrel)

func _process(delta):
	label.text = "FPS: %d\nBarrels Spawned: %d" % [Engine.get_frames_per_second(), barrelsSpawned] 
	
func spawnBarrel():
	var newBarrel = barrel.instantiate()	
	barrelsSpawned += 1
	add_child(newBarrel)
	newBarrel.global_transform = transform
	timer.start()
