extends AttackProjectile

const POISON = preload("uid://cuaclh4kmwlyp")

func on_stick(hitbox: HitboxComponent) -> void:
	var p: Node3D = POISON.instantiate()
	hitbox.add_child(p)
	p.set_global_position.call_deferred(hitbox.global_position)
