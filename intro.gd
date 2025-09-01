extends Node

func _ready() -> void:
	$Character_Dialog_Layer.visible = false
	$BlackBackground.visible = true
	await get_tree().create_timer(1).timeout
	for i in 11:
		$BlackBackground.modulate.a = 1 - (0.1*i)
		await get_tree().create_timer(0.15).timeout
	await get_tree().create_timer(1.8).timeout
	$Character_Dialog_Layer.visible = true
