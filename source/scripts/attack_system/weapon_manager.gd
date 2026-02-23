@tool
class_name WeaponManager
extends Node3D

@export var attack_scene: PackedScene: set = _set_attack_scene
@export var attack_spawn_offset: Vector3


func attack(shooting_dir: Vector3 = Vector3.UP) -> void:
	if not attack_scene: return
	var attk: Node3D = attack_scene.instantiate()
	owner.add_sibling(attk)
	var pos: Vector3 = global_position + attack_spawn_offset
	shooting_dir = (shooting_dir if shooting_dir else Vector3.UP)
	attk.look_at_from_position(pos, pos + shooting_dir)
	if "swing_dir" in attk: attk.set.call_deferred(&"swing_dir", shooting_dir)



func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = []
	if not attack_scene:
		war.append("This node requires an AttackScene PackedScene")
	return war


func _set_attack_scene(value: PackedScene) -> void:
	attack_scene = value
	update_configuration_warnings()
