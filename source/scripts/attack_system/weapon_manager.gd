@tool
class_name WeaponManager
extends Node3D

@export var attack_scene: PackedScene: set = _set_attack_scene
@export var attack_spawn_offset: Vector3
@export var is_projectile: bool = false


func attack(shooting_dir: Vector3 = Vector3.ZERO) -> void:
	if not attack_scene: return
	var attk: Node3D = attack_scene.instantiate()
	get_tree().current_scene.add_child(attk)
	attk.global_position = global_position + attack_spawn_offset
	if not is_projectile: return
	attk.look_at(attk.global_position + shooting_dir)



func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = []
	if not attack_scene:
		war.append("This node requires an AttackScene PackedScene")
	return war


func _set_attack_scene(value: PackedScene) -> void:
	attack_scene = value
	update_configuration_warnings()
