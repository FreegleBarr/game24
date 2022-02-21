extends Node2D
tool

signal change_scene(target)

export(String, FILE, "*.tscn") var Village

func _ready() -> void:
	print("i")
	AudioHandler.change_sound_to("Boss")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_AttackChoreography_fight_over() -> void:
	var timer := Timer.new()
	timer.wait_time = 4
	add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
	if not $Player.dead:
		print("You Win")
		$BG/Scroll.won()
		$Splash.won()


func _on_Player_died() -> void:
	$BG/Scroll.lost()
	$Splash.lost()


func _on_StartTimer_timeout() -> void:
	$AttackChoreography.start()




func _on_Splash_change_scene(target) -> void:
	match (target):
		"map":
			emit_signal("change_scene", "map")
		"overworld":
			emit_signal("change_scene", Village)
		"battle":
			emit_signal("change_scene", filename)
