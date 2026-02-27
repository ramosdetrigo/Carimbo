class_name InputComponent
extends Node

var blocked: bool = false
var movement_input: Vector3: set = set_input_direction
var target_pos: Vector3: set = set_target_pos

var _nav_agent: NavigationAgent3D
var _reached: bool = false

func _ready() -> void:
	DialogueManager.dialogue_started.connect(fucking_die.unbind(1))
	DialogueManager.dialogue_ended.connect(unblock.unbind(1))


func _physics_process(_delta: float) -> void:
	_update_agent_move_direction()


func set_input_direction(value: Vector3) -> void: if not blocked: movement_input = value


func set_horizontal_input_direction(value: Vector2) -> void:
	set_input_direction(Vector3(value.x, 0.0, value.y))


func set_target_pos(value: Vector3) -> void: target_pos = value


func start_navigation(agent: NavigationAgent3D, starting_pos: Vector3 = Vector3.ZERO) -> void:
	_reached = false
	_nav_agent = agent
	_nav_agent.set_target_position(target_pos)
	var dir: Vector3 = starting_pos.direction_to(_nav_agent.get_next_path_position())
	set_input_direction(dir)
	if _nav_agent and not _nav_agent.navigation_finished.is_connected(stop_navigation):
		_nav_agent.navigation_finished.connect(stop_navigation, CONNECT_ONE_SHOT)


func stop_navigation() -> void:
	set_input_direction(Vector3.ZERO)
	if _nav_agent and _nav_agent.navigation_finished.is_connected(stop_navigation):
		_nav_agent.navigation_finished.disconnect(stop_navigation)
	_nav_agent = null
	_reached = true


func block() -> void: blocked = true


func unblock() -> void: blocked = false


func fucking_die() -> void:
	stop_navigation()
	block()


func is_at_destination() -> bool: return _reached


func _update_agent_move_direction() -> void:
	if not _nav_agent: return
	var ac: Node3D = _nav_agent.get_parent()
	var dir: Vector3 = ac.global_position.direction_to(_nav_agent.get_next_path_position())
	set_input_direction(dir)
