extends KinematicBody2D

enum{
	FAST
	STRONG
	NONE
}
const SPEED = 50000
const JUMP_POWER = -300
const GRAVITY = 50
const STRENGTH = 75
const RNG = 0

var vida = 600
var velocity = Vector2()
var close = false
var target:KinematicBody2D 
var att = NONE
var attacking = false
var alive = true
var dmg: int
var esta = false
var esta2 = false

func _ready():
	$Timer.wait_time = 2
	$Timer.start()
	randomize()
	pass

func _physics_process(delta):
	if vida <= 0:
		alive = false
	if attacking == false:
		att = NONE
	$attack/CollisionShape2D.disabled = false
	$attack2/bite.disabled = false
	if alive:
		anima()
		if target:
			
			if close or attacking:
				velocity.x = 0
				
			elif target.global_position.x > global_position.x - RNG:
				velocity = SPEED * Vector2.RIGHT * delta
				
			elif target.global_position.x < global_position.x + RNG:
				velocity = SPEED * Vector2.LEFT * delta
			
			if velocity.x > 0:
				$AnimatedSprite.flip_h = false
			elif velocity.x < 0:
				$AnimatedSprite.flip_h = true
			else:
				pass
			
			if ($AnimatedSprite.flip_h == true):
				$hitbox.disabled = true
				$hitbox2.disabled = false
			else:
				$hitbox.disabled = false
				$hitbox2.disabled = true
				
			velocity.y += GRAVITY
			velocity = move_and_slide(velocity)
			
	else:
		$Timer.stop()
		die()

func choose(array):
	array.shuffle()
	return array.front()

func die():
	attacking = false
	att = NONE
	$AnimatedSprite.play('death')
	$Label.text = 'KO'

func enemic():
	pass

func attack():
	match att:
		FAST:
			dmg = STRENGTH
			attacking = true

		STRONG:
			dmg = 2*STRENGTH
			attacking = true

		NONE:
			attacking = false
			
	if att == FAST and esta:
		$attack/CollisionShape2D.disabled = false
		target.vida -= dmg
	elif att == STRONG and esta2:
		$attack2/bite.disabled = false
		target.vida -= dmg
	else:
		pass

func anima():
	if attacking == true:
		if att == FAST:
			$AnimatedSprite.play('att1')
		elif att == STRONG:
			$AnimatedSprite.play('att2')
	else:
		if velocity.x == 0:
			$AnimatedSprite.play('iddle')
		else:
			$AnimatedSprite.play('run')


func _on_Timer_timeout():
	$Timer.wait_time = choose([1.5, 2, 2, 2.5])
	$Timer.start()
	att = choose([FAST, FAST, FAST, STRONG, STRONG])
	attack()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == 'death':
		queue_free()
		get_tree().change_scene("res://WIN.tscn")
		
	elif $AnimatedSprite.animation == 'att1':
		attacking = false
		att = NONE
	elif $AnimatedSprite.animation == 'att2':
		attacking = false
		att = NONE
	elif $AnimatedSprite.animation == 'att3':
		attacking = false
		att = NONE

func _on_attack_body_entered(body):
	if body.has_method('personatge'):
		esta = true

func _on_SIGHT2_body_entered(body):
	if body.has_method('personatge'):
		target = body 

func _on_range_body_entered(body):
	if body.has_method('personatge'):
		close = true

func _on_range_body_exited(body):
	if body.has_method('personatge'):
		close = false

func _on_attack_body_exited(body):
	if body.has_method('personatge'):
		esta = false

func _on_attack2_body_entered(body):
	if body.has_method('personatge'):
		esta2 = true

func _on_attack2_body_exited(body):
	if body.has_method('personatge'):
		esta2 = false
