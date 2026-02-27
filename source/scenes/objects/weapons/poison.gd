extends AttackScene

func _physics_process(delta: float) -> void:
	lifetime -= delta
	hurtbox_component.set_monitoring(wrapf(lifetime, 0.0, 0.5) == 0.5)
	hurtbox_component.set_monitorable(wrapf(lifetime, 0.0, 0.5) == 0.5)
