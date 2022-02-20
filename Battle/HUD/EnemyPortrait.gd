extends AnimatedSprite

func roar():
	if animation == 'default':
		play('roar')

func _on_EnemyPortrait_animation_finished() -> void:
	if animation == 'roar':
		play('default')
