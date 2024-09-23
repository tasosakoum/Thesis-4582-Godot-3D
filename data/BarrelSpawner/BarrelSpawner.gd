extends Node3D

var outputFile := "C:/Users/tasos/Downloads/godot_benchmark.txt"

@onready var timer: Timer = $Timer
@onready var label: Label = $CanvasLayer/Control/Label
@onready var file := FileAccess.open(outputFile, FileAccess.WRITE)


var barrel = preload("res://addons/kaykit_prototype_bits/Assets/obj/Barrel_A.tscn")
var barrelsSpawned := 0

func _ready():
	timer.start()
	timer.timeout.connect(spawnBarrel)
	
func _finalize():
	file.close()
	
func _process(delta):
	label.text = "FPS: %d\nBarrels Spawned: %d" % [Engine.get_frames_per_second(), barrelsSpawned] 
	if barrelsSpawned % 50 == 0:
		file.store_line("(%d, %d)" % [barrelsSpawned, Engine.get_frames_per_second()])
	
func spawnBarrel():
	var newBarrel = barrel.instantiate()	
	barrelsSpawned += 1
	add_child(newBarrel)
	newBarrel.global_transform = transform
	timer.start()
