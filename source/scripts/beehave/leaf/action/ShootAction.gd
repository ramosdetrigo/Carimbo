@tool
class_name ShootAction
extends ActionLeaf

@export var weapon_manager: WeaponManager: set = _set_weapon_manager
@export var stampable_sprite: StampableShadedAnimatedSprite3D

func tick(actor: Node, blackboard: Blackboard) -> int:
	if not weapon_manager: return FAILURE
	var target: Node3D = _get_target(blackboard)
	if not target: return FAILURE
	weapon_manager.shoot_projectile(_get_dir_to_target(target, actor as Node3D))
	if stampable_sprite: stampable_sprite.play(&"shoot")
	return SUCCESS


func _get_dir_to_target(target: Node3D, actor: Node3D) -> Vector3:
	return actor.global_position.direction_to(target.global_position)


func _get_target(blackboard: Blackboard) -> Node3D:
	return blackboard.get_value(BeehaveConsts.BlackboardKeys.TARGET,
		null, str(blackboard.get_instance_id()))



func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = super._get_configuration_warnings()
	if not weapon_manager:
		war.append("This action leaf requires an WeaponManager")
	return war


func _set_weapon_manager(value: WeaponManager) -> void:
	weapon_manager = value
	update_configuration_warnings()
