@tool
class_name GetAlliesAction
extends ActionLeaf

const ALLIES_KEY = BeehaveConsts.ALLIES_KEY
const ALLIES_GROUP = BeehaveConsts.MONSTER_NODE_GROUP

@export_range(0.1, 100.0, 0.1, "suffix:m") var _range: float = 10.0

func tick(actor: Node, blackboard: Blackboard) -> int:
	var allies: Array[EnemyCharacter] = []
	allies.assign(blackboard.get_value(ALLIES_KEY,
		get_tree().get_nodes_in_group(ALLIES_GROUP)\
		.filter(func(c: Node) -> bool:
			return c is EnemyCharacter and (c as EnemyCharacter).stats_component)))
	var nearby: Array[EnemyCharacter] = []
	nearby.assign(allies.filter(func(c: EnemyCharacter) -> bool:
		return (actor as Node3D).global_position.distance_to(c.global_position) <= _range))
	blackboard.set_value(ALLIES_KEY, nearby)
	return SUCCESS
