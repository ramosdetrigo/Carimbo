class_name AttackProjectile
extends AttackScene

const MONSTER_GROUP = BeehaveConsts.MONSTER_NODE_GROUP

@export var speed: float = 5.0
@export var projectile_life_time: float = 0.5
@export var homing: bool = false

var _cached_enemy: EnemyCharacter

func _physics_process(delta: float) -> void:
	var dir: Vector3 = _get_direction().move_toward(_get_enemy_direction(), delta * 8)\
		if homing else _get_direction()
	look_at(global_position + dir)
	global_position += dir * speed * delta
	super._physics_process(delta)


func _handle_particle() -> void:
	if not particle: particle = _get_particle()
	if not particle: return
	particle.set_emitting(true)
	lifetime_depleted.connect(_par)


func _get_direction() -> Vector3:
	var yaw: float = global_transform.basis.get_euler().y
	return Vector3.FORWARD.rotated(Vector3.UP, yaw).normalized()


func _get_enemy_direction() -> Vector3:
	if not is_instance_valid(_cached_enemy) or not _cached_enemy:
		_cached_enemy = get_nearest_enemy()
	if not _cached_enemy: return _get_direction()
	return global_position.direction_to(_cached_enemy.global_position)


func _par() -> void:
	particle.reparent(get_parent_node_3d())
	get_tree().create_timer(projectile_life_time).timeout.connect(particle.queue_free)


func get_nearest_enemy() -> EnemyCharacter:
	var enemies: Array = get_tree().get_nodes_in_group(MONSTER_GROUP)\
		.filter(func(c: Node) -> bool:
			return c is EnemyCharacter and (c as EnemyCharacter).stats_component)
	var nearest: float = INF
	var nearest_enemy: EnemyCharacter
	for enemy: EnemyCharacter in enemies:
		var distance: float = enemy.global_position.distance_to(global_position)
		if distance > nearest: continue
		nearest = distance
		nearest_enemy = enemy
	return nearest_enemy
