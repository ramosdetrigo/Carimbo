@tool
class_name BuffAlliesAction
extends ActionLeaf

const ALLIES_KEY = BeehaveConsts.ALLIES_KEY

@export_range(0.0, 5.0, 1.0, "hide_control") var health_buff: float
@export_range(0.0, 5.0, 1.0, "hide_control") var armor_buff: float

func tick(_actor: Node, blackboard: Blackboard) -> int:
	var allies: Array[EnemyCharacter] = []
	allies.assign(blackboard.get_value(ALLIES_KEY, []))
	allies.assign(allies.filter(func(c: EnemyCharacter) -> bool:
		return c.stats_component.armor <= 0.0))
	if allies.is_empty(): return FAILURE
	_apply_buff_callback(allies.pick_random())
	return SUCCESS


func _apply_buff_callback(c: EnemyCharacter) -> void:
	if health_buff > 0:
		c.stats_component.set_health_call(func(prev: float) -> float: return prev + health_buff)
	if armor_buff > 0:
		c.stats_component.set_armor_call(func(prev: float) -> float: return prev + armor_buff)
