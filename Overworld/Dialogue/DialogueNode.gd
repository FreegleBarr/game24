extends Node

onready var dialogueText = $CanvasLayer/Control/Speechbubble/DialogueText

func _ready():
	dialogueText.scroll_to_line(0)
	dialogueText.percent_visible = 0

	var dialogue : Dictionary = JSON.parse(json).result
	for i in dialogue.keys():
		print("%s : %s" % [i, dialogue[i]])



func _process(delta):
#	if dialogueText.percent_visible != 1:
#		dialogueText.percent_visible += 0.003
	pass
