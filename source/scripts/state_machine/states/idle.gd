class_name IdleState
extends State

@export var move_state: MoveState

var actor: CharacterController3D

func enter(a: CharacterController3D) -> void:
	actor = a


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	actor.apply_gravity(delta)
	actor.stop_horizontal_movement(delta)

	if not is_zero_approx(actor.move_input.length()):
		transitioned.emit(self, move_state)
