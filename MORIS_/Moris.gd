extends KinematicBody2D



var velocitat = Vector2(0,0)
var velocitat_max = 900
var gravetat = 100
var gravetat_normal = 100
var no_esta_aigua = true
var salt = 3000
var salt_normal = 3000
var atacant = false
var mort = false
var curant = false
var tipus_atac = 0
var contador = 0
var sesta_ofagant = false
var animacio = ""
var mana:int = 500 setget perd_mana
var vida:int = 500 setget perd_vida

signal canvi_vida(nova_vida)
signal canvi_mana(nou_mana)
signal oxigen(no_esta_aigua, contador)

func _ready():
	Global.Moris = self 


func _process(delta):
	if mort == false:
		velocitat.x = 0
		#moviments(dreta, esquerra, adalt, escut, atac1, atac2, pausa)-->el que he posat per clicar el boto
		if Input.is_action_pressed("dreta"):
			velocitat += Vector2.RIGHT * velocitat_max
		if Input.is_action_pressed("esquerra"):
			velocitat += Vector2.LEFT * velocitat_max
		if no_esta_aigua:
			if is_on_floor():
				if Input.is_action_pressed("adalt"):
					velocitat.y = velocitat.y - salt
		else:
			if Input.is_action_just_pressed("adalt"):
				velocitat.y = velocitat.y - salt
		velocitat.y += gravetat
		velocitat = move_and_slide(velocitat, Vector2.UP)
		#atacs:(activar i desactivar area)
		if Input.is_action_just_pressed("atac1"):
			atacant = true
			tipus_atac = 1
			$area_atac/colision_atac.disabled = false
		if mana >= 30:
			if Input.is_action_just_pressed("atac2"):
				atacant = true
				self.mana -= 30
				tipus_atac = 2
			$area_atac/colision_atac.disabled = false
		if atacant == false:
			$area_atac/colision_atac.disabled = true
			tipus_atac = 0
		if mana >= 30 and vida < 500:
			if Input.is_action_just_pressed("curar"):
				curant = true
				if vida >= 470:
					self.vida = 500
				else:
					self.mana -= 30
					self.vida += 30
		#funcio que anima segons el que estigui fent el personantge.
	has_mort(vida)
	bombolles()
	ofagantse()
	anima(velocitat, atacant, tipus_atac, mort, curant)
	$Label.text = animacio

func has_mort(vida):
	if vida <= 0:
		mort = true
		get_tree().change_scene("res://pantalla_mort.tscn")

func personatge():
	pass


func anima(velocitat, atacant, tipus_atac, mort, curant): 
	if velocitat.length() == 0:
		$AnimatedSprite.play("iddle")
		animacio = "Quiet"
	if velocitat.x > 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
		animacio = "Caminant"
	if velocitat.x < 0:
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
		animacio = "Caminant"
	if velocitat.y > 0 and not is_on_floor():
		$AnimatedSprite.play("saltant")
		animacio = "Caient"
	if velocitat.y < 0 and not is_on_floor():
		$AnimatedSprite.play("saltant")
		animacio = "Saltant"
	if atacant == true:
		if tipus_atac == 1:
			$AnimatedSprite.play("atac1")
			animacio = "Atacant"
		elif tipus_atac == 2:
			$AnimatedSprite.play("atac1")	#poso atac1 per quan tinguem el que es de veritat
			animacio = "Atacant"
	if curant == true:
		$AnimatedSprite.play("cura")
		animacio = "curant-se"

func perd_vida(nova_vida):
	vida = nova_vida
	emit_signal("canvi_vida", nova_vida)

func perd_mana(nou_mana):
	mana = nou_mana
	emit_signal("canvi_mana", nou_mana)
	
	
func entraaaigua():
	print("soc a dins")
	gravetat = gravetat_normal/3
	no_esta_aigua = false
	salt = salt_normal/1.3

func surtdaigua():
	print("soc a fora")
	gravetat = gravetat_normal
	no_esta_aigua = true
	salt = salt_normal


func bombolles():
	if no_esta_aigua == false:
		emit_signal("oxigen", no_esta_aigua, contador)
	if no_esta_aigua == true:
		emit_signal("oxigen", no_esta_aigua, contador)
		contador = 0
		sesta_ofagant = false
	if contador == 8:
		sesta_ofagant = true

func ofagantse():
	if sesta_ofagant == true and no_esta_aigua == false:
		self.vida -= 1


func _on_area_atac_body_entered(body):
	if body.has_method("enemic"):
		if tipus_atac == 1:
			body.vida -= 30
			if mana <= 470:
				self.mana += 30
			else:
				while mana < 500:
					self.mana += 10
		if tipus_atac == 2:
			body.vida -= 50


func _on_aigua_timeout():
	contador += 1


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "atac1":
		atacant = false
		tipus_atac = 0
		$area_atac/colision_atac.disabled = true
	if $AnimatedSprite.animation == "atac1":# canviar a atac 2
		atacant = false
		tipus_atac = 0
		$area_atac/colision_atac.disabled = true
	if  $AnimatedSprite.animation == "cura":
		curant = false
