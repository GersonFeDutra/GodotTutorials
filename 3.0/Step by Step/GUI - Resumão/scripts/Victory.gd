extends ColorRect

func _on_Animation_animation_finished(anim_name):
	get_node("/root/Global").goto_scene("res://scenes/MainMenu.tscn")