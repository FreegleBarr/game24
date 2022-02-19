extends VBoxContainer

func change_hp(value):
	var currentHP = get_node_or_null(str(value+1))
	if currentHP:
		currentHP.hurt()
