extends Projectile

export var move_speed := 200

onready var Body = $RigidBody2D

var direction: Vector2
var spawned: bool = false

var Explosion = preload("res://Battle/Projectiles/Explosion.tscn")

var bounce_count := 0

func contact():
	var explosion = Explosion.instance()
	explosion.global_position = Body.global_position
	get_parent().add_child(explosion)
	get_parent().call_deferred("remove_child", self)

func setup(pos: Vector2, _dir: Vector2):
	# _dir is ignored
	spawned = false
	direction = pos.direction_to(Battle.player.position)
	# Leave as $RigidBody2D. setup is called before ready.
	$RigidBody2D.linear_velocity = direction*move_speed
	$RigidBody2D.set_collision_mask_bit(0, false)
	position = pos
	

func _on_Area2D_body_exited(body: Node) -> void:
	if body is StaticBody2D:
		if bounce_count == 0:
			$RigidBody2D.set_collision_mask_bit(0, true)
			
		bounce_count +=1
			
		if bounce_count >= 3:
			contact()
				
		
