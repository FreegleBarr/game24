extends AnimatedSprite


func _ready() -> void:
	play("default")




func _on_Explosion_animation_finished() -> void:
	queue_free()
