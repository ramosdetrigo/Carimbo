class_name MoveState
extends State

@export var idle_state: IdleState
@export var roll_state: RollState
@export var move_component: MoveComponent
@export var input_component: InputComponent


func enter(_a: CharacterBody3D) -> void:
	pass


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	move_component.apply_gravity(delta)
	move_component.move_horizontally(delta)

	if Input.is_action_just_pressed(&"move_roll"):
		transitioned.emit(self, roll_state)
	elif is_zero_approx(input_component.get_horizontal_input_direction().length()):
		transitioned.emit(self, idle_state)
