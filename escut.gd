extends Sprite


func _ready():
	pass # Replace with function body.


func _process(delta):
	pass





func _on_Area2D_body_entered(body):
	if body.has_method("personatge"):
		Global.Escut = true
		queue_free()
