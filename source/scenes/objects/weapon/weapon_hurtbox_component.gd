class_name WeaponHurtboxComponent
extends HurtboxComponent

@export var animation_player: AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"hit"):
		if attack_info.is_ranged: _handle_ranged()
		else: _handle_melee()
		get_viewport().set_input_as_handled()


func _handle_ranged() -> void:
	var projectile: AttackProjectile = attack_info.projectile.instantiate()
	projectile.attack_info = attack_info
	projectile.top_level = true
	projectile.lifetime = 2
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	var mouse_dir: Vector2 = _get_mouse_dir()
	projectile.look_at(global_position + Vector3(mouse_dir.x, 0.0, mouse_dir.y))


func _handle_melee() -> void:
	animation_player.play(&"hit")


func _get_mouse_dir() -> Vector2:
	var vp_middle: Vector2 = get_viewport().get_visible_rect().size / 2
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	return vp_middle.direction_to(mouse_pos).normalized()
