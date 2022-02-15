extends Projectile

export var move_speed := 200

var direction: Vector2
var spawned: bool

var Explosion = preload("res://Battle/Projectiles/Explosion.tscn")

func contact():
	var explosion = Explosion.instance()
	explosion.position = position
	get_parent().add_child(explosion)
	get_parent().call_deferred("remove_child", self)

func setup(pos: Vector2, dir: Vector2):
	spawned = false
	direction = dir.normalized()
	position = pos
	rotation = dir.angle() + PI/2

func _physics_process(delta: float) -> void:
	position += direction*move_speed*delta
	

func _on_Area2D_body_entered(_body: Node) -> void:
	if spawned:
		contact()




func _on_Area2D_body_exited(_body: Node) -> void:
	spawned = true
