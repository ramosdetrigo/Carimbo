class_name SceneLoaderAutoload
extends Node

signal progress_changed(progress: float)
signal scene_loaded()
signal scene_failed()

var scene_path: String
var progress: Array = []
var use_sub_threads: bool = true

var _player: CharacterController3D
var _player_dest_pos: Vector3

func _ready() -> void: set_process(false)


func _process(_delta: float) -> void:
	if not scene_path: return
	var status: ResourceLoader.ThreadLoadStatus = \
		ResourceLoader.load_threaded_get_status(scene_path, progress)
	match status:
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			set_process(false)
			printerr("Scene Failed")
			scene_failed.emit()
		ResourceLoader.THREAD_LOAD_IN_PROGRESS: progress_changed.emit(progress.front())
		ResourceLoader.THREAD_LOAD_LOADED:
			_change_to_scene(ResourceLoader.load_threaded_get(scene_path))


func load_scene(_scene_path: String):
	# TODO: insert loading scene logic here
	start_load(_scene_path)


func load_scene_with_player(_scene_path: String,
		player: CharacterController3D, destination: Vector3 = Vector3.ZERO):
	_player_dest_pos = destination
	_player = player
	load_scene(_scene_path)


func start_load(_scene_path: String):
	scene_path = _scene_path
	var state: Error = ResourceLoader.load_threaded_request(_scene_path, "PackedScene", use_sub_threads)
	set_process(state == OK)


func _change_to_scene(scene: PackedScene) -> void:
	set_process(false)
	_player.reparent(self)
	get_tree().change_scene_to_packed(scene)
	await get_tree().scene_changed
	_player.reparent(get_tree().current_scene)
	_player.set_global_position.call_deferred(_player_dest_pos)
	scene_loaded.emit()
