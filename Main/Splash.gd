extends CanvasLayer

signal splash_done

onready var tween := $Tween

func _ready() -> void:
	$Sprite.visible = true

func show():
	$CenterContainer/Control/AnimatedSprite.play('default')
	yield(tween, "tween_completed")
	$CenterContainer/Control/AnimatedSprite.visible = false
	tween.stop_all()
	tween.interpolate_property($Sprite.material, "shader_param/blend",
		0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property($Sprite.material, "shader_param/blend",
		1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	emit_signal("splash_done")





func _on_AnimatedSprite_animation_finished() -> void:
	tween.interpolate_property($CenterContainer, "modulate",
		Color(1,1,1,1), Color(0,0,0,0), 1)
	tween.start()
