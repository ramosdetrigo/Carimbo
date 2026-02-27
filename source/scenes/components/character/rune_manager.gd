class_name RuneManager
extends Node3D

var current_rune: Node3D: set = set_current_rune

func _on_rune_change(rune: Rune) -> void:
	if not rune or not rune.rune_scene: current_rune = null; return
	current_rune = rune.rune_scene.instantiate()


func set_current_rune(value: Node3D) -> void:
	if current_rune:
		current_rune.reparent(get_tree().root)
		current_rune.queue_free()
	current_rune = value
	if value == null: return
	add_child(current_rune)
	current_rune.set_global_position(global_position)
