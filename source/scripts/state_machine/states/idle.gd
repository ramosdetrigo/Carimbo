@tool
class_name IdleState
extends State

@export var move_state: MoveState
@export var move_component: MoveComponent
@export var input_component: InputComponent



func enter() -> void:
	animated_sprite.play(animation_name)


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	move_component.apply_gravity(delta)
	move_component.stop_horizontal_movement(delta)

	if not is_zero_approx(input_component.movement_input.length()):
		transitioned.emit(self, move_state)
