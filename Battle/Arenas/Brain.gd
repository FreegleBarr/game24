extends "res://Battle/Arenas/Arena.gd"

onready var walls = $Organ/InnerWalls


func _on_Timer_timeout() -> void:
	walls.transition()
