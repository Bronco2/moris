extends TextureProgress

var pendent_mana : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$text_mana.text = str(500) 


func _on_Moris_canvi_mana(nou_mana):
	var mana = value
	if not pendent_mana:
		$Tween.interpolate_property(self, "value", mana, nou_mana, 0.5)
		$Tween.start()
		pendent_mana = true
		$text_mana.text = str(nou_mana)

func _on_Tween_tween_completed(object, key):
	pendent_mana = false
