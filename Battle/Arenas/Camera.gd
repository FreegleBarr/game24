extends Camera2D

export var limits := Vector2(5,5)

var velocity := Vector2()
func _physics_process(delta: float) -> void:
	velocity -= position
	velocity = velocity.linear_interpolate(Vector2.ZERO, delta*30)
	position += velocity
	if abs(position.x) >= limits.x:
		velocity.x = -0.99*velocity.x
	if abs(position.y) >= limits.y:
		velocity.y = -0.99*velocity.y
	

func _on_Player_hurt() -> void:
	var force := Vector2.RIGHT.rotated(randf()*TAU)*50
	velocity += force
	pass # Replace with function body.
