extends AnimatedSprite

export(StreamTexture) var background

func create_collision_polygon():
	var bm = BitMap.new()
	var frame_texture = get_sprite_frames().get_frame(animation, get_frame())
	bm.create_from_image_alpha(frame_texture.get_data())
	var rect = Rect2(0, 0, frame_texture.get_width(), frame_texture.get_height())
	var out_array = bm.opaque_to_polygons(rect)
	var bm2 = BitMap.new()
	bm2.create_from_image_alpha(background.get_data())
	var in_array = bm2.opaque_to_polygons(rect)
	var texture_offset = Vector2(frame_texture.get_width(), frame_texture.get_height())
	var out_pool_array = PoolVector2Array()
	var in_pool_array = PoolVector2Array()
	
	for j in range(out_array[0].size()):
		out_pool_array.append(out_array[0][j]-texture_offset/2)
	for i in range(in_array[0].size()):
		in_pool_array.append(in_array[0][i]-texture_offset/2)
#	out_pool_array.remove(-1)
	var in_pool_reverse = PoolVector2Array()
	var size = in_pool_array.size()
	for i in range(size):
		in_pool_reverse.append(in_pool_array[size-i-1])
	var closest_idx = 0
	var closest_length = (out_pool_array[0]-in_pool_array[0]).length()
	in_pool_reverse.append(in_pool_reverse[0])
	for i in range(1, out_pool_array.size()):
		var length = (out_pool_array[i]-in_pool_array[0]).length()
		if length <= closest_length:
			closest_length = length
			closest_idx = i
	print(closest_idx)
	for i in range(closest_idx, out_pool_array.size()):
		in_pool_reverse.append(out_pool_array[i])
	out_pool_array.resize(closest_idx)
	in_pool_reverse.append_array(out_pool_array)
#	in_pool_reverse.append_array(out_pool_array)
	print(out_pool_array.size())
#	in_pool_reverse.resize(in_pool_reverse.size()-1)
	
	$Walls/CollisionPolygon2D.polygon = in_pool_reverse


func _ready() -> void:
	Battle.background = background
	create_collision_polygon()

