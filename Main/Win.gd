extends Node2D

signal change_scene(title)

onready var tween := $Tween
onready var label1 := $CanvasLayer/CenterContainer/PanelContainer/VBoxContainer/Label
onready var label2 := $CanvasLayer/CenterContainer/PanelContainer/VBoxContainer/Label2

func _ready() -> void:
	tween.interpolate_property(label1, "percent_visible",
		0, 1, label1.text.length()*0.1)
	tween.start()


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if object == label1:
		tween.interpolate_property(label2, "percent_visible",
			0, 1, label2.text.length()*0.1)
		tween.start()


func _on_TextureButton_pressed() -> void:
	Main.main.restart()
