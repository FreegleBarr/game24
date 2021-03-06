extends Node
class_name Choreography

signal fight_over
signal script_loaded(time)

enum Type {
	SLEEP,
	ATTACK,
	NEW_CHOR
}

export (Resource) var choreography_steps

onready var timer = $Timer

const modifiers = ["nowait"]
var available_attacks: Dictionary = {}
var available_subchors: Dictionary = {}
var current_inst = 0
var execution_order: Array = []
var active_actions: int = 0
var active_subchors: int = 0
var total_time: float = 0
var nowait_time: float = -1

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
			Type.SLEEP:
				chor.active_actions += 1
				chor.timer.wait_time = self.args["time"]
				chor.timer.start()
			Type.ATTACK:
				chor.active_actions += 1
				print("attacking with attack " + str(args["atk"]))
				var attack: BaseAttack = args["atk"]
				if "nowait" in args["mods"]:
					chor.next_inst()
				attack.start(args["args"])
			Type.NEW_CHOR:
				print("starting new choreography")
				chor.active_actions += 1
				chor.active_subchors += 1
				args["subchor"].start()
				chor.attack_done()
				
	func time() -> float:
		match type:
			Type.SLEEP:
				return self.args["time"]
			Type.ATTACK:
				var attack: BaseAttack = args["atk"]
				return attack.time(args["args"])
			Type.NEW_CHOR:
				return args["subchor"].time()
			_: #only so godot doesn't complain
				return 0.0
	




func _ready() -> void:
	for child in get_children():
		if child.has_method('is_attack'):
			available_attacks[child.name] = child
			child.connect("attack_done", self, "attack_done")
			if Battle.projectile_manager:
				child.connect("spawn_bullet", Battle.projectile_manager, "_on_spawn_bullet")
		if child.has_method('is_chor'):
			available_subchors[child.name] = child
			child.connect("fight_over", self, 'subchor_done')
	load_script(choreography_steps)

func load_script(choreography_steps) -> void:
	var play_by_play: Array = choreography_steps.steps.split("\n")
	total_time = 0
	for line in play_by_play:
		
		var raw_words: Array = line.split(" ")
		var words = []
		for word in raw_words:
			words.append(word.strip_edges())
		
		if words[0].to_lower() == "sleep":
			var time: float = words[1] as int
			total_time += time
			execution_order.append(Action.new(self, Type.SLEEP, {"time": time}))
		elif words[0].to_lower() == "start":
			var subchor: Choreography = available_subchors[words[1]]
			total_time += subchor.total_time
			execution_order.append(Action.new(self, Type.NEW_CHOR, {"subchor": available_subchors[words[1]]}))
		else:
			var mods: Array = []
			var attack: BaseAttack
			var args: Array = []
			var mod_section = true
			for word in words:
				assert(word != "", "Trailing whitespace")
				if mod_section:
					if word in modifiers:
						mods.append(word)
					else:
						attack = available_attacks[word]
						mod_section = false
				else:
					args.append(word)
					
			execution_order.append(Action.new(
				self,
				Type.ATTACK,
				{"atk": attack, "args": args, "mods": mods}
			))
			if 'nowait' in mods:
				if nowait_time == -1:
					nowait_time = attack.time(args)
#			if len(words) == 1:
#				execution_order.append(Action.new(
#					self, 
#					Type.ATTACK, 
#					{"atk": attack, "args": []}
#				))
#			else:
#				execution_order.append(Action.new(
#					self, 
#					Type.ATTACK, 
#					{"atk": attack, 
#					"args": words.slice(1, len(words) - 1)}
#				))
	time()

func time():
	total_time = 0
	var nowait_time: float = 0
	var subchor_time: float = 0
	for action in execution_order:
		action = action as Action
		var time = action.time()
		match action.type:
			Type.NEW_CHOR:
				subchor_time = max(time, subchor_time)
			Type.SLEEP, Type.ATTACK:
				if 'mods' in action.args and 'nowait' in action.args['mods']:
					nowait_time = max(nowait_time, time)
				else:
					if nowait_time > 0:
						time = max(nowait_time, time)
					nowait_time = 0
					total_time += time
					if subchor_time > 0:
						subchor_time -= time
						subchor_time = max(subchor_time, 0)
	total_time += subchor_time
	return total_time

func start():
	emit_signal("script_loaded", total_time)
	print(total_time)
	print("h")
	current_inst = 0
	next_inst()

func attack_done():
	active_actions -= 1
	if active_actions == 0:
		next_inst()

func subchor_done() -> void:
	active_subchors -= 1
	if current_inst > len(execution_order):
		if active_subchors == 0:
			emit_signal("fight_over")

func next_inst() -> void:
	current_inst += 1
	if current_inst > len(execution_order):
		if active_subchors == 0:
			emit_signal("fight_over")
		return
	execution_order[current_inst - 1].exec()


func is_chor() -> bool:
	return true
