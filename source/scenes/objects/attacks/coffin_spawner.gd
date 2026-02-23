class_name ObjectSpawner
extends Node3D

@export var scene_to_spawn: PackedScene
@export var spawn_offset: Vector3 = Vector3.ZERO

func spawn() -> void:
	if not scene_to_spawn: return
	var s: Node3D = scene_to_spawn.instantiate()
	add_sibling(s)
	s.set_global_position(global_position + spawn_offset)
