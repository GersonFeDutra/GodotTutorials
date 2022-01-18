tool
extends MarginContainer

export var to_player: NodePath setget set_to_player
var animated_health: float setget set_animated_health

onready var number_label: Label = $Bars/LifeBar/Count/Background/Number
onready var bar: TextureProgress = $Bars/LifeBar/TextureProgress
onready var tween: Tween = $Tween


func _ready() -> void:
	
	if Engine.is_editor_hint(): # Esteja atento ao tool mode
		set_process(false)
		
	else:
		setup()


func _get_configuration_warning() -> String:
	var warning: String
	
	if to_player.is_empty():
		warning = "The var [to_player]: NodePath can't be empty."
	
	return warning


func _on_Player_died() -> void:
	
# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "modulate", Color.white, Color.transparent, 1.0)


func update_health(new_value: float) -> void:
# warning-ignore:return_value_discarded
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6)
	
	if not tween.is_active():
# warning-ignore:return_value_discarded
		tween.start()


func setup() -> void:
	"""
	As pré-configurações envolvendo os nós importados por caminho são definidas abaixo.
	"""
	if to_player.is_empty():
		return
	
	var player_max_health = get_node(to_player).max_health
	bar.max_value = player_max_health
	update_health(player_max_health)


func set_to_player(value: NodePath) -> void:
	to_player = value
	update_configuration_warning()


func set_animated_health(value: float) -> void:
	var round_value: float = round(animated_health)
	
	number_label.text = str(round_value)
	bar.value = round_value
	
	animated_health = value
