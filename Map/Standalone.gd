extends Node2D

signal change_scene(target)

func _ready() -> void:
	Overworld.village = self
