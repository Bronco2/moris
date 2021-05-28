extends Control



func _process(delta):
	if Input.is_action_just_pressed("pausa"):
		get_tree().paused = true
		visible = true


func _on_Torna_al_menu_pressed(): 
	get_tree().change_scene("res://pantalla_inici.tscn")
	get_tree().paused = false


func _on_Continua_pressed():
	get_tree().paused = false
	visible = false


func _on_sortir_pressed():
	get_tree().quit()
