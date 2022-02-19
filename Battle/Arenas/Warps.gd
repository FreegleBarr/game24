extends Node2D

var finished_warp := true

var enabled := true setget enable

func enable(value):
	enabled = value
	$WarpLeft/Collision.set_deferred("disabled", not enabled)
	$WarpRight/Collision.set_deferred("disabled", not enabled)

func _on_WarpLeft_body_entered(body: Node) -> void:
	if finished_warp:
		finished_warp = false
		body.apply_force(Vector2(0, 10))
		body.position = $WarpRight.position
		

func _on_WarpRight_body_entered(body: Node) -> void:
	if finished_warp:
		finished_warp = false
		body.apply_force(Vector2(0, 10))
		body.position = $WarpLeft.position
		


func _on_Warp_body_exited(body: Node) -> void:
	set_deferred("finished_warp", true)
	
