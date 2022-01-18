extends Node

export var Mob: PackedScene
var score: int


func _ready() -> void:
	randomize()


func _on_StartTimer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_MobTimer_timeout() -> void:
	# Escolhe uma direção aleatória no Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Cria uma isntância do Mob e a adiciona na cena..
	var mob = Mob.instance()
	add_child(mob)
	# Determina a direção do Mob perpendicular à direção do caminho..
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Determina a posição do Mob para uma localização aleatória.
	mob.position = $MobPath/MobSpawnLocation.position
	# Adiciona aleatoriedade à direção.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Determina a velocidade linear (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()


func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()
