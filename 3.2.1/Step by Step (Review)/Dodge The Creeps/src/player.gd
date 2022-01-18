extends Area2D

signal hit

export var speed: float = 400  # Quão rápido o Player irá se mover (px/sec).
var screen_size: Vector2  # Tamanho da tela de jogo.
var target: Vector2 # Mantem a posição do click.

onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func _input(event: InputEvent) -> void:
	"""
	Altera o target sempre que um event['touch'] acontece.
	"""
	if event is InputEventScreenTouch and event.pressed:
		target = event.position


func _process(delta: float) -> void:
	
#	_keyboard_controls(delta)
	_touch_controls(delta)


func _touch_controls(delta: float) -> void:
	var velocity = Vector2()
	
	if position.distance_to(target) > 10: # Move-se em direção ao target e para quando estiver próximo.
		velocity = target - position
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		animated_sprite.play()
		
	else:
		animated_sprite.stop()
	
	position += velocity * delta
	# Ainda será necessário usar o clamp na position do jogador aqui pois em dispositivos que não 
	# são compatíveis com o seu aspect ratio, a Godot tentará mantê-lo o quanto for possível
	# criando bordas escuras, se necessário.
	# Sem o clamp(), o jogador poderia se mover para fora dessas bordas.
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		animated_sprite.animation = "walk"
		animated_sprite.flip_v = false
		animated_sprite.flip_h = velocity.x < 0
	
	elif velocity.y != 0:
		animated_sprite.animation = "up"
		animated_sprite.flip_v = velocity.y > 0

"""
func _keyboard_controls(delta: float) -> void:
	
	var velocity = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	)  # O vetor de movimento do Player.
	
	\"""# Forma antiga
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	\"""
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		animated_sprite.play()
		
		if velocity.x != 0:
			animated_sprite.animation = "walk"
			animated_sprite.flip_v = false
			animated_sprite.flip_h = velocity.x < 0
			
		else:
			animated_sprite.animation = "up"
			animated_sprite.flip_v = velocity.y > 0
		
	else:
		animated_sprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
"""

func _on_Player_body_entered(_body: Node) -> void:
	hide()
	emit_signal("hit")
	collision_shape.set_deferred("disabled", true)


func start(pos) -> void:
	position = pos
	target = pos # Ao começar o target será a posição inicial.
	show()
	collision_shape.disabled = false
