extends Node2D

var keyy = "Ch1_03"

func _ready() -> void:
	$"../delmon/AnimatedSprite2D".play("idle_b")
	$"../julius/AnimatedSprite2D".play("idle_b")
	$"../kyoto/AnimatedSprite2D".play("idle_f")
	$"../renbel/AnimatedSprite2D".play("idle_f")
	$"../ryou/AnimatedSprite2D".play("idle_f")
	$"../delmon".visible = true
	$"../julius".visible = true
	$"../kyoto".visible = true
	$"../renbel".visible = true
	$"../ryou".visible = true
	$"../player".last_direction = "b"
	
	#await get_tree().create_timer(4).timeout
	#activate_sig()
	
func activate_sig():
	SignalBusser.emit_signal("display_char_dialog", keyy)
