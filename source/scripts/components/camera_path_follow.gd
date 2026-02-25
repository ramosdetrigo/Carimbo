class_name CameraPathFollow
extends PathFollow3D

@export var camera: Camera3D

var player: CharacterController3D
var path: Path3D

func _ready() -> void:
	SceneLoader.scene_loaded.connect(_get_player)
	_get_player()
	path = get_parent()
	if not camera and get_child(0) is Camera3D: camera = get_child(0)
	camera.set_current(true)


func _process(_delta: float) -> void:
	if not player: set_process(false); return
	var local: Vector3 = path.to_local(player.global_position)
	progress = lerpf(progress, path.curve.get_closest_offset(local), _delta)
	#camera.look_at(player.global_position)


func _get_player() -> void:
	set_process(true)
	player = SceneLoader._player
	if not player:
		player = get_tree().get_first_node_in_group(BeehaveConsts.PLAYER_NODE_GROUP)
