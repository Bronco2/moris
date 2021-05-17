extends Control



func _process(delta):
	if Input.is_action_just_pressed("pausa"):
		get_tree().paused = true
		visible = true


func _on_Torna_al_menu_pressed(): 
	get_tree().change_scene("res://pantalla_inici.tscn")
	get_tree().paused = false
#com que encara no hi ha cap varable diferent no passa res però haure de
#anar a la scrip global per posar la vidaa el mana i l'escut com el principi
#també hem de veure si canviara alguna cosa dels enemigos


func _on_Continua_pressed():
	get_tree().paused = false
	visible = false
