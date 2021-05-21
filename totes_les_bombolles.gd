extends Sprite

var contador = 1

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Moris_oxigen(no_esta_aigua, contador):
	if no_esta_aigua == false:
		visible = true
		if contador == 1:
			$bombi_8.visible = false
		if contador == 3:
			$bombi_7.visible = false
		if contador == 5:
			$bombi_6.visible = false
		if contador == 7:
			$bombi_5.visible = false
		if contador == 9:
			$bombi_4.visible = false
		if contador == 11:
			$bombi_3.visible = false
		if contador == 13:
			$bombi_2.visible = false
		if contador == 15:
			$bombi_1.visible = false
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

