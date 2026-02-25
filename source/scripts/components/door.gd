class_name SceneDoor
extends Area3D

signal locked()
signal unlocked()

@export_file("*.tscn") var destination_scene: String
@export var destination_position: Vector3
@export var lock: bool = false:
	set(v): lock = v; (locked if lock else unlocked).emit()

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func change_to_scene(player: CharacterController3D) -> void:
	SceneLoader.load_scene_with_player(destination_scene, player, destination_position)


func _on_body_entered(body: Node3D) -> void:
	if lock or destination_scene.is_empty(): return
	if body is CharacterController3D: change_to_scene.call_deferred(body)
