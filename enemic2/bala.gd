extends Sprite

var direccio = Vector2.RIGHT
var velocitat = 300



func _ready():
	pass # Replace with function body.



func _process(delta):
	position += direccio * velocitat * delta #com es mou la bala
	if velocitat > 0:
		flip_h = true
	if velocitat < 0:
		flip_h = false


func _on_Area2D_body_entered(body):
	queue_free()
	if body.has_method("personatge"):
			body.vida -= 50
