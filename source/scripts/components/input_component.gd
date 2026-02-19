class_name InputComponent
extends Node

var blocked: bool = false
var movement_input: Vector3: set = set_input_direction, get = get_input_direction

func set_input_direction(value: Vector3) -> void:
	if blocked: return
	movement_input = value


func set_horizontal_input_direction(value: Vector2) -> void:
	set_input_direction(Vector3(value.x, 0.0, value.y))


func get_input_direction() -> Vector3:
	return movement_input.normalized()


func get_horizontal_input_direction() -> Vector2:
	return Vector2(movement_input.x, movement_input.z).normalized()


func block() -> void:
	blocked = true


func unblock() -> void:
	blocked = false
