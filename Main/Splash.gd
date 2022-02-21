extends CanvasLayer

signal splash_done

onready var tween := $Tween

func _ready() -> void:
	$Sprite.visible = true

func show():
	tween.interpolate_property($Sprite.material, "shader_param/blend",
		0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property($Sprite.material, "shader_param/blend",
		1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("splash_done")



