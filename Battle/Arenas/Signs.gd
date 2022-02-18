extends Node2D

export(StreamTexture) var down
export(StreamTexture) var up

func _ready() -> void:
	toggle(false)
	
func toggle(value: bool) -> void:
	if value:
		$"0".texture = down
		$"1".texture = down
	else:
		$"0".texture = up
		$"1".texture = up
	
