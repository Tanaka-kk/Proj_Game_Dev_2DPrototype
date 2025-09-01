extends Node

@onready var frame = $"."
@onready var label = $text_dialog_bag/Label
@onready var bg = $dialogue_background
@onready var pic_pro = $Profile_picture/char_profile
@onready var vbox = $VBoxContainer

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

func _ready() -> void:
	timeline = DialogLoader.json_data['dialog_timeline']['content']
	answer = DialogLoader.json_data['dialog_ans_id']['content']
	conver = DialogLoader.json_data['dialog_con_id']['content']
	
	SignalBusser.connect("display_char_dialog",display_con)

func display_con(key_id_time_line):
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
		sub_dialog = conver[select_]["dialog"].duplicate()
		conver_text()

func conver_text():
	
	select_sd = sub_dialog.pop_front()
	label.text = select_sd['line']
	pic_pro.visible = true
	pic_pro.play(select_sd["char"])
	
func next_conver():
	if sub_dialog.size() > 0:
		sub_sub_dialog_pro = true
		conver_text()
	else:
		sub_sub_dialog_pro = false
		
func answer_text():
	SignalBusser.disconnect("display_char_dialog", display_con)
	for ind in range(sub_dialog.size()):
		print(ind)
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
	print(selected_event)
	process_text()

func finish():
	get_tree().paused = false
	in_progress = false
	frame.visible = false
	bg.visible = false
