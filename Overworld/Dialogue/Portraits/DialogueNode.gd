extends Node

onready var dialogueLabel = $CanvasLayer/Control/Speechbubble/DialogueLabel

var dialogueLabelText setget setDialogueText
func setDialogueText(text):
	dialogueLabel.text = text

func _ready():
	_resetDialogueLabel()
	setDialogueText("texto que es muy largo para probar si se escribe todo de una")
	
func _process(delta):
	_advanceText()

	pass

func _resetDialogueLabel():
	dialogueLabel.scroll_to_line(0)
	dialogueLabel.percent_visible = 0
	
func _advanceText():
	if dialogueLabel.visible_characters != dialogueLabel.get_total_character_count():
		dialogueLabel.visible_characters +=1
		

