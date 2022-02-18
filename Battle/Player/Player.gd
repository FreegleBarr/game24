extends KinematicBody2D
class_name Player

signal died
signal hp_changed(value)

export var move_speed = 400
export var ghost_time: float = 2

var dead := false
var ghosting := false
var invuln := false

onready var playback = $AnimationTree.get('parameters/playback')

export var max_hp = 3 setget change_max_hp
func change_max_hp(value):
	max_hp = min(value, 0)
	#call hp setter
	self.hp = min(hp, max_hp)


#do not onready
var hp setget change_hp
func change_hp(value):
	hp = min(max_hp, value)
	emit_signal("hp_changed", hp)
	if hp <= 0:
		die()

func _ready() -> void:
	self.hp = max_hp
	Battle.player = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		ghost()

var total_force := Vector2()
func apply_force(force: Vector2):
	total_force += force

var velocity: Vector2
func _physics_process(_delta: float) -> void:
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	velocity += total_force
	total_force = Vector2()
	if dead:
		pass
	elif velocity.length():
		if velocity.x > 0:
			$Sprite.flip_h = false
		elif velocity.x < 0:
			$Sprite.flip_h = true
		velocity = move_and_slide(velocity * move_speed)

func die():
	#TODO: die
	emit_signal("died")
	playback.travel("Dead")
	dead = true
	$Collision.set_deferred("disabled", true)
	$Hurtbox/Collision.set_deferred("disabled", true)

func ghost():
	if $GhostCooldown.is_stopped() and not ghosting:
		$Sprite.material.set('shader_param/ghosting', true)
		ghosting = true
		$Hurtbox/Collision.set_deferred("disabled", true)
		$GhostTimer.start()

func end_ghost() -> void:
	if ghosting:
		$GhostCooldown.start()
		$Sprite.material.set('shader_param/ghosting', false)
		ghosting = false
		$Hurtbox/Collision.set_deferred("disabled", false)

func end_invuln() -> void:
	if not dead:
		invuln = false
		$Hurtbox/Collision.set_deferred("disabled", false)


func _on_Button_button_down() -> void:
	self.hp = -9999


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	area.owner.contact()
	playback.travel("Hurt")
	$InvulnTimer.start()
	$Hurtbox/Collision.set_deferred("disabled", true)
	invuln = true
	self.hp -= 1
