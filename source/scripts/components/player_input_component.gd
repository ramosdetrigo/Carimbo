class_name PlayerInputComponent
extends InputComponent

@export var weapon_manager: WeaponManager

var _last_move_input: Vector3
var is_gamepad: bool = true
var aim: Vector3 = Vector3.RIGHT

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or InputEventMouse: is_gamepad = false
	elif event is InputEventJoypadButton or InputEventJoypadMotion: is_gamepad = true
	if blocked: return
	_handle_movement()
	aim = gamepad_aim() if is_gamepad else MousePointing.get_mouse_pos()


func _process(_delta: float) -> void:
	if Input.is_action_pressed(&"hit") and weapon_manager: _handle_hit()


func _handle_movement() -> void:
	var input_dir: Vector2 = Input.get_vector(
		&"move_left", &"move_right", &"move_fowards", &"move_backwards")
	set_horizontal_input_direction(input_dir)


func _handle_hit() -> void:
	weapon_manager.attack(weapon_manager.global_position.direction_to(aim))


func set_input_direction(value: Vector3) -> void:
	if not blocked: movement_input = value
	if movement_input: _last_move_input = movement_input


func gamepad_aim() -> Vector3:
	var a: Vector2 = Input.get_vector(&"aim_left", &"aim_right", &"aim_forward", &"aim_back")
	if a: return Vector3(a.x, 0.0, a.y)
	return aim
