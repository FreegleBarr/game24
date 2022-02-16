extends BaseAttack

export var proj_type: String = 'virus'
export var speed: float = 200

onready var spawn_point = $Path2D/SpawnPoint


func start(_args: Array):
	var timer = Timer.new()
	timer.wait_time = 1
	add_child(timer)
	while (true):
		var pos = spawn_point.position
		var dir = Battle.player.position - pos
		emit_signal('spawn_bullet', proj_type, pos, dir)
		timer.start()
		yield(timer, "timeout")
	emit_signal("attack_done")

func _ready() -> void:
	if not Battle.background:
		return
	var bm := BitMap.new()
	bm.create_from_image_alpha(Battle.background.get_data())
	var size = Battle.background.get_size()
	var rect = Rect2(Vector2.ZERO, size)
	var polies = bm.opaque_to_polygons(rect)
	var poly = polies[0]
	var curve := Curve2D.new()
	for point in poly:
		curve.add_point(point-size/2)
	$Path2D.set_curve(curve)
	spawn_point.offset = 0


func _physics_process(delta: float) -> void:
	spawn_point.offset += delta *speed

