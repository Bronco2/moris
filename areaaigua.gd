extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Global.Moris, 'entraaaigua', [Global.Moris])
	connect("body_exited", Global.Moris, 'surtdaigua', [Global.Moris])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	pass # Replace with function body.
