extends MarginContainer

onready var health_label = $HBox/Bars/LifeBar/Count/Background/Number
onready var energy_label = $HBox/Bars/EnergyBar/Count/Background/Number
onready var health_bar = $HBox/Bars/LifeBar/TextureProgress
onready var energy_bar = $HBox/Bars/EnergyBar/TextureProgress
onready var tween = $Tween
onready var tween2 = $Tween2
var animated_health = 0
var animated_energy = 0

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func update_energy(new_value):
	tween.interpolate_property(self, "animated_energy", animated_energy, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween2.is_active():
		tween2.start()

func _ready():
	var player_max_health = $"../Characters/Player".max_health
	health_bar.max_value = player_max_health
	update_health(player_max_health)
	var player_max_energy = $"../Characters/Player".max_energy
	energy_bar.max_value = player_max_energy
	update_energy(player_max_energy)

func _process(delta):
	var round_value = round(animated_health)
	health_label.text = str(round_value)
	health_bar.value = animated_health
	
	round_value = round(animated_energy)
	energy_label.text = str(round_value)
	
	energy_bar.value = animated_energy

func _on_Player_health_changed(player_health):
	update_health(player_health)

func _on_Player_died():
	var start_color = Color(1.0, 1.0, 1.0, 1.0)
	var end_color = Color(1.0, 1.0, 1.0, 0.0)
	tween.interpolate_property(self, "modulate", start_color, end_color, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$"../Transition".play("out")

func _on_Transition_animation_finished(anim_name):
	get_node("/root/Global").goto_scene("res://scenes/GameOver.tscn")

func energy_changed(energy):
	update_energy(energy)

func _on_Player_bombs_changed(bombs):
	$HBox/Counters/HBox/BombCounter/Background/Number.text = str(bombs)