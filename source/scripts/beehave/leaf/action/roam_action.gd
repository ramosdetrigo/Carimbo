@tool
class_name RoamAction
extends ActionLeaf

const TARGET_KEY = BeehaveConsts.BlackboardKeys.TARGET_POSITION
const TARGET_REACHED = BeehaveConsts.BlackboardKeys.TARGET_REACHED

@export_range(0.1, 100.0, 0.1, "suffix:m", "or_greater") var roam_range: float = 10.0
@export var input_component: InputComponent:
	set(v): input_component = v; update_configuration_warnings()
@export_group("Navigation Agent", "navigation_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var navigation_enable: bool = false:
	set(v): navigation_enable = v; update_configuration_warnings()
@export var navigation_agent: NavigationAgent3D:
	set(v): navigation_agent = v; update_configuration_warnings()


func tick(actor: Node, blackboard: Blackboard) -> int:
	if navigation_enable and not navigation_agent: return FAILURE
	var target_pos: Vector3 = _cached_target_pos(actor, blackboard)
	if navigation_enable: navigation_agent.set_target_position(target_pos)
	var dir: Vector3 = (actor as Node3D).global_position.direction_to(
		navigation_agent.get_next_path_position() if navigation_enable else target_pos)

	var reached: bool = _has_reached_target(actor, target_pos)
	blackboard.set_value(TARGET_REACHED, reached)
	if reached: return SUCCESS
	input_component.set_input_direction(dir)
	return RUNNING


func _cached_target_pos(actor: Node3D, blackboard: Blackboard) -> Vector3:
	var pos: Vector3 = blackboard.get_value(TARGET_KEY, _get_random_target_pos(), str(get_instance_id()))
	if blackboard.get_value(TARGET_REACHED, true): pos = _get_random_target_pos()
	pos.y = actor.global_position.y
	blackboard.set_value(TARGET_KEY, pos, str(get_instance_id()))
	return pos


func _has_reached_target(actor: Node3D, target: Vector3) -> bool:
	var nav: bool = navigation_enable and \
		(navigation_agent.is_target_reached() or not navigation_agent.is_target_reachable())
	var r: bool = nav or actor.global_position.distance_to(target) <= 1.0
	return r


func _get_random_target_pos() -> Vector3:
	return _get_random_direction() * randf_range(0.1, roam_range)


func _get_random_direction() -> Vector3:
	return Vector3(randf_range(-1.0, 1.0), 0.0, randf_range(-1.0, 1.0)).normalized()


func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = super._get_configuration_warnings()
	if navigation_enable and not navigation_agent:
		war.append("When navigation_enable is true, this action leaf requires an NavigationAgent3D")
	if not input_component:
		war.append("This action leaf requires an InputComponent")
	return war
