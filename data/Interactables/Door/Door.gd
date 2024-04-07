extends Node3D

@export var doorId: int	
@export var isClosed := true
@export var isLocked := false

var animationPlayer: AnimationPlayer
var previousLockedState: bool 
var previousClosedState: bool 

func _ready():
	animationPlayer = $AnimationPlayer
	animationPlayer.play("Door_Close") if isClosed else animationPlayer.play("Door_Open")
	
	Signals.buttonPressed.connect(changeDoorState)
	Signals.pressurePlatePressed.connect(changeDoorState)
	Signals.pressurePlateReleased.connect(changeDoorState)

func setLockedState(isLocked: bool):
	#previousLockedState = self.isLocked
	self.isLocked = isLocked
	
func setClosedState(isClosed: bool):
	#previousClosedState = self.isClosed
	self.isClosed = isClosed
	
func open(lock: bool = false, unlock: bool = false):
	if unlock: setLockedState(false)
	
	if isLocked: return
	if not isClosed: return
	if animationPlayer.is_playing():
		await animationPlayer.animation_finished
	
	animationPlayer.play("Door_Open")
	setClosedState(false)
	setLockedState(lock)
	
func close(lock: bool = false, unlock: bool = false):
	if unlock: setLockedState(false)
	
	if isClosed or isLocked: return
	if animationPlayer.is_playing(): 
		await animationPlayer.animation_finished
	
	animationPlayer.play("Door_Close")
	setClosedState(true)
	setLockedState(lock)
	
func changeDoorState(affectedObjectsIds: Array, objectStates):
	if not doorId in affectedObjectsIds:
		return
		
	var doorIndex = affectedObjectsIds.find(doorId)
	var newState: Enums.ObjectInteractBehavior = objectStates[doorIndex]
	
	if newState != Enums.ObjectInteractBehavior.RESET:
		previousClosedState = isClosed
		previousLockedState = isLocked
		
	executeState(newState)	

func executeState(newState: Enums.ObjectInteractBehavior):
	if newState != null:
		match newState:
			Enums.ObjectInteractBehavior.CLOSE:
				close()
			Enums.ObjectInteractBehavior.OPEN:
				open()
			Enums.ObjectInteractBehavior.SWITCH_STATE:
				if isClosed:
					open()
				else:
					close()
				#open() if isClosed else close()
			Enums.ObjectInteractBehavior.OPEN_AND_LOCK:
				open(true)
			Enums.ObjectInteractBehavior.CLOSE_AND_LOCK:
				close(true)
			Enums.ObjectInteractBehavior.OPEN_AND_UNLOCK:
				open(false, true)
			Enums.ObjectInteractBehavior.CLOSE_AND_UNLOCK:
				close(false, true)
			Enums.ObjectInteractBehavior.RESET:
				if previousClosedState == true:
					close(previousLockedState, !previousLockedState)
				else:
					open(previousLockedState, !previousLockedState)
	

	
