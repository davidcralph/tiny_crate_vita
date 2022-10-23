extends Node2D

var menu_list : Label
var menu_items := []

onready var main_list : Label = $Menu/List
var main_items := ["play", "options", "credits"]

var cursor := 0

var timer := 0.1
var clock := 0.0

onready var node_cursor : ColorRect = $Menu/Cursor
onready var node_audio_scroll : AudioStreamPlayer = $AudioScroll
onready var node_audio_play : AudioStreamPlayer = $AudioPlay
onready var node_audio_options : AudioStreamPlayer = $AudioOptions
onready var node_audio_credits : AudioStreamPlayer = $AudioCredits

var is_input = true

func _ready():
	menu_list = main_list
	switch_menu("main")
	UI.keys(true, false)

func _input(event):
	if !is_input:
		return
	elif event.is_action_pressed("jump"):
		menu_select()
	else:
		var up = event.is_action_pressed("up") or event.is_action_pressed("left")
		var down = event.is_action_pressed("down") or event.is_action_pressed("right")
		if up or down:
			cursor = clamp(cursor + (-1 if up else 1), 0, menu_items.size() - 1)
			write_menu()
			node_audio_scroll.pitch_scale = 1 + rand_range(-0.2, 0.2)
			node_audio_scroll.play()

func write_menu():
	menu_list.text = ""
	for i in menu_items.size():
		if cursor == i:
			menu_list.text += "-" + menu_items[i] + "-" + "\n"
			node_cursor.rect_position.y = -1 +  i * 11
			node_cursor.rect_position.x = 0
			node_cursor.rect_size.x = menu_list.rect_size.x - 1
		else:
			menu_list.text += menu_items[i] + "\n"

func menu_select():
	match menu_items[cursor].to_lower():
		"play":
			Shared.wipe_scene(Shared.level_select_path)
			is_input = false
			node_audio_play.play()
		"options":
			Shared.wipe_scene(Shared.options_menu_path)
			is_input = false
			node_audio_options.play()
		"credits":
			Shared.wipe_scene(Shared.credits_path)
			is_input = false
			node_audio_credits.play()

func switch_menu(arg):
	cursor = 0
	match arg:
		"main":
			menu_list = main_list
			menu_items = main_items
			
			node_cursor.get_parent().remove_child(node_cursor)
			main_list.add_child(node_cursor)
	write_menu()
