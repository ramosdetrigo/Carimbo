extends StampableCharacter


func _on_health_changed(health: int) -> void:
	if health > 0: return
	death()


func death() -> void:
	var t: Tween = create_tween()
	t.tween_property((stampable_sprite.material_override as ShaderMaterial),
		"shader_parameter/burn_amount", 1.0, 1.2)
	t.tween_interval(0.5)
	t.tween_callback(queue_free)
