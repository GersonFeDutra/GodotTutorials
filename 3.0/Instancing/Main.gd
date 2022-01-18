extends Node

export (PackedScene) var Ball
var balls = 1

func _input(event):
	if event.is_action_pressed("click"):
		var new_ball = Ball.instance()
		new_ball.position = get_viewport().get_mouse_position()
		add_child(new_ball)
		balls += 1
		
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		var new_ball = Ball.instance()
		new_ball.position = get_viewport().get_mouse_position()
		add_child(new_ball)
		balls += 1
		$Camera2D/Label.text = str(balls)
		
	if Input.is_action_pressed("ui_down"):
		$Camera2D.position += Vector2(0, 10)
		
	if Input.is_action_pressed("ui_up"):
		$Camera2D.position += Vector2(0, -10)
		
	if Input.is_action_pressed("ui_left"):
		$Camera2D.position += Vector2(-10, 0)
		
	if Input.is_action_pressed("ui_right"):
		$Camera2D.position += Vector2(10, 0)
		
	if Input.is_action_just_pressed("ui_cancel"):
		print("canceled")
		get_tree().call_group("balls", "clear")
		
		
		