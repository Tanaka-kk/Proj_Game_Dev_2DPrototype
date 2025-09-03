extends Node2D
@onready var player: Player = $player

func _ready() -> void:
	await get_tree().process_frame
	if GlobalVal.current_state == "Floor2_Ch1":
		dialoc()
			
func dialoc() -> void:
	SignalBusser.emit_signal("display_char_dialog",GlobalVal.current_state)
	$"../julius/AnimatedSprite2D".play("idle_f")
	$"../julius".position = Vector2(795,450)
	$Charecter_Dialog_Area/Instant_area/CollisionShape2D.disabled = false
	if $Charecter_Dialog_Area.area_active and GlobalVal.current_state == "Floor2_Ch1":
		SignalBusser.emit_signal("display_char_dialog",GlobalVal.current_state)
		GlobalVal.current_state = ""
		$Charecter_Dialog_Area/Instant_area/CollisionShape2D.disabled = true
