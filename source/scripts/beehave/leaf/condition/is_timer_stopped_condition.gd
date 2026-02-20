@tool
class_name IsTimerStoppedCondition
extends ConditionLeaf

const TIMER_KEY: String = "timer_cache_key"

@export var timer: Timer

func tick(_actor: Node, blackboard: Blackboard) -> int:
	blackboard.set_value(TIMER_KEY, timer.time_left, str(blackboard.get_instance_id()))
	return SUCCESS if timer.is_stopped() else FAILURE
