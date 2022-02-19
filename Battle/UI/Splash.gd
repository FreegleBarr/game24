extends CanvasLayer

export(StreamTexture) var win
export(StreamTexture) var lose

onready var splash = $CenterContainer/Splash
onready var okay = $CenterContainer/VBoxContainer/Okay
onready var cancel = $CenterContainer/VBoxContainer/Cancel


func won():
	splash.texture = win
	show()
	
func lost():
	splash.texture = lose
	show()

func show():
	var tween = $Tween
	tween.interpolate_property($CenterContainer, "rect_position",
			$CenterContainer.rect_position, Vector2(0, 0), 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if object == $CenterContainer:
		var tween = $Tween2
		tween.interpolate_property($CenterContainer/Buttons, "modulate",
			Color(1,1,1,0), Color(1,1,1,1), 1,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween.start()
