@tool
class_name MoveState
extends State

@export var idle_state: IdleState
@export var roll_state: RollState
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
	move_component.move_horizontally(delta)
	if Input.is_action_just_pressed(&"roll"): transitioned.emit(self, roll_state)
	if is_zero_approx(input_component.movement_input.length()):
		transitioned.emit(self, idle_state)
