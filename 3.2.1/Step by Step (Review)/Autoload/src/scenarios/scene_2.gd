extends Control

export(String, FILE, "*.tscn") var next: String


func _on_Button_pressed() -> void:
	
	if next:
		Global.goto_scene(next)
