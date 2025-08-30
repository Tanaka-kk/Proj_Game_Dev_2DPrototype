extends Node

class_name BaseScene

@onready var player: Player = $player
@onready var enter_mark: Node2D = $Enter_mark_point

func _ready():
	if SenceManager.player:
		if player:
			player.queue_free()
			
		player = SenceManager.player
		add_child(player)
		position_player()
	
func position_player():
	var last_sence = SenceManager.last_scene_name
	if last_sence.is_empty():
		last_sence = "any"
	print(last_sence, " LLLLLKKNLKNL")
	for entrance in enter_mark.get_children():
		print(entrance.name)
		if entrance is Marker2D and entrance.name == last_sence:
			print("Im in for")
			player.global_position = entrance.global_position
			print(player.position.x, player.position.y)
