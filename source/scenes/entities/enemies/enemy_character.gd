class_name EnemyCharacter
extends StampableCharacter

@export var beehave_tree: BeehaveTree


func _ready() -> void:
	beehave_tree.blackboard.set_value(BeehaveConsts.BlackboardKeys.TARGET,
		get_tree().get_first_node_in_group(BeehaveConsts.PLAYER_NODE_GROUP),
		str(beehave_tree.blackboard.get_instance_id()))


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_health_changed(health: int) -> void:
	if health > 0 or dead: return
	death()


func death() -> void:
	dead = true
	stampable_sprite.trigger_burn_fx()
	stampable_sprite.burned.connect(queue_free)
