extends KinematicBody2D

var velocitat = Vector2(0,0)
var velocitat_max = 300
var pot_atacar = true
var pot_caminar = false
var tocat = true
var pot_moure = true
var animant = "Les animacions no funcionen"
var num_vida = ""


func _ready():
	pass


func _process(delta):
	if pot_moure:
		if pot_caminar:
			if tocat:
				velocitat += Vector2.LEFT * velocitat_max
			if tocat == false:
				velocitat += Vector2.RIGHT * velocitat_max
	velocitat = move_and_slide(velocitat)
	
	$Label.text = animant

func animacio(pot_caminar, pot_atacar): #les animacions encara que no estiguin tmp funcionen
	if velocitat.length() == 0:
		$AnimatedSprite.play("iddle")
		animant = "Quiet"
	if pot_caminar:
		if velocitat.x > 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("caminant")
			animant = "caminant_dreta"
		if velocitat.x < 0:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("caminant")
			animant = "caminant_esq"
	if pot_atacar:
		$AnimatedSprite.play("caminant")	#canviar a animar l'atac pero encara no ho tenim
		animant = "atacant"

func enemic():
	pass


#crear una funcio dentrar i sortir i amb un contador de mentre estigui dins 
#anar-se morint, quan surti deixara de morir (recomancacio del jordi:rep_mal)
func _on_Area2D_body_entered(body):
	if body.has_method("personatge"):
		if Global.Escut == true:
			body.vida += 20
		body.vida -= 50




func _on_radar_body_entered(body):
	visible = true
	pot_caminar = true

func _on_rebot_dret_body_entered(body):
	if body.has_method("enemic"):
		pot_moure = false
		velocitat = Vector2(0,0)
		$timer_movent.start()
		tocat = true


func _on_rebot_esquerra_body_entered(body):
	if body.has_method("enemic"):
		pot_moure = false
		velocitat = Vector2(0,0)
		$timer_movent.start()
		tocat = false


func _on_timer_movent_timeout():
	pot_moure = true

