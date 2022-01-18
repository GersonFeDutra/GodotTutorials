extends Node2D

signal health_changed # Emite o sinal para alterar a GUI e animações
signal died # Emite o sinal para controlar a animação e parar de ser atacado

enum STATES {IDLE, DAMAGE, ATTACKING, DYING, DEAD} # Implementar "states machine" para cada Creature
var state = IDLE
export (int) var level = 1 # (Não implementado)Level pode influenciar os valores de cada criatura de formas diferentes
export (int) var max_health
var health
export (int) var max_energy
var energy
export (int) var strength
var current_target

func atack(target, damage):
	if target.state != DEAD:
		target.take_damage(damage)
	else:
		return

func take_damage(damage):
	health -= damage
	state = DAMAGE
	emit_signal("health_changed", health)
	
	if health <= 0:
		health = 0
		state = DYING
		emit_signal("died")