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
var pot_atacar = true
var pot_curarse = true
var animacio = ""
var mana:int = 500 setget perd_mana
var vida:int = 500 setget perd_vida

signal canvi_vida(nova_vida)
signal canvi_mana(nou_mana)

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
		if pot_atacar == true:
			if Input.is_action_just_pressed("atac1"):
				pot_atacar = false
				atacant = true
				tipus_atac = 1
				$pot_atacar.start()
				$area_atac/colision_atac.disabled = false
			if mana >= 30:
				if Input.is_action_just_pressed("atac2"):
					pot_atacar = false
					atacant = true
					self.mana -= 30
					tipus_atac = 2
					$pot_atacar.start()
				$area_atac/colision_atac.disabled = false
		if atacant == false:
			$area_atac/colision_atac.disabled = true
			tipus_atac = 0
		if mana >= 30 and vida < 500:
			if Input.is_action_just_pressed("curar"):
				pot_curarse = false
				curant = true
				if vida >= 470:
					self.vida = 500
				else:
					self.mana -= 30
					self.vida += 30
				$curar.start()
		#funcio que anima segons el que estigui fent el personantge.
	has_mort(vida)
	anima(velocitat, atacant, tipus_atac, mort, curant)
	$Label.text = animacio
	$text_vida.text = str(vida)
	print(pot_curarse)

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
	if velocitat.y > 0 and not is_on_floor():	#poso iddle per quan tinguem el que es de veritat
		$AnimatedSprite.play("iddle")
		animacio = "Caient"
	if velocitat.y < 0 and not is_on_floor():	#poso iddle per quan tinguem el que es de veritat
		$AnimatedSprite.play("iddle")
		animacio = "Saltant"
	if atacant == true and pot_atacar == false:
		if tipus_atac == 1:
			$AnimatedSprite.play("iddle")	#poso iddle per quan tinguem el que es de veritat
			animacio = "Atacant"
		elif tipus_atac == 2:
			$AnimatedSprite.play("iddle")	#poso iddle per quan tinguem el que es de veritat
			animacio = "Atacant"
	if mort == true:
		$AnimatedSprite.play("iddle") #poso iddle per quan tinguem el que es de veritat
		animacio = "Morint"
	if curant == true and pot_curarse == false:
		$AnimatedSprite.play("iddle")
		animacio = "curant-se"

func perd_vida(nova_vida):
	vida = nova_vida
	emit_signal("canvi_vida", nova_vida)

func perd_mana(nou_mana):
	mana = nou_mana
	emit_signal("canvi_mana", nou_mana)


func _on_AnimatedSprite_animation_finished():
	#if $AnimatedSprie.animation == "atac1":
		#atacant = false
		#tipus_atac = 0
		#$area_atac/coli*sion_atac.disabled = true
	#if $AnimatedSprie.animation == "atac2":
		#atacant = false
		#tipus_atac = 0
		#$area_atac/colision_atac.disabled = true
	#if $AnimatedSprite.animation == "curant":
		#curant = false
	#if $AnimatedSprite.animation == "morint":
		#get_tree().change_scene("res://pantalla_mort.tscn")
	pass
	
	
func entraaaigua():
	print("A")
	gravetat = gravetat_normal/3
	no_esta_aigua = false
	salt = salt_normal/1.3

func surtdaigua():
	print("B")
	gravetat = gravetat_normal
	no_esta_aigua = true
	salt = salt_normal


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


func _on_pot_atacar_timeout():
	pot_atacar = true


func _on_curar_timeout():
	pot_curarse = true
