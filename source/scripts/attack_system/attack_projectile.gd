class_name AttackProjectile
extends AttackScene

@export var speed: float = 5.0


func _physics_process(delta: float) -> void:
	global_position += _get_direction() * speed * delta
	super._physics_process(delta)


func _get_direction() -> Vector3:
	var yaw: float = global_transform.basis.get_euler().y
	return Vector3.FORWARD.rotated(Vector3.UP, yaw).normalized()
