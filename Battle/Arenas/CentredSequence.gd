extends BaseAttack

signal spawn_bullet(type, pos, dir)

export(String) var projectile_type = 'virus'

onready var timer = $Timer

func _ready() -> void:
	for child in get_children():
		if child == timer:
			continue
		child.connect("spawn_bullet", self, "_on_bullet_spawn")
		

func start(args: Array):
	assert(args.size() > 0, "Missing interval time")
	var time := float(args[0])
	var reverse := bool(args[1] == "1")
	for i in get_child_count():
		var child
		if reverse:
			child = get_children()[get_child_count()-i-1]
		else:
			child = get_children()[i]
		
		if child == timer:
			continue
		child.start(args.slice(2, -1))
		timer.wait_time = time
		timer.start()
		yield(timer, "timeout")
	emit_signal("attack_done")

func _on_bullet_spawn(_type: String, pos: Vector2, dir: Vector2):
	emit_signal("spawn_bullet", projectile_type, pos, dir)	

func time(args: Array) -> float:
	var delays := get_child_count()-2
	var time := args[0] as float
	return time*6
