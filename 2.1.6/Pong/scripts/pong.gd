extends Node2D

#Members variables
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)
var rP = 0
var lP = 0
var is_pause = true
const DELAY = 0.5
var delay = DELAY
var music = 3

const INITIAL_BALL_SPEED = 200 # Constant for ball speed (pixels x second)
var ball_speed = INITIAL_BALL_SPEED # Speed of the ball (pixels x second)
const PAD_SPEED = 200
 
func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("paddleL").get_texture().get_size()
	set_process(true)

func _process(delta):
	var ball_pos = get_node("ball").get_pos()
	var left_rect = Rect2(get_node("paddleL").get_pos() - pad_size * 0.5, pad_size)
	var right_rect = Rect2(get_node("paddleR").get_pos() - pad_size * 0.5, pad_size)
	
	if delay > 0:
		delay -= delta
	
	if !is_pause:
		ball_pos += direction * ball_speed * delta # Integrate new ball position
	
	# Check Collisions
	if (ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0):
		direction.y = -direction.y # Flip when touch roof or floor
		get_node("roof_floor_impact").play()
	if (left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0):
		direction.x = -direction.x # Flip when touch paddle
		get_node("impact").play()
		direction.y = randf() * 2.0 - 1 # Change the direction of ball randomly
		direction = direction.normalized()
		ball_speed *= 1.1 # Incrises the speed a little
	
	# Check Game Over
	if ball_pos.x < 0:
		rP += 1
		get_node("lose").play()
		get_node("placarR").set_text(str(rP))
		ball_pos = screen_size * 0.5 # Repoiciona a bola no meio do campo
		ball_speed = INITIAL_BALL_SPEED # Reinicia a velocidade da bola
		direction = Vector2(1, 0) # Redefine a direção da bola
		
	if ball_pos.x > screen_size.x:
		get_node("lose").play()
		lP += 1
		get_node("placarL").set_text(str(lP))
		ball_pos = screen_size * 0.5 # Reposiciona a bola no meio do campo
		ball_speed = INITIAL_BALL_SPEED # Reinicia a velocidade da bola
		direction = Vector2(-1, 0) # Redefine a direção da bola
	
	get_node("ball").set_pos(ball_pos) # Atualiza a posição da bola
	
	#Move Left Pad
	var left_pos = get_node("paddleL").get_pos()
	if left_pos.y > 0 and Input.is_action_pressed("left_move_up") and !is_pause:
		left_pos.y += -PAD_SPEED * delta # Move the paddle to up
	if left_pos.y < screen_size.y and Input.is_action_pressed("left_move_down") and !is_pause:
		left_pos.y += PAD_SPEED * delta # Move the paddle to down
	get_node("paddleL").set_pos(left_pos) # Atualiza a posição da Pá esquerda
	
	#Move Right Pad
	var right_pos = get_node("paddleR").get_pos()
	if right_pos.y > 0 and Input.is_action_pressed("right_move_up") and !is_pause:
		right_pos.y += -PAD_SPEED * delta # Move the paddle to up
	if right_pos.y < screen_size.y and Input.is_action_pressed("right_move_down") and !is_pause:
		right_pos.y += PAD_SPEED * delta # Move the paddle to down
	get_node("paddleR").set_pos(right_pos) # Atualiza a posição da Pá esquerda
	
	# Music
	if music == lP or music == rP:
		get_node("pong").play()
		music += 10
	
	if Input.is_action_pressed("pause") and delay <= 0:
		switch_pause()
		delay = DELAY

func switch_pause():
	is_pause = !is_pause
	if is_pause:
		get_node("alert").set_text("Press space to Continue") # Does the alert on
	else:
		get_node("alert").set_text("") # Does the alert off
