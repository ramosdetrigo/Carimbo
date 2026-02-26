@tool
class_name CameraPathFollow
extends PathFollow3D

@export var camera: Camera3D
@export var offset: Vector3

var player: CharacterController3D
var path: Path3D

func _ready() -> void:
	if not camera: camera = _get_child_camera()
	set_process(false)
	if Engine.is_editor_hint(): return
	SceneLoader.scene_loaded.connect(_get_player)
	_get_player()
	path = get_parent()
	camera.set_current(true)


func _process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	if not player: set_process(false); return
	var local: Vector3 = path.to_local(player.global_position) + offset
	progress = lerpf(progress, path.curve.get_closest_offset(local), _delta)
	#camera.look_at(player.global_position)


func _get_player() -> void:
	set_process(true)
	player = SceneLoader._player
	if not player:
		player = get_tree().get_first_node_in_group(BeehaveConsts.PLAYER_NODE_GROUP)


func _get_child_camera() -> Camera3D:
	return get_children().filter(func(c: Node) -> bool: return c is Camera3D).front()
