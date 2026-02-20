@tool
class_name TargetIsInRangeCondition
extends ConditionLeaf

@export_range(0.1, 100.0, 0.1, "suffix:m") var view_range: float = 10.0

func tick(actor: Node, blackboard: Blackboard) -> int:
	var target: Node3D = _get_target(blackboard)
	if not target: return FAILURE
	var dist: float = _get_dist_to_target(target, actor as Node3D)
	return SUCCESS if dist <= view_range else FAILURE


func _get_dist_to_target(target: Node3D, actor: Node3D) -> float:
	return actor.global_position.distance_to(target.global_position)


func _get_target(blackboard: Blackboard) -> Node3D:
	return blackboard.get_value(BeehaveConsts.BlackboardKeys.TARGET,
		null, str(blackboard.get_instance_id()))
