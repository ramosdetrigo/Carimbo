@tool
class_name SceneDoor
extends Area3D

signal locked()
signal unlocked()

@export var marker_position: Vector3:
	set(v): marker_position = v; notify_property_list_changed()
@export var is_locked: bool = false:
	set(v): is_locked = v; (locked if is_locked else unlocked).emit()

@export_group("Destination", "destination_")
@export_file("*.tscn") var destination_scene: String
@export var destination_position: Vector3

var position_marker: Marker3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if not position_marker:
		position_marker = Marker3D.new()
		add_child(position_marker)
		position_marker.set_position(Vector3(2.0, 0.0, 0.0))


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint(): return
	if marker_position != position_marker.global_position:
		marker_position = position_marker.global_position


func change_to_scene(player: CharacterController3D) -> void:
	lock()
	SceneLoader.load_scene_with_player(destination_scene, player, destination_position)


func lock() -> void: is_locked = true;
func unlock() -> void: is_locked = false;


func _on_body_entered(body: Node3D) -> void:
	if is_locked or destination_scene.is_empty(): return
	if body is CharacterController3D: change_to_scene.call_deferred(body)


func _validate_property(property: Dictionary):
	if property.name == "marker_position":
		property.usage |= PROPERTY_USAGE_READ_ONLY
