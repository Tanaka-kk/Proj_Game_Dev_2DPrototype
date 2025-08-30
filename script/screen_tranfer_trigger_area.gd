extends Area2D

class_name Screen_trigger

@export var connect_scene: String #name sence
var sence_floder = "res://Scene/"

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SenceManager.change_screen(get_owner(), connect_scene)
