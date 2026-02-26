class_name PlayerInputComponent
extends InputComponent

@export var weapon_manager: WeaponManager

var _last_move_input: Vector3

func _unhandled_input(event: InputEvent) -> void:
	if blocked: return
	_handle_movement()


func _process(_delta: float) -> void:
	if Input.is_action_pressed(&"hit") and weapon_manager: _handle_hit()


func _handle_movement() -> void:
	var input_dir: Vector2 = Input.get_vector(
		&"move_left", &"move_right", &"move_fowards", &"move_backwards")
	set_horizontal_input_direction(input_dir)
	get_viewport().set_input_as_handled()


func _handle_hit() -> void:
	var mouse: Vector3 = MousePointing.get_mouse_pos()
	weapon_manager.attack(weapon_manager.global_position.direction_to(mouse))
	get_viewport().set_input_as_handled()


func set_input_direction(value: Vector3) -> void:
	if not blocked: movement_input = value
	if movement_input: _last_move_input = movement_input
