class_name MoveState
extends State

@export var idle_state: IdleState
@export var roll_state: RollState

var actor: CharacterController3D

func enter(a: CharacterBody3D) -> void:
	actor = a


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(delta: float) -> void:
	actor.apply_gravity(delta)
	actor.move_horizontally()
	
	if Input.is_action_just_pressed(&"move_roll"):
		transitioned.emit(self, roll_state)
	elif is_zero_approx(actor.move_input.length()):
		transitioned.emit(self, idle_state)
