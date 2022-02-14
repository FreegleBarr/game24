extends Area2D



var current: Node2D


func _physics_process(delta: float) -> void:
	var areas := get_overlapping_areas()
	if not areas:
		return
	var closest_distance := 2e20
	var closest: Area2D
	for area in areas:
		var distance: float = (area.global_position - global_position).length()
		if distance <= closest_distance:
			closest_distance = distance
			closest = area
	if closest == current:
		return
	
