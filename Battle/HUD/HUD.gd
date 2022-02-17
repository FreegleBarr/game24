extends Control

onready var hpcounter = $Center/HBoxContainer/VBoxContainer/HP



func _on_Player_hp_changed(value) -> void:
	hpcounter.change_hp(value)
