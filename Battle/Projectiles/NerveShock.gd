extends Projectile

export var move_speed := 100

onready var bodySprite := $BodySprite

var direction: Vector2
var spawned: bool = true

var Explosion = preload("res://Battle/Projectiles/Explosion.tscn")

enum TYPES {MOVE, ROTATE}
var variant = TYPES.MOVE


func contact(destroy_self:=true):
	var explosion = Explosion.instance()
	explosion.position = position
	get_parent().add_child(explosion)
	if destroy_self:
		get_parent().call_deferred("remove_child", self)

func setup(pos: Vector2, dir: Vector2):
	
	var spawn_timer = [1, 1.5, 2][randi()%3]
	
#	variant = randi()%2
	
	if variant == TYPES.ROTATE:
		rotation_degrees = randi()*360
	else:
		rotation = PI/2 +position.angle_to_point(dir)
	var h_dir = sign(Battle.player.position.x - pos.x)
	direction = Vector2(h_dir, 0)
	position = pos

func _physics_process(delta: float) -> void:
	return
	if variant == TYPES.MOVE:
		position += direction*move_speed*delta
	
	
func _on_Area2D_body_entered(_body: Node) -> void:
	if spawned:
		contact()

func _ready():
	bodySprite.play("travel")


func _on_BurstTimer_timeout():
	bodySprite.play("burst")
	$WarningBolt.show()
#	move_speed = 0

func _on_AnimatedSprite_animation_finished():
	if bodySprite.animation != "burst": return
	$WarningBolt.hide()
	
	var Lightning = preload("res://Battle/EnemyObjects/Lightning.tscn")
	Battle.emit_signal("spawn_enemy_object", Lightning, position, rotation_degrees)
	contact()
	
