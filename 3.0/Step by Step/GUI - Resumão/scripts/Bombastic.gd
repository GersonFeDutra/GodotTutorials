extends Sprite

var target

func _on_Animation_animation_finished(anim_name):
	if target != null:
		target.take_damage(5)
	queue_free()