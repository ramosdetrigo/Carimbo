@tool
class_name MoveAwayFromTargetAction
extends ActionLeaf


@export var input_component: InputComponent:
	set(v): input_component = v; update_configuration_warnings()
@export_range(0.1, 10.0, 0.01, "suffix:x") var movement_speed_modifier: float = 1.0


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor or not input_component: return FAILURE

	var target: Node3D = blackboard.get_value(BeehaveConsts.BlackboardKeys.TARGET,
		null, str(blackboard.get_instance_id()))
	if not target: return FAILURE

	input_component.set_input_direction(
		target.global_position.direction_to((actor as Node3D).global_position))
	return SUCCESS


func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = super._get_configuration_warnings()
	if not input_component:
		war.append("This action leaf requires an InputComponent")
	return war
