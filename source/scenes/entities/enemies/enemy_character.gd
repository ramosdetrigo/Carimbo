class_name EnemyCharacter
extends StampableCharacter

@export var beehave_tree: BeehaveTree


func _ready() -> void:
	beehave_tree.blackboard.set_value(BeehaveConsts.BlackboardKeys.TARGET,
		get_tree().get_first_node_in_group(BeehaveConsts.PLAYER_NODE_GROUP),
		str(beehave_tree.blackboard.get_instance_id()))
	super._ready()


func _physics_process(_delta: float) -> void:
	move_and_slide()


func connect_death_signals(stats: StatsComponent) -> void:
	super.connect_death_signals(stats)
	if not stats.died.is_connected(beehave_tree.disable): stats.died.connect(beehave_tree.disable)
