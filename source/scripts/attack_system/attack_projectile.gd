class_name AttackProjectile
extends AttackScene

@export var speed: float = 5.0
@export var projectile_life_time: float = 0.5


func _physics_process(delta: float) -> void:
	global_position += _get_direction() * speed * delta
	super._physics_process(delta)


func _handle_particle() -> void:
	if not particle: particle = _get_particle()
	if not particle: return
	particle.set_emitting(true)
	lifetime_depleted.connect(_par)


func _get_direction() -> Vector3:
	var yaw: float = global_transform.basis.get_euler().y
	return Vector3.FORWARD.rotated(Vector3.UP, yaw).normalized()


func _par() -> void:
	particle.reparent(get_parent_node_3d())
	get_tree().create_timer(projectile_life_time).timeout.connect(particle.queue_free)
