class_name StateMachine
extends Node

@export var initial_state: State
@export var actor: CharacterController3D

var current_state: State

func _ready() -> void:
	if get_children().size() == 0: return
	if not initial_state and get_children().size() > 0:
		initial_state = get_child(0) as State


func initialize(a: CharacterController3D) -> void:
	actor = a
	await get_tree().process_frame
	
	for child in get_children():
		if child is State:
			(child as State).transitioned.connect(_on_state_transitioned)
	
	if initial_state:
		current_state = initial_state
		current_state.enter(actor)


func _process(delta: float) -> void:
	if current_state != null: current_state.process(delta)


func _physics_process(delta: float) -> void:
	if current_state != null: current_state.physics_process(delta)


func _on_state_transitioned(from: State, to: State) -> void:
	assert(from != to, "Estado transicionando para si mesmo")
	assert(from == current_state, "Um estado que não o atual está tentando transicionar")
	
	current_state.exit()
	current_state = to
	current_state.enter(actor)
