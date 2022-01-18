extends Area2D

signal hit

export (int) var SPEED # Quão rápido Player se move (pxls/sec)
var velocity = Vector2() # O vetor de movimento de Player
var target = Vector2() # MOBILE: Mantem a área clicada como direcional
var screensize # Tamanho da tela de jogo

func _ready():
	hide()
	screensize = get_viewport_rect().size

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	target = pos # MOBILE: target recebe a posição inicial
	
# MOBILE: Altera target quando um evento de toque acontece
func _input(event):
    if event is InputEventScreenTouch and event.pressed:
        target = event.position

func _process(delta):
	
#	# MOBILE: Move-se até target e para, quando estiver próximo
	if position.distance_to(target) > 10:
		velocity = (target - position).normalized() * SPEED
	else:
		velocity = Vector2()
	
# 	# PC: Recebe o comando das teclas direcionais
#	if Input.is_action_pressed("ui_right"):
#		velocity.x += 1
#
#	if Input.is_action_pressed("ui_left"):
#		velocity.x -= 1
#
#	if Input.is_action_pressed("ui_down"):
#		velocity.y += 1
#
#	if Input.is_action_pressed("ui_up"):
#		velocity.y -= 1
#
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * SPEED
#		$AnimatedSprite.play()
#	else:
#		$AnimatedSprite.stop()

	position += velocity * delta
#	# PC: Limita position ao tamanho da tela
#	position.x = clamp(position.x, 0, screensize.x)
#	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

func _on_Player_body_entered(body):
	$CollisionShape2D.disabled = true
	hide()
	emit_signal("hit")