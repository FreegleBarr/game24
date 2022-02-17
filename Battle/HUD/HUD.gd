extends Control

onready var hpcounter = $Center/HBoxContainer/VBoxContainer/HBoxContainer/HP
onready var timebar = $Center/HBoxContainer/MarginContainer/HBoxContainer/CenterContainer/TimeBar


func _on_Player_hp_changed(value) -> void:
	hpcounter.change_hp(value)


func _on_AttackChoreography_script_loaded(time) -> void:
	timebar.start(time)
