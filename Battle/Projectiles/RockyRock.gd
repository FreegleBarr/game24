extends Projectile

export var move_speed := 100

onready var Body = $RigidBody2D

var direction: Vector2
var spawned: bool = false

var Explosion = preload("res://Battle/Projectiles/Explosion.tscn")

var bounce_count := 0

func contact():
	var explosion = Explosion.instance()
	explosion.global_position = Body.global_position
	explosion.modulate = Color("#414141")
	get_parent().add_child(explosion)
	get_parent().call_deferred("remove_child", self)

func setup(pos: Vector2, _dir: Vector2):
	# _dir is ignored
	# pos is manipulated, too.
	
	spawned = false
	pos.y = -300
	pos.x = clamp(pos.x, -200, 200)
	direction = pos.direction_to(Battle.player.position)
	
	# Leave as $RigidBody2D. setup is called before ready.
	$RigidBody2D.linear_velocity = Vector2.DOWN*move_speed
	$RigidBody2D.set_collision_mask_bit(0, false)
	position = pos
	

func _on_Area2D_body_exited(body: Node) -> void:
	if body is StaticBody2D:
		if bounce_count == 0:
			$RigidBody2D.set_collision_mask_bit(0, true)
			$RigidBody2D/AnimatedSprite.play("happy")
		
		print("boing", bounce_count)
		
		bounce_count +=1
			
		if bounce_count >= 2:
			$RigidBody2D/AnimatedSprite.play("sad")
			if $DestroyTimer.is_stopped():
				$DestroyTimer.start()
				


func _on_Area2D_body_entered(body):
	pass


func _on_DestroyTimer_timeout():
	contact()
	pass
