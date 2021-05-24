extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	Global.Escut = false

func _on_Button_JUGAR_pressed():
	get_tree().change_scene("res://bosc2.tscn")


func _on_Button_CONTROLS_pressed():
	get_tree().change_scene("res://pantalla_controls.tscn")


func _on_Button_INFO_pressed():
	get_tree().change_scene("res://pantalla_info.tscn")
