extends Node2D

var area_trigger_story
var coll_list = []
var event_index = 0
var select_: CollisionShape2D
var past_select: CollisionShape2D
var trigger = 0
var trig = true

func _ready() -> void:
	area_trigger_story = get_children()
	activate_event()

func _process(delta: float) -> void:
	if area_trigger_story.size() > event_index:
		if area_trigger_story[event_index].area_active:
			area_trigger_story[event_index].area_active = false
			recive_signal()
		
func activate_event():
	if area_trigger_story.size() > event_index:
		select_ = area_trigger_story[event_index].get_children()[1].get_children()[0]
		select_.disabled = false
		past_select = select_
		
func recive_signal():
	past_select.disabled = true
	event_index += 1
	if event_index == 2:
		$"../BlackBackground".visible = true
	activate_event()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Skip") and event_index == 1:
		if trigger >= 20 or trig:
			trigger = 0
			trig = false
			
		match trigger:
			0:
				$"../delmon/AnimatedSprite2D".play("idle_f")
			2:
				AudioManager.play("DoorKnocking")
			5:
				AudioManager.play("DoorOpen")

		trigger += 1
		
		
	elif event.is_action_pressed("Skip") and event_index == 2:
		if trigger >= 20 or !trig:
			trigger = 0
			trig = true
			
		elif trigger == 1:
			$"../BlackBackground".visible = false
			$"../player".position = Vector2(500,450)
			$"../player".current_character = "kyoto"
			$"../player".last_direction = "r"
			$"../ryou".position = Vector2(500,425)
			$"../ryou".visible = true
			$"../ryou/AnimatedSprite2D".play("idle_f")
			$"../chilfie".position = Vector2(525,450)
			$"../chilfie".visible = true
			$"../chilfie/AnimatedSprite2D".play("idle_r")
			$"../chilfie/AnimatedSprite2D".flip_h = true
		elif trigger == 5:
			$"../julius".visible = true
			
			
		else:
			trigger += 1
