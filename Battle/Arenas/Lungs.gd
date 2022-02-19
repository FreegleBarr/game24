extends "res://Battle/Arenas/Arena.gd"

export var strength: float = 0.1

var inhaling := false

onready var contour = $Organ/Contour
onready var bg = $Organ/BG/BGMap

func _ready() -> void:
	bg.play('out')
	contour.play('out')

func _on_BreathTimer_timeout() -> void:
	inhaling = not inhaling
	$Organ/Emmitters.toggle()
	$Organ/Signs.toggle(inhaling)
	$Organ/LeftCollision/Strong1.disabled = true
	$Organ/LeftCollision/Strong2.disabled = true
	$Organ/RightCollision/Strong1.disabled = true
	$Organ/RightCollision/Strong2.disabled = true
	$Organ/LeftCollision/Weak1.disabled = false
	$Organ/LeftCollision/Weak2.disabled = false
	$Organ/RightCollision/Weak1.disabled = false
	$Organ/RightCollision/Weak2.disabled = false
	
	if inhaling:
		bg.play('in')
		contour.play('in')
	else:
		bg.play('out')
		contour.play('out')

func _physics_process(delta: float) -> void:
	var force = Vector2(0,-1)*strength
	if inhaling:
		force *= -1
	$Player.apply_force(force)


func _on_Contour_animation_finished() -> void:
	$Organ/LeftCollision/Strong1.disabled = not inhaling
	$Organ/LeftCollision/Strong2.disabled = not inhaling
	$Organ/RightCollision/Strong1.disabled = not inhaling
	$Organ/RightCollision/Strong2.disabled = not inhaling

	$Organ/LeftCollision/Weak1.disabled = not inhaling
	$Organ/LeftCollision/Weak2.disabled = not inhaling
	$Organ/RightCollision/Weak1.disabled = not inhaling
	$Organ/RightCollision/Weak2.disabled = not inhaling
