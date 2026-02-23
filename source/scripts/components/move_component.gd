class_name MoveComponent
extends Node

@export var actor: StampableCharacter
@export var input_component: InputComponent

@export var speed: float = 10.0


func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move_horizontally(delta)


func apply_gravity(delta: float) -> void:
	if not actor.is_on_floor(): actor.velocity += actor.get_gravity() * delta


func move_horizontally(_delta: float) -> void:
	var direction: Vector3 = input_component.movement_input
	var desired_velocity: Vector3 = direction * speed
	actor.velocity = Vector3(desired_velocity.x, actor.velocity.y, desired_velocity.z)


func stop_horizontal_movement(delta: float) -> void:
	actor.velocity = actor.velocity.move_toward(Vector3(0.0, actor.velocity.y, 0.0), delta)
