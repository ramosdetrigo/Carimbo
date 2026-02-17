class_name CharacterController3D
extends StampableCharacter

@export var state_machine: StateMachine
@export var weapon: WeaponHurtboxComponent

var move_input: Vector2 = Vector2.ZERO


func _ready() -> void:
	state_machine.initialize(self)

func _physics_process(_delta: float) -> void:
	_process_input()
	move_and_slide()


func _process_input() -> void:
	move_input = Input.get_vector(
		&"move_left", &"move_right", &"move_fowards", &"move_backwards")


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


func get_input_direction() -> Vector3:
	return Vector3(move_input.x, 0, move_input.y).normalized()


func move_horizontally() -> void:
	var direction: Vector3 = get_input_direction()
	var desired_velocity: Vector3 = direction * 9.0
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	if direction.is_zero_approx(): return
	weapon.look_at(weapon.global_position + direction)


func stop_horizontal_movement(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0.0, 8.0 * delta)
	velocity.z = move_toward(velocity.z, 0.0, 8.0 * delta)
