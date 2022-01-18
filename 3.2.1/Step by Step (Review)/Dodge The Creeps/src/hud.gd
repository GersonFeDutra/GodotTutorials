extends CanvasLayer

signal start_game
onready var message: Label = $Message


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$Message.hide()


func show_message(text):
	
	message.text = text
	message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	# Aguarda até o MessageTimer finalizar a contagem.
	yield($MessageTimer, "timeout")
	
	message.text = "Dodge the\nCreeps!"
	message.show()
	# Cria um Timer de disparo único e aguarda o fim da contagem.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)
