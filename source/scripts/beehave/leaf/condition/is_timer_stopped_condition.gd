@tool
class_name IsTimerStoppedCondition
extends ConditionLeaf

const TIMER_KEY: String = "timer_cache_key"

@export_range(0.001, 4096, 0.001, "or_greater", "suffix:s", "exp")
var wait_time: float = 1.0

var _timer: SceneTreeTimer

func tick(_actor: Node, _blackboard: Blackboard) -> int:
	if not _timer or _timer.time_left <= 0: _timer = get_tree().create_timer(wait_time)
	return SUCCESS if _timer.time_left <= 0 else FAILURE
