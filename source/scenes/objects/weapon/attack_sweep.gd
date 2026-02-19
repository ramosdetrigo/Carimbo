class_name AttackProjectile
extends Node3D

@export var attack_info: AttackInfo
@export var lifetime: float = 0.5
@export var speed: float = 5.0

@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent


func _ready() -> void:
	if hurtbox_component:
		hurtbox_component.hit.connect(queue_free)
		hurtbox_component.attack_info = attack_info


func _physics_process(delta: float) -> void:
	if is_zero_approx(lifetime): return queue_free()
	var direction: Vector3 = _get_direction() * speed
	global_position += direction * delta
	lifetime -= delta


func _get_direction() -> Vector3:
	var yaw: float = global_transform.basis.get_euler().y
	return Vector3.FORWARD.rotated(Vector3.UP, yaw).normalized()
