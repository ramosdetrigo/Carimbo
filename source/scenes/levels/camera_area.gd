@tool
class_name CameraArea
extends Area3D

@export var camera: PhantomCamera3D

func _ready() -> void:
	if not camera: camera = _get_child_camera()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node3D) -> void:
	if Engine.is_editor_hint() or body is not CharacterBody3D: return
	camera.set_priority(10)


func _on_body_exited(body: Node3D) -> void:
	if Engine.is_editor_hint() or body is not CharacterBody3D: return
	camera.set_priority(0)


func _get_child_camera() -> PhantomCamera3D:
	return get_children().filter(func(c: Node) -> bool: return c is PhantomCamera3D).front()
