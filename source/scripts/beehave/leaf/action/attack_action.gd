@tool
class_name AttackAction
extends ActionLeaf

const TARGET_POS_KEY = BeehaveConsts.TARGET_POS_KEY

@export var attack_scene: PackedScene: set = _set_attack_scene
@export var attack_spawn_offset: Vector3
@export var is_projectile: bool = false


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not attack_scene: return FAILURE
	var attack: Node3D = attack_scene.instantiate()
	get_tree().current_scene.add_child(attack)
	attack.set_global_position((actor as Node3D).global_position + attack_spawn_offset)
	if not is_projectile: return SUCCESS

	var target: Vector3 = blackboard.get_value(TARGET_POS_KEY)
	if not target: return FAILURE

	var direction: Vector3 = (actor as Node3D).global_position.direction_to(target)
	attack.look_at(attack.global_position + direction)
	return SUCCESS


func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = super._get_configuration_warnings()
	if not attack_scene:
		war.append("This action leaf requires an AttackScene PackedScene")
	return war


func _set_attack_scene(value: PackedScene) -> void:
	attack_scene = value
	update_configuration_warnings()
