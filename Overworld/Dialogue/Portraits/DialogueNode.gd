extends Node

var new_dialog = Dialogic.start('Test Timeline')


func _ready():
	add_child(new_dialog)
