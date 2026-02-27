class_name StateMachine
extends Node

@export var initial_state: State

@export var attack_state: MeleeAttackState
@export var ranged_state: RangedAttackState
@export var hit_state: HitState

var current_state: State

func _ready() -> void:
	if get_children().size() == 0: return
	if not initial_state and get_children().size() > 0:
		initial_state = get_child(0) as State


func initialize() -> void:
	await get_tree().process_frame
	for child: Node in get_children():
		if child is State:
			(child as State).transitioned.connect(_on_state_transitioned)

	if initial_state:
		current_state = initial_state
		current_state.enter()


func _process(delta: float) -> void:
	if current_state != null: current_state.process(delta)


func _physics_process(delta: float) -> void:
	if current_state != null: current_state.physics_process(delta)


func _on_state_transitioned(from: State, to: State) -> void:
	if from != current_state: return
	current_state.exit()
	current_state = to
	current_state.enter()


func interrupt() -> void:
	set_process(false)
	set_physics_process(false)


func enable() -> void:
	set_process(true)
	set_physics_process(true)


func force_transition(to: State) -> void:
	current_state.exit()
	current_state = to
	current_state.enter()


func _on_weapon_manager_attack_melee() -> void:
	if current_state is DeathState: return
	force_transition(attack_state)


func _on_weapon_manager_attack_ranged() -> void:
	if current_state is DeathState: return
	force_transition(ranged_state)


func _on_stats_component_health_lowered() -> void:
	if current_state is DeathState: return
	force_transition(hit_state)
