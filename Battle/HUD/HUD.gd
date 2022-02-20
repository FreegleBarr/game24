extends Control

export(SpriteFrames) var portrait_frames setget set_portrait_frames
func set_portrait_frames(frames):
	if frames:
		portrait_frames = frames
		if not portrait:
			yield(self, "ready")
		portrait.frames = frames

onready var hpcounter = $Center/HBoxContainer/VBoxContainer/HBoxContainer/HP
onready var timebar = $Center/HBoxContainer/MarginContainer/HBoxContainer/CenterContainer/TimeBar
onready var portrait = $Center/HBoxContainer/MarginContainer/HBoxContainer/Portrait/EnemyPortrait

func _on_Player_hp_changed(value) -> void:
	hpcounter.change_hp(value)


func _on_AttackChoreography_script_loaded(time) -> void:
	timebar.start(time)


func _on_Player_hurt() -> void:
	portrait.roar()
