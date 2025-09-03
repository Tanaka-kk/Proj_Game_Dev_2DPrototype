extends Node2D

var area_trigger_story

func _ready() -> void:
	area_trigger_story = get_children()
	for story in area_trigger_story:
		print(area_trigger_story[0].get_children())
