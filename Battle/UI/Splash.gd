extends CanvasLayer

signal change_scene(target)
export(StreamTexture) var win
export(StreamTexture) var lose

onready var splash = $CenterContainer/Splash
onready var win_buttons = $CenterContainer/Buttons/Win
onready var lose_buttons = $CenterContainer/Buttons/Lose

func disable_overworld():
	lose_buttons.get_node("CC/Overworld").visible = false

func _ready() -> void:
	$CenterContainer.rect_position.x = 1280
	$CenterContainer/Buttons.modulate = Color(1,1,1,0)

func won():
	splash.texture = win
	win_buttons.visible = true
	lose_buttons.visible = false
	show()
	
func lost():
	splash.texture = lose
	win_buttons.visible = false
	lose_buttons.visible = true
	show()

func show():
	var tween = $Tween
	tween.interpolate_property($CenterContainer, "rect_position",
			$CenterContainer.rect_position, Vector2(0, 0), 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _on_Tween_tween_completed(object: Object, _key: NodePath) -> void:
	if object == $CenterContainer:
		var tween = $Tween2
		tween.interpolate_property($CenterContainer/Buttons, "modulate",
			Color(1,1,1,0), Color(1,1,1,0.8), 1,
			Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		tween.start()


func _on_Map_pressed() -> void:
	emit_signal("change_scene", "map")

func _on_Overworld_pressed() -> void:
	emit_signal("change_scene", "overworld")

func _on_Retry_pressed() -> void:
	emit_signal("change_scene", "battle")
