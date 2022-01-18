extends Control

export var next_scene: int

func _on_Button_pressed():
	var is_ok = get_tree().change_scene("res://src/Scene%s.tscn" % next_scene)
	
	assert(is_ok == OK)
