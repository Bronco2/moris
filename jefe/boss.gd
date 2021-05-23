extends KinematicBody2D

enum{
	FAST
	STRONG
	RANGED
	NONE
}
const SPEED = 500
const JUMP_POWER = -300
const GRAVITY = 100
const STRENGTH = 75
var vida = 10000
var velocity = Vector2()
const RNG = 0
var target:KinematicBody2D 
var att = NONE
var attacking = false
var alive = true
var dmg: int

func _ready():
	$Timer.wait_time = 2
	randomize()
	pass



func _physics_process(delta):
	if alive:
		if target:
			if abs(target.position.x - position.x) < 50:
				velocity.x = 0
			elif target.position.x < position.x:
				velocity = SPEED * Vector2.RIGHT
			elif target.position.x > position.x:
				velocity = SPEED * Vector2.LEFT
			
			velocity.y += GRAVITY
			velocity = move_and_slide(velocity)
	
	else:
		$Timer.stop()
		die()







func choose(array):
	array.shuffle()
	return array.front()


#func move():
#	if target.position.x <= (position.x - rng):
#		velocity.x = SPEED * Vector2.LEFT
#	elif target.position.x > (position.x + rng):
#		velocity.x = SPEED * Vector2.RIGHT
#	velocity.y += GRAVITY
#	return velocity


func die():
	attacking = false
	att = NONE
	$AnimatedSprite.play('death')
	


func attack():
	match att:
		FAST:
			$AnimatedSprite.play('att1')
			dmg = STRENGTH
			attacking = true
			
		STRONG:
			$AnimatedSprite.play('att2')
			dmg = 2*STRENGTH
			attacking = true
			
		RANGED:
			$AnimatedSprite.play('att3')
			pass
		NONE:
			attacking = false
	



func _on_Timer_timeout():
	$Timer.wait_time = choose([1, 1.5, 2])
	att = choose([FAST, STRONG, RANGED])
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
	if attacking:
		if body.has_method('personatge'):
			body.vida -= dmg 

#
#func _on_SIGHT_body_entered(body):
#	if body.has_method('personatge'):
#			target = body 

#
#
func _on_SIGHT2_body_entered(body):
	if body.has_method('personatge'):
		print('ara si')
		target = body 
