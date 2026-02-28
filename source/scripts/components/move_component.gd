class_name MoveComponent
extends Node

@export var actor: StampableCharacter
@export var input_component: InputComponent

@export var speed: float = 10.0

var blocked: bool = false

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	if not blocked: move_horizontally(delta)


func apply_gravity(delta: float) -> void:
	if not actor.is_on_floor(): actor.velocity += actor.get_gravity() * delta


func move_horizontally(_delta: float) -> void:
	if not actor.is_on_floor(): return
	var direction: Vector3 = input_component.movement_input
	var desired_velocity: Vector3 = direction * speed
	actor.velocity = Vector3(desired_velocity.x, actor.velocity.y, desired_velocity.z)


func stop_horizontal_movement(delta: float) -> void:
	actor.velocity = actor.velocity.move_toward(Vector3(0.0, actor.velocity.y, 0.0), delta)


func block() -> void: blocked = true
func unblock() -> void: blocked = false


func _on_launch(_block: bool) -> void:
	(block if _block else unblock).call()
