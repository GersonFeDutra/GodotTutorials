extends RigidBody2D

export var min_speed: float = 150
export var max_speed: float = 250
onready var animated_sprite: AnimatedSprite = $AnimatedSprite


func _ready() -> void:
	var mob_types = animated_sprite.frames.get_animation_names()
	animated_sprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
