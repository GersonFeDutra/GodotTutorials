extends Node

export(PackedScene) var Mob
var score

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$SoundFX.play()
	$Music.stop()

func new_game():
	var x = 0

	if x == 0:
		$HUD/Sprite.visible = false
	
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Se prepara!")
	$Music.play()

func _ready():
	randomize()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$HUD.update_score(score)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	$MobPath/MobSpawnerLocation.set_offset(randi())
	
	var mob = Mob.instance()	
	
	add_child(mob)
	
	var direction = $MobPath/MobSpawnerLocation.rotation + PI/2
	
	mob.position = $MobPath/MobSpawnerLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))