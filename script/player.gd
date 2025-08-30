extends CharacterBody2D
class_name Player

@onready var character := $Kyoto

@export var current_character := "kyoto"

var max_speed := 100.0
var acceleration := 400.0
var friction := 600.0
var last_direction := "f"  # for idle direction (f = front, b = back, r = right)

var triggered := true

func _physics_process(delta):
	var input_direction := Vector2.ZERO
	var anim := ""
	if current_character == "kyoto":
		$Kyoto.visible = true
		$Chilfie.visible = false
		character = $Kyoto
	elif current_character == "chilfie":
		$Chilfie.visible = true
		$Kyoto.visible = false
		character = $Chilfie
		
	if Input.is_action_just_pressed("p"):
		if triggered:
			current_character = "chilfie"
			triggered = false
		else:
			triggered = true
			current_character = "kyoto"

	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
	elif Input.is_action_pressed("move_left"):
		input_direction.x -= 1

	if Input.is_action_pressed("move_down"):
		input_direction.y += 1
	elif Input.is_action_pressed("move_up"):
		input_direction.y -= 1

	if velocity.length() < 5:
		#print(input_direction.y)
		character.play("idle_" + last_direction)
	else:
		if abs(input_direction.x) > abs(input_direction.y):
			anim = "walk_r"
			character.flip_h = input_direction.x < 0
			last_direction = "r"
		else:
			if input_direction.y > 0:
				anim = "walk_f"
				last_direction = "f"
			elif input_direction.y < 0:
				anim = "walk_b"
				last_direction = "b"
		
		character.play(anim)
		
	input_direction = input_direction.normalized()

	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	move_and_slide()
