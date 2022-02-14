extends Sprite

func create_collision_polygon():
	var bm := BitMap.new()
	if not texture:
		return
	bm.create_from_image_alpha(texture.get_data())
	var rect := Rect2(Vector2(0,0), texture.get_size())
	var in_array: Array = bm.opaque_to_polygons(rect)
	for i in range(in_array.size()):
		for j in range(in_array[i].size()):
			in_array[i][j] = in_array[i][j] - texture.get_size()/2
		var polygon_node := CollisionPolygon2D.new()
		polygon_node.polygon = in_array[i]
		$Walls.add_child(polygon_node)


func _ready() -> void:
	create_collision_polygon()

