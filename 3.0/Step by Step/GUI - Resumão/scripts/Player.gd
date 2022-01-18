extends "Creature.gd"

signal energy_changed
signal bombs_changed

export var stamina = 0.5
var energy_reloader = 0.0
var last_iter = 0.0
var Bomb = preload("res://scenes/battle_animations/Bombastic.tscn")
export var bombs = 10

func _ready():
	health = max_health
	energy = max_energy
	current_target = $"../Enemy"

func _process(delta):
	
	if state == DAMAGE:
		$Animation.play("take_hit")
		state = IDLE
	
	if state == DYING:
		$Animation.play("die")
		state = DEAD
		
	elif state == IDLE:
		
		if current_target != null:
			
			if Input.is_action_just_pressed("atack"):
				
				if energy >= strength:
					energy -= strength
					$Animation.play("atk")
					state = ATTACKING
					
			if Input.is_action_just_pressed("special"):
				if bombs > 0:
					var new_bomb = Bomb.instance()
				
					new_bomb.target = current_target
					get_parent().add_child(new_bomb)
					bombs -= 1
					emit_signal("bombs_changed", bombs)
			
	if last_iter >= 1:
		
		if energy < max_energy:
			energy_reloader += stamina
			
			if energy_reloader >= 1.0:
				var reload = int(energy_reloader)
				energy += reload
				energy_reloader -= reload
				
				if energy > max_energy:
					energy = max_energy
				else:
					emit_signal("energy_changed", energy)
					
			last_iter -= 1
	else:
		last_iter += delta
	
				
func _on_AnimationPlayer_animation_finished( name ):
	if name == "atk":
		atack(current_target, strength)
		emit_signal("energy_changed", energy)
		state = IDLE
		
	if state != DEAD:
		return
		
	if name == "take_hit":
		state = IDLE
	else:
		return
		
	$Animation.play("die")

func _on_Enemy_died():
	current_target = null
	$BufferVictory.start()

func _on_BufferVictory_timeout():
	get_node("/root/Global").goto_scene("res://scenes/Victory.tscn")