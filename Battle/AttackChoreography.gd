extends Node
class_name Choreography

enum {
	SLEEP,
	ATTACK
}

export (String, FILE) var default_path

onready var timer = $Timer


class Action:
	var type
	var args: Dictionary
	var chor: Choreography
	func _init(chor: Choreography, type, args: Dictionary):
		self.type = type
		self.args = args
		self.chor = chor
	
	func exec():
		match type:
			SLEEP:
				chor.timer.wait_time = self.args["time"]
				chor.timer.connect("timeout", chor, "next_inst")
				chor.timer.start()
			ATTACK:
				var attack: BaseAttack = args["atk"]
				attack.connect("attack_done", chor, "next_inst")
				attack.start()


var available_attacks: Dictionary = {}
var current_inst = 0
var execution_order: Array = []

func _ready() -> void:
	for child in get_children():
		available_attacks[child.name] = child
	load_script(default_path)

func load_script(path) -> void:
	var file: File = File.new()
	file.open(path, File.READ)
	var play_by_play: Array = file.get_as_text().split("\n")
	file.close()
	for line in play_by_play:
		var words: Array = line.split(" ")
		if words[0].to_lower() == "sleep":
			var time: float = words[1] as int
			execution_order.append(Action.new(self, SLEEP, {"time": time}))
		elif words[0] in available_attacks.keys():
			var attack: BaseAttack = available_attacks[words[0]]
			execution_order.append(Action.new(self, ATTACK, {"atk": attack}))

func next_inst():
	pass
