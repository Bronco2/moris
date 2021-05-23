extends Node2D

#var target = KinematicBody2D
var target = KinematicBody2D

func _ready():
	pass 



func _on_SIGHT_body_entered(body):
	if body.has_method('personatge'):
		target = body 
	pass
