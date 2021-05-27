extends Sprite


func _ready():
	pass 


func _process(delta):
	if Global.Escut == false:
		visible = false
	else:
		visible = true
