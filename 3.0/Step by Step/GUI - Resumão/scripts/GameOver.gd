extends ColorRect
var value

func change_reasons(giveup):
	$TristeFim/Desafiado/Options/Yep/Reasons.visible = giveup
	$TristeFim/Desafiado/Options/Nope/Reasons.visible = not giveup
	match (int(rand_range(0,4))):
		0:
			$TristeFim/Desafiado/Options/Yep/Reasons.text = "É muita pressão vey!"
			$TristeFim/Desafiado/Options/Nope/Reasons.text = "Quem você pensa que eu sou?"
		1:
			$TristeFim/Desafiado/Options/Yep/Reasons.text = "Jisuiz mi zauva"
			$TristeFim/Desafiado/Options/Nope/Reasons.text = "Vai encarar?"
		2:
			$TristeFim/Desafiado/Options/Yep/Reasons.text = "Vou dar um tempinho..."
			$TristeFim/Desafiado/Options/Nope/Reasons.text = "Só por cima do meu squardaver!"
		3:
			$TristeFim/Desafiado/Options/Yep/Reasons.text = "Mais difícil que Dark Souls!!!"
			$TristeFim/Desafiado/Options/Nope/Reasons.text = "Xalabaias!"
		
func _on_AnimationPlayer_animation_finished(anim_name):
	$TristeFim/Desafiado/Options/Yep.grab_focus()

func _on_Yep_pressed():
	get_node("/root/Global").goto_scene("res://scenes/MainMenu.tscn")

func _on_Nope_pressed():
	get_node("/root/Global").goto_scene("res://scenes/LevelMockup.tscn")

func _on_Yep_mouse_entered():
	$TristeFim/Desafiado/Options/Yep.grab_focus()

func _on_Nope_mouse_entered():
	$TristeFim/Desafiado/Options/Nope.grab_focus()

func _on_Yep_focus_entered():
	change_reasons(true)
	
func _on_Nope_focus_entered():
	change_reasons(false)
