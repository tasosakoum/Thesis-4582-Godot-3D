extends Node

signal buttonPressed(affectedObjectIds, affectedObjectState)

signal pressurePlatePressed(affectedObjectIds, affectedObjectsState)
signal pressurePlateReleased(affectedObjectIds, affectedObjectsState)

signal setCrosshairEnabled(enabled: bool)
signal levelFinished
