extends "res://Battle/Arenas/Arena.gd"

onready var walls = $Organ/InnerWalls


func _on_Timer_timeout() -> void:
	walls.transition()

func _on_Splash_change_scene(target):
	if target == 'map':
		emit_signal("change_scene", "res://Main/Win.tscn")
	else:
		._on_Splash_change_scene(target)
