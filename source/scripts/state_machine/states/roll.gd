class_name RollState
extends State

@export var idle_state: IdleState
@export var move_component: MoveComponent
@export var input_component: InputComponent

var direction: Vector2
var timer: SceneTreeTimer

func enter(_a: CharacterController3D) -> void:
	timer = get_tree().create_timer(0.5)
	direction = Vector2(input_component.movement_input.x, input_component.movement_input.z)


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	input_component.set_horizontal_input_direction(direction)
	input_component.block()
	if is_zero_approx(timer.time_left):
		transitioned.emit(self, idle_state)
		input_component.unblock()
		move_component.stop_horizontal_movement(delta)
		input_component.set_horizontal_input_direction(Vector2.ZERO)
