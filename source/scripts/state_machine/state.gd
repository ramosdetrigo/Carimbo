@tool
@abstract
class_name State
extends Node

@warning_ignore("unused_signal")
signal transitioned(from: State, to: State)

@export var animated_sprite: AnimatedSprite3D:
	set(v): animated_sprite = v; notify_property_list_changed()
@export var animation_name: String


@abstract func exit() -> void;
@abstract func enter() -> void;
@abstract func process(delta: float) -> void;
@abstract func physics_process(delta: float) -> void;


func _validate_property(property: Dictionary) -> void:
	if property.name == "animation_name" and animated_sprite:
		property.hint = PROPERTY_HINT_ENUM_SUGGESTION
		property.hint_string = ",".join(animated_sprite.sprite_frames.get_animation_names())
