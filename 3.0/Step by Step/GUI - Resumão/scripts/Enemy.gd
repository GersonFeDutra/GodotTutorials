extends "Creature.gd"

func _ready():
	strength = 2
	health = 18
	current_target = $"../Player"

func _process(delta):
	
	if state == DYING:
		$Animation.play("die")
		state = DEAD
	
	elif state == DAMAGE and state != DEAD:
		$Animation.play("take_hit")
		state = IDLE
	
		if health <= 0:
			health = 0
			state = DEAD


func _on_Timer_timeout():
	if not current_target:
		$Timer.stop()
		return

	if state != IDLE:
		return

	state = ATTACKING
	$Animation.play("anticipate")

func _on_AnimationPlayer_animation_finished( name ):
	if name == "attack":
		state = IDLE
		
	if name == "anticipate":
		$Animation.play("attack")
		atack(current_target, strength)
		
	if name == "damage":
		state = IDLE
		
	if name == "die":
		queue_free()

func _on_Player_died():
	current_target = null