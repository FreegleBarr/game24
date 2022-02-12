extends Sprite

export(StreamTexture) var Walls

func create_collision_polygon():
	var bm = BitMap.new()
	var frame_texture = get_sprite_frames().get_frame(animation, get_frame())
	bm.create_from_image_alpha(frame_texture.get_data())
	var in_array = bm2.opaque_to_polygons(rect)
	
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
	create_collision_polygon()

