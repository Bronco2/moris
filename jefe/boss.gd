extends KinematicBody2D

enum{
	FAST
	STRONG
	NONE
}
const SPEED = 50000
const JUMP_POWER = -300
const GRAVITY = 500
const STRENGTH = 75

var vida = 500
var velocity = Vector2()
const RNG = 0
var close = false
var target:KinematicBody2D 
var att = NONE
var attacking = false
var alive = true
var dmg: int
var esta = false

func _ready():
	$Timer.wait_time = 2
	$Timer.start()
	randomize()
	pass

func _physics_process(delta):
	if attacking == false:
		att = NONE
	$attack/CollisionShape2D.disabled = false
	if alive:
		anima()
		if target:
			$Label.text = str(vida)
			$Label2.text = ''
			if close or attacking:
				velocity.x = 0
			elif target.global_position.x > global_position.x - RNG:
				$AnimatedSprite.flip_h = false
				velocity = SPEED * Vector2.RIGHT * delta
			elif target.global_position.x < global_position.x + RNG:
				velocity = SPEED * Vector2.LEFT * delta
				$AnimatedSprite.flip_h = true
			
			velocity.y += GRAVITY
			velocity = move_and_slide(velocity)
#		match att:
#			FAST:
#				$AnimatedSprite.play('att1')
#				dmg = STRENGTH
#				attacking = true
#
#			STRONG:
#				$AnimatedSprite.play('att2')
#				dmg = 2*STRENGTH
#				attacking = true
#
#			NONE:
#				attacking = false
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
	if attacking and esta:
		$attack/CollisionShape2D.disabled = false
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
			$AnimatedSprite.play('default')
		else:
			$AnimatedSprite.play('run')

func _on_Timer_timeout():
	$Timer.wait_time = choose([1, 1.5, 2])
	$Timer.start()
	att = choose([FAST, FAST, FAST, STRONG, STRONG])
	attack()

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == 'death':
		queue_free()
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
