class_name PlayerInputComponent
extends InputComponent

@export var weapon_manager: WeaponManager

var _last_move_input: Vector3

func _unhandled_input(event: InputEvent) -> void:
	if blocked: return
	_handle_movement()
	if event.is_action_pressed(&"hit") and weapon_manager: _handle_hit()


func _get_mouse_dir() -> Vector2:
	var vp_middle: Vector2 = get_viewport().get_visible_rect().size / 2
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	return vp_middle.direction_to(mouse_pos).normalized()


func _handle_movement() -> void:
	var input_dir: Vector2 = Input.get_vector(
		&"move_left", &"move_right", &"move_fowards", &"move_backwards")
	set_horizontal_input_direction(input_dir)
	get_viewport().set_input_as_handled()


func _handle_hit() -> void:
	#var input_dir: Vector2 = _get_mouse_dir()
	weapon_manager.attack(_last_move_input)
	get_viewport().set_input_as_handled()


func set_input_direction(value: Vector3) -> void:
	if not blocked: movement_input = value
	if movement_input: _last_move_input = movement_input
