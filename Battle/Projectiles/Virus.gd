extends Projectile

export var move_speed := 200

var direction: Vector2

func contact():
	get_parent().remove_child(self)

func setup(pos: Vector2, dir: Vector2):
	direction = dir.normalized()
	position = pos
	rotation = dir.angle() + PI/2

func _physics_process(delta: float) -> void:
	position += direction*move_speed*delta
	



func _on_Area2D_body_entered(body: Node) -> void:
	get_parent().remove_child(self)
