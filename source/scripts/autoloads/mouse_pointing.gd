class_name MousePointingAutoload
extends Node

var _view: Viewport

func _enter_tree() -> void:
	_view = get_viewport()


func get_mouse_pos() -> Vector3:
	var mouse_position := _view.get_mouse_position()
	var camera := _view.get_camera_3d()
	var origin := camera.project_ray_origin(mouse_position)
	var direction := camera.project_ray_normal(mouse_position)
	var end := origin + direction * camera.far
	var space_state := _view.get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(origin, end)
	var result := space_state.intersect_ray(query)
	return result.get("position", end)
