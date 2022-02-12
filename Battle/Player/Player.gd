extends KinematicBody2D

signal died
signal hp_changed(value)

export var move_speed = 400

var dead: bool = false

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
		#TODO: die
		emit_signal("died")
		die()

func _ready() -> void:
	self.hp = max_hp
	
var velocity: Vector2
func _physics_process(delta: float) -> void:
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if dead:
		pass
	elif velocity:
		playback.travel("Move")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Move/blend_position", velocity)
		move_and_slide(velocity * move_speed)
	else:
		playback.travel("Idle")

func die():
	playback.travel("Dead")
	dead = true
	$Collision.disabled = true
	$Hurtbox/Collision.disabled = true


func _on_Button_button_down() -> void:
	self.hp = -9999


func _on_Hurtbox_area_entered(area: Projectile) -> void:
	area.contact()
	self.hp -= 1
