extends CharacterBody2D
class_name Player

var max_speed := 200.0
var acceleration := 500.0
var friction := 500.0
var last_direction := "f"  # for idle direction (f = front, b = back, r = right)

func _physics_process(delta):
	var input_direction := Vector2.ZERO
	var anim := ""

	if Input.is_action_pressed("move_right"):
		input_direction.x += 1
	elif Input.is_action_pressed("move_left"):
		input_direction.x -= 1

	if Input.is_action_pressed("move_down"):
		input_direction.y += 1
	elif Input.is_action_pressed("move_up"):
		input_direction.y -= 1

	input_direction = input_direction.normalized()

	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(input_direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)

	if velocity.length() < 5:
		$AnimatedSprite2D.play("idle_" + last_direction)
	else:
		if abs(input_direction.x) > abs(input_direction.y):
			anim = "walk_r"
			$AnimatedSprite2D.flip_h = input_direction.x < 0
			last_direction = "r"
		else:
			if input_direction.y > 0:
				anim = "walk_f"
				last_direction = "f"
			else:
				anim = "walk_b"
				last_direction = "b"
		
		$AnimatedSprite2D.play(anim)

	move_and_slide()
