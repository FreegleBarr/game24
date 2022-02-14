extends BaseAttack

signal spawn_bullet(type, pos, dir)
onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/StateMachine/playback")

func _ready() -> void:
	print(playback.get_current_node())

func start(_args: Array) -> void:
	var direction = -$Pivot/SpawnPoint.global_position
	var position = $Pivot/SpawnPoint.global_position
	emit_signal("spawn_bullet", "virus", position, direction)
	emit_signal("attack_done")
