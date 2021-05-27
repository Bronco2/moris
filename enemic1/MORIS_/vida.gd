extends TextureProgress

var pendent_vida : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$text_vida.text = str(500)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Moris_canvi_vida(nova_vida):
	var vida = value
	if not pendent_vida:
		$Tween.interpolate_property(self, "value", vida, nova_vida, 1)
		$Tween.start()
		pendent_vida = true
		$text_vida.text = str(nova_vida)

func _on_Tween_tween_completed(object, key):
	pendent_vida = false
