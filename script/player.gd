extends CharacterBody2D

class_name Player
var movement_speed = 500

func _physics_process(delta: float) -> void:
	var char_direc = Input.get_vector('move_left','move_right',"move_up","move_down")
	velocity = char_direc * movement_speed
	
	if char_direc.x < 0:
		$Sprite2D.flip_h = false
	elif char_direc.x > 0:
		$Sprite2D.flip_h = true
	move_and_slide()
