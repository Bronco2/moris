extends Control




func _process(delta):
	if Input.is_action_just_pressed("controls"):
		get_tree().paused = true
		visible = true



func _on_Torna_pressed():
	visible = false
	get_tree().paused = false
