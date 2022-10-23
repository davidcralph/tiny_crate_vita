extends Node2D

onready var audio = $AudioStreamPlayer

var is_selected = false

func select():
	is_selected = true

func deselect():
	is_selected = false
