extends Node2D

var area_trigger_story
var coll_list = []
var event_index = 0
var select_: CollisionShape2D
var past_select: CollisionShape2D

func _ready() -> void:
	area_trigger_story = get_children()
	activate_event()

func _process(delta: float) -> void:
	if area_trigger_story.size() > event_index:
		if area_trigger_story[event_index].area_active:
			recive_signal()
		
func activate_event():
	if area_trigger_story.size() > event_index:
		select_ = area_trigger_story[event_index].get_children()[1].get_children()[0]
		select_.disabled = false
		past_select = select_

func recive_signal():
	past_select.disabled = true
	event_index += 1
	activate_event()
