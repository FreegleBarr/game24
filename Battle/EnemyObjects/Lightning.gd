extends Node2D

var has_zapped := false

func contact():
	if has_zapped: return false
	has_zapped = true
	print("Zap!")
	
func _on_LightningSprite_animation_finished():
	get_parent().call_deferred("remove_child", self)
	pass
