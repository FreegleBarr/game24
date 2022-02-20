extends BaseAttack

signal spawn_bullet(type, pos, dir)

export(String) var projectile_type = 'virus'

onready var player: Node2D = Battle.player

onready var spawnpoint = $SpawnPoint
onready var timer = $Timer


func _physics_process(_delta: float) -> void:
	if player:
		spawnpoint.position.y = -player.position.y

func attack():
	if player:
		var position = spawnpoint.position
		var direction: Vector2 = player.position - position
		emit_signal("spawn_bullet", projectile_type,position, direction)
	
	
func start(args: Array):
	var repeats := args[0] as int
	var time := args[1] as float
	attack()
	timer.wait_time = time
	for _i in range(repeats-1):
		timer.start()
		yield(timer, "timeout")
		attack()
	emit_signal('attack_done')
