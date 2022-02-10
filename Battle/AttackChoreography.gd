extends Node
class_name Choreography

signal fight_over

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
				chor.timer.start()
			ATTACK:
				print("attacking with attack " + str(args["atk"]))
				var attack: BaseAttack = args["atk"]
				attack.start(args["args"])


var available_attacks: Dictionary = {}
var current_inst = 0
var execution_order: Array = []

func _ready() -> void:
	for child in get_children():
		if child == timer:
			continue
		available_attacks[child.name] = child
		child.connect("attack_done", self, "next_inst")
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
			if len(words) == 1:
				execution_order.append(Action.new(
					self, 
					ATTACK, 
					{"atk": attack, "args": []}
				))
			else:
				execution_order.append(Action.new(
					self, 
					ATTACK, 
					{"atk": attack, 
					"args": words.slice(1, len(words) - 1)}
				))

func start():
	print("h")
	current_inst = 0
	next_inst()

func next_inst():
	current_inst += 1
	if current_inst > len(execution_order):
		emit_signal("fight_over")
		return
	execution_order[current_inst - 1].exec()

