extends Node2D
tool

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("i")


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


