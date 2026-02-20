class_name PlayerInputComponent
extends InputComponent

@export var weapon_manager: WeaponManager


func _unhandled_input(_event: InputEvent) -> void:
	var input_dir: Vector2 = Input.get_vector(
		&"move_left", &"move_right", &"move_fowards", &"move_backwards")
	set_horizontal_input_direction(input_dir)
	if not weapon_manager: return
	if _event.is_action_pressed(&"hit"):
		input_dir = _get_mouse_dir()
		weapon_manager.attack(Vector3(input_dir.x, 0.0, input_dir.y))


func _get_mouse_dir() -> Vector2:
	var vp_middle: Vector2 = get_viewport().get_visible_rect().size / 2
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	return vp_middle.direction_to(mouse_pos).normalized()
