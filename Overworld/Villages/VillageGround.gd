extends Area2D

var grounded := true setget set_grounded
#var last_grounded_position := Vector2()


#func _physics_process(delta):
#	if grounded:
#		last_grounded_position = owner.player.position
#

func set_grounded(b:bool):
	grounded = b
	owner.player.modulate = [Color(1,1,1,0.5), Color.white][int(b)]
	print("Grounded: ", b)

func _on_CayoteTimer_timeout():
	owner.emit_signal("player_fallen")#, last_grounded_position*0.9)
	set_grounded(true)

func _on_VillageGround_body_exited(_body):
	set_grounded(false)
	$CayoteTimer.start()

func _on_VillageGround_body_entered(_body):
	set_grounded(true)
	$CayoteTimer.stop()
