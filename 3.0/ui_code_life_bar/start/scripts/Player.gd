extends Node2D

signal health_changed # Emite o sinal para alterar a GUI
signal died # Emite o sinal para controlar a animação e parar os ataques

export var max_health = 18
var health = max_health 

enum STATES {ALIVE, DEAD} # No estado DEAD a UI desaparece com fade
var state = ALIVE

# Implement stamina as an exercise + solution!
#var max_energy = 18
#var energy = max_energy

func take_damage(count): # Função chamada por qualquer Inimigo que atacar o Player
	if state == DEAD:
		return

	health -= count
	if health <= 0:
		health = 0
		state = DEAD
		emit_signal("died")

	$AnimationPlayer.play("take_hit")

	emit_signal("health_changed", health)

func _on_AnimationPlayer_animation_finished( name ):
	if state != DEAD:
		return
	if name != "take_hit":
		return

	$AnimationPlayer.play("die")