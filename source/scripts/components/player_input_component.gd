class_name PlayerInputComponent
extends InputComponent

@export var weapon_manager: WeaponManager
@export var hit_noise: PhantomCameraNoiseEmitter3D

var _last_move_input: Vector3
var is_gamepad: bool = true
var aim: Vector3 = Vector3.RIGHT

func _unhandled_input(event: InputEvent) -> void:
	is_gamepad = not (event is InputEventKey or event is InputEventMouseButton) \
		and (event is InputEventJoypadButton or event is InputEventJoypadMotion)
	if blocked: return
	_handle_movement()
	aim = gamepad_aim() if is_gamepad else mouse_aim()


func _process(_delta: float) -> void:
	if Input.is_action_pressed(&"hit")\
		and Input.get_action_strength(&"hit") > 0.8 and weapon_manager: _handle_hit()


func _handle_movement() -> void:
	var input_dir: Vector2 = Input.get_vector(
		&"move_left", &"move_right", &"move_fowards", &"move_backwards")
	set_horizontal_input_direction(input_dir)


func _handle_hit() -> void:
	weapon_manager.attack(aim)
	hit_noise.emit()


func set_input_direction(value: Vector3) -> void:
	if not blocked: movement_input = value
	if movement_input: _last_move_input = movement_input


func gamepad_aim() -> Vector3:
	if movement_input: return movement_input
	return aim


func mouse_aim() -> Vector3:
	return weapon_manager.global_position.direction_to(MousePointing.get_mouse_pos())
