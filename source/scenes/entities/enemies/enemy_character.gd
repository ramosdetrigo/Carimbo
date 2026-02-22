class_name EnemyCharacter
extends StampableCharacter

@export var beehave_tree: BeehaveTree


func _ready() -> void:
	beehave_tree.blackboard.set_value(BeehaveConsts.BlackboardKeys.TARGET,
		get_tree().get_first_node_in_group(BeehaveConsts.PLAYER_NODE_GROUP))
