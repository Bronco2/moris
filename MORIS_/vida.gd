extends TextureProgress

var pendent_vida : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Moris_canvi_vida(nova_vida):
	var vida = value
	if not pendent_vida:
		$Tween.interpolate_property(self, "value", vida, nova_vida, 1)
		$Tween.start()
		pendent_vida = true


func _on_Tween_tween_completed(object, key):
	pendent_vida = false
