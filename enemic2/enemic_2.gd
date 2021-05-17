extends KinematicBody2D


var pot_disparar = true
var vida = 100
var on_disparar = "esq"

func _ready():
	pass



func _process(delta):
	if visible == true:
		if pot_disparar == true:
			$timer_bala.start()
			dispara()
	$vida.text = str(vida)
	mort()

func enemic():
	pass

func mort():
	if vida <= 0:
		queue_free()

func dispara():
	var escena_bala = load("res://enemic2/bala.tscn") #puges escena
	var nova_bala = escena_bala.instance()
	nova_bala.global_position = global_position #canvies la posicio aon esta el persontge(icona)
	if on_disparar == "esq":
		nova_bala.direccio = Vector2.LEFT
	if on_disparar == "dreta":
		nova_bala.direccio = Vector2.RIGHT
	#no fer get_parent().add_child(nova_bala) pq sino la bala es maura igual que l'icona.
	Global.bales.add_child(nova_bala)
	#Per que l'atac especial no funcioni sempre 
	pot_disparar = false


func _on_timer_bala_timeout():
	pot_disparar = true


func _on_radar_esq_body_entered(body):
	visible = true
	pot_disparar = true
	on_disparar = "esq"


func _on_radar_dret_body_entered(body):
	visible = true
	pot_disparar = true
	on_disparar = "dreta"

