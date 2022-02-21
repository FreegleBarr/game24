extends BaseAttack

signal spawn_bullet(type, pos, dir)

onready var timer := $Timer

func time(args: Array):
	var repeats := args[0] as int
	var delay := args[1] as float
	
	return (repeats-1)*delay

func attack():
	var pos = Vector2()
	var dir = Battle.player.position
	emit_signal("spawn_bullet", 'nerve shock', pos, dir)

func start(args: Array):
	var repeats := args[0] as int
	var delay := args[1] as float
	attack()
	timer.wait_time = delay
	for _i in range(repeats-1):
		timer.start()
		yield(timer, "timeout")
		attack()
	emit_signal("attack_done")
