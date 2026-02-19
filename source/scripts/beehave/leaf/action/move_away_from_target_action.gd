@tool
class_name MoveAwayFromTargetAction
extends MoveTowardsTargetAction


func _get_direction(target: Node3D, actor: StampableCharacter) -> Vector2:
	var dir: Vector3 = target.global_position.direction_to(actor.global_position)
	return Vector2(dir.x, dir.z)
