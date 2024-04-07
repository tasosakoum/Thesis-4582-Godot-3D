extends Area3D

@export var affectedObjectIds: Array[int]
@export var OnPressurePlatePressed: Array[Enums.ObjectInteractBehavior]
@export var OnPressurePlateReleased: Array[Enums.ObjectInteractBehavior]

var mesh: MeshInstance3D
var plateActiveMaterial: Material = preload("res://data/Interactables/PressurePlate/materials/pressure_plate_active.tres")
var plateNotActiveMaterial: Material = preload("res://data/Interactables/PressurePlate/materials/pressure_plate_not_active.tres")
var isPressed := false

func _ready():
	mesh = $MeshInstance3D

func _process(delta):
	setIsPressed(has_overlapping_bodies())
	pass
	
func setIsPressed(newValue: bool):
	if newValue == isPressed: return	
	
	isPressed = newValue
	
	if isPressed:
		Signals.pressurePlatePressed.emit(affectedObjectIds, OnPressurePlatePressed)	
		mesh.set_surface_override_material(0, plateActiveMaterial) 
	else:
		Signals.pressurePlateReleased.emit(affectedObjectIds, OnPressurePlateReleased)	
		mesh.set_surface_override_material(0, plateNotActiveMaterial) 

