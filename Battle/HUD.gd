extends Control

onready var hp_label = $PanelContainer/HBoxContainer/Label2



func _on_Player_hp_changed(value) -> void:
	hp_label.text = str(value)
