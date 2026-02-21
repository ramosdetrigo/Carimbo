@tool
class_name MoveTowardsTargetAction
extends ActionLeaf

const TARGET_POS_KEY = BeehaveConsts.BlackboardKeys.TARGET_POSITION
const TARGET_KEY = BeehaveConsts.BlackboardKeys.TARGET

@export var input_component: InputComponent:
	set(v): input_component = v; update_configuration_warnings()
@export_range(0.1, 10.0, 0.01, "suffix:x") var movement_speed_modifier: float = 1.0
@export_group("Navigation Agent", "navigation_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var navigation_enable: bool = false:
	set(v): navigation_enable = v; update_configuration_warnings()
@export var navigation_agent: NavigationAgent3D:
	set(v): navigation_agent = v; update_configuration_warnings()


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor or not input_component: return FAILURE
	if navigation_enable and not navigation_agent: return FAILURE

	var target: Node3D = blackboard.get_value(TARGET_KEY, null)
	if not target: return FAILURE

	input_component.set_input_direction(_get_target_direction(actor, target))
	return SUCCESS


func _get_target_direction(actor: Node3D, target: Node3D) -> Vector3:
	var pos: Vector3 = target.global_position
	if navigation_enable:
		navigation_agent.set_target_position(pos)
		pos = navigation_agent.get_next_path_position()
	return actor.global_position.direction_to(pos)


func _has_reached_target(actor: Node3D, target: Vector3) -> bool:
	var dis_reached: bool = actor.global_position.distance_to(target) <= 1.0
	if navigation_enable: return navigation_agent.is_target_reached() \
		or not navigation_agent.is_target_reachable() or dis_reached
	return dis_reached


func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = super._get_configuration_warnings()
	if not input_component:
		war.append("This action leaf requires an InputComponent")
	if navigation_enable and not navigation_agent:
		war.append("When navigation_enable is true, this action leaf requires an NavigationAgent3D")
	return war
