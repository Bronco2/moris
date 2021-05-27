extends Control

var menys_oxigen = false
var contador = 1

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Moris_oxigen(no_esta_aigua):
	while no_esta_aigua == false:
		visible = true
		$Timer.start()
		if menys_oxigen == true:
			if contador == 1:
				$bombi_8.visible = false
				contador += 1
				menys_oxigen = false
			elif contador == 2:
				$bombi_7.visible = false
				contador += 1
				menys_oxigen = false
			elif contador == 3:
				$bombi_6.visible = false
				contador += 1
				menys_oxigen = false
			elif contador == 4:
				$bombi_5.visible = false
				contador += 1
				menys_oxigen = false
			elif contador == 5:
				$bombi_4.visible = false
				contador += 1
				menys_oxigen = false
			elif contador == 6:
				$bombi_3.visible = false
				contador += 1
				menys_oxigen = false
			elif contador == 7:
				$bombi_2.visible = false
				contador += 1
				menys_oxigen = false
			elif contador == 8:
				$bombi_1.visible = false
				contador += 1
				menys_oxigen = false
	if no_esta_aigua == true:
		visible = false
		$bombi_1.visible = true
		$bombi_2.visible = true
		$bombi_3.visible = true
		$bombi_4.visible = true
		$bombi_5.visible = true
		$bombi_6.visible = true
		$bombi_7.visible = true
		$bombi_8.visible = true
			

func _on_Timer_timeout():
	menys_oxigen = true
