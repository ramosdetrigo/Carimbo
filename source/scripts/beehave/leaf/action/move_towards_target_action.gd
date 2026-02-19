@tool
class_name MoveTowardsTargetAction
extends ActionLeaf

@export var input_component: InputComponent: set = _set_input_component
@export_range(0.1, 100, 0.1, "suffix:m") var target_desired_distance: float = 1.0


func tick(actor: Node, blackboard: Blackboard) -> int:
	if not actor or actor is not StampableCharacter or not input_component: return FAILURE

	var target: Node3D = blackboard.get_value(BeehaveConsts.BlackboardKeys.TARGET,
		null, str(blackboard.get_instance_id()))
	if not target:
		if can_send_message(blackboard):
			BeehaveDebuggerMessages.process_tick(self.get_instance_id(), FAILURE, blackboard.get_debug_data())
		return FAILURE

	var dist: float = target.global_position.distance_to((actor as StampableCharacter).global_position)
	if dist <= target_desired_distance:
		if can_send_message(blackboard):
			BeehaveDebuggerMessages.process_tick(self.get_instance_id(), SUCCESS, blackboard.get_debug_data())
		return SUCCESS

	var dir: Vector2 = _get_direction(target, actor)
	input_component.set_horizontal_input_direction(dir)
	return SUCCESS


func _get_direction(target: Node3D, actor: StampableCharacter) -> Vector2:
	var dir: Vector3 = actor.global_position.direction_to(target.global_position)
	return Vector2(dir.x, dir.z)


func _get_configuration_warnings() -> PackedStringArray:
	var war: PackedStringArray = super._get_configuration_warnings()
	if not input_component:
		war.append("This action leaf requires an InputComponent")
	return war


func _set_input_component(value: InputComponent) -> void:
	input_component = value
	update_configuration_warnings()
