extends Node

@onready var frame = $"."
@onready var label_text_dialog = $text_dialog_bag/Label
@onready var bg = $dialogue_background
@onready var pic_pro = $Profile_picture/char_profile
@onready var vbox = $VBoxContainer
@onready var label_char_name = $Profile_picture/Label

signal choice_selected(choice_index)


var in_progress = false
var timeline
var answer
var conver
var selected_event
var select_

var sub_dialog 
var sub_sub_dialog_pro = false
var select_sd
var key_id = ""
var mode = ""
var wait_transform = false

func _ready() -> void:
	timeline = DialogLoader.json_data['dialog_timeline']['content']
	answer = DialogLoader.json_data['dialog_ans_id']['content']
	conver = DialogLoader.json_data['dialog_con_id']['content']
	frame.hide()
	SignalBusser.connect("display_char_dialog",display_con)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and !wait_transform:
		if key_id != "":
			display_con(key_id)
	if event.is_action_pressed("skip"):
		finish()

func display_con(key_id_time_line):
	key_id = key_id_time_line
	if in_progress:
		if sub_dialog.size() > 0:
			next_conver()
			pic_pro.stop()
		elif selected_event.size() > 0:
			process_text()
		else:
			finish()
	else:
		frame.visible = true
		get_tree().paused = true
		in_progress = true
		bg.visible = true
		selected_event = timeline[key_id_time_line].duplicate()
		process_text()

func process_text():
	select_ = selected_event.pop_front()
	if select_.split("_")[0] == "AN":
		sub_dialog = answer[select_]["answer_ch"].duplicate()
		answer_text()
	elif select_.split("_")[0] == "ITEM":
		SignalBusser.emit_signal("give_item", select_)
	elif select_ == "fin":
		finish()
	else:
		if select_.split("_")[2] == "NA":
			narater_mode()
		elif select_.split("_")[2] == "CN":
			dialog_mode()
		if select_.split("_")[-1] == "KC":
			SignalBusser.emit_signal("cut_sence")
			
		sub_dialog = conver[select_]["dialog"].duplicate()
		conver_text()

func conver_text():
	
	select_sd = sub_dialog.pop_front()
	label_text_dialog.text = select_sd['line']
	var char_eng_name = matcher(select_sd["char"])
	if char_eng_name == "":
		pic_pro.visible = false
		label_char_name.text = ''
	else:
		pic_pro.visible = true
		pic_pro.play(char_eng_name)
		label_char_name.text = char_eng_name
	
func next_conver():
	if sub_dialog.size() > 0:
		sub_sub_dialog_pro = true
		conver_text()
	else:
		sub_sub_dialog_pro = false
		
func answer_text():
	SignalBusser.disconnect("display_char_dialog", display_con)
	for ind in range(sub_dialog.size()):
		var butt = Button.new()
		butt.text = sub_dialog[ind]['label']
		butt.pressed.connect(on_choice_selected.bind(sub_dialog[ind]["connect"]))
		vbox.add_child(butt)
	vbox.show()
	
func on_choice_selected(con):
	SignalBusser.connect("display_char_dialog", display_con)
	for child in vbox.get_children():
		if child is Button:
			child.queue_free()
	selected_event.append(con)
	process_text()

func finish():
	get_tree().paused = false
	in_progress = false
	frame.visible = false
	bg.visible = false
	SignalBusser.emit_signal("finish_dia")
	wait_transform = true

func matcher(thai_name: String):
	match thai_name:
		"เรียว": return "ryou"
		"จูเลียส": return "julius"
		"เร็นเบล": return "renbel"
		"เคียว": return "kyoto"
		"เดลม่อน": return "delmon"
		"ชิลฟี่": return "chilfie"
		"ริโกะ": return "Riko"
		"เทพชะตา": return "xxx"
		"บรรณารักษ์": return "xxx"
		"": return ""
		
func narater_mode():
	mode = "NA"
	$dialogue_background.hide()
	$text_dialog_bag.hide()
	$Profile_picture.hide()
	$narater_dialog.show()
	label_text_dialog = $narater_dialog/Label
	
	
func dialog_mode():
	mode = "CN"
	$dialogue_background.show()
	$text_dialog_bag.show()
	$Profile_picture.show()
	$narater_dialog.hide()
	label_text_dialog = $text_dialog_bag/Label
	
