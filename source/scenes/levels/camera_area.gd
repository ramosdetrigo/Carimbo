@tool
class_name CameraArea
extends Area3D

@export var camera: Camera3D

func _ready() -> void:
	if not camera: camera = _get_child_camera()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node3D) -> void:
	if Engine.is_editor_hint() or body is not CharacterBody3D: return
	camera.set_current(true)


func _on_body_exited(body: Node3D) -> void:
	if Engine.is_editor_hint() or body is not CharacterBody3D: return
	camera.set_current(false)


func _get_child_camera() -> Camera3D:
	return get_children().filter(func(c: Node) -> bool: return c is Camera3D).front()
