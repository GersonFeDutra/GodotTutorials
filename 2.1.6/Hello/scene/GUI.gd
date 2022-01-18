extends Control

var tapped = false # True == clicado

func _ready():
	
	pass

func _draw():
	var r = Rect2(Vector2(), get_size()) # Armazena a área do Control em uma variável
	if tapped:
		draw_rect(r, Color(1, 0, 0)) # Desenha na tela o retangulo na cor azul
	else:
		draw_rect(r, Color(0, 0, 1)) # Desenha na tela o retangulo na cor vermelha

func _input_event(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.pressed:
		tapped = true # Recebe true quando a área é clicada
		update()