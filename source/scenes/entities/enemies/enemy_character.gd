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
	if health > 0: return
	death()


func death() -> void:
	var t: Tween = create_tween()
	t.tween_property((stampable_sprite.material_override as ShaderMaterial),
		"shader_parameter/burn_amount", 1.0, 1.2)
	t.tween_interval(0.5)
	t.tween_callback(queue_free)
