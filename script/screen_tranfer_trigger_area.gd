extends Area2D

class_name Screen_trigger

@export var connect_scene: String #name sence
var sence_floder = "res://Sence/"

func _on_body_entered(body: Node2D) -> void:
	print("Check")
	if body is Player:
		print("Check_2")
		SenceManager.change_screen(get_owner(), connect_scene)
