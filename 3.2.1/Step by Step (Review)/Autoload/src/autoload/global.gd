extends Node

var current_scene: Node


func _ready() -> void:
	var root: Viewport = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)


func goto_scene(scene: String) -> void:
	"""
	Essa função normalmente será chamada de uma callback de um sinal,
	ou de alguma outra função da cena atual.
	Apagar a cena atual nesse ponto é uma má ideia,
	pois ela pode estar executando código ainda.
	Isso pode resultar em travamento ou comportamentos inesperados.
	
	A solução é adiar o carregamento para mais tarde,
	para quando tivermos certeza que a cena atual não estará executando código.
	"""
	call_deferred("_deferred_goto_scene", scene)


func _deferred_goto_scene(path: String) -> void:
	"""
	Agora é seguro remover a cena atual.
	"""
	current_scene.free()
	
	# Carrega a nova cena.
	var new_scene: PackedScene = ResourceLoader.load(path)
	
	# Instancia a nova cena.
	current_scene = new_scene.instance()
	
	# A adiciona para a cena ativa, como uma filha de root.
	get_tree().get_root().add_child(current_scene)
	
	# Opcionalmente, faz ela ser compatível com a API de Scene.change_scene().
	get_tree().set_current_scene(current_scene)
