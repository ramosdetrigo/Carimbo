@tool
class_name DeathState
extends State

@export var loop_death_animation: String
@onready var phantom_camera_3d: PhantomCamera3D = %PhantomCamera3D

func enter() -> void:
	phantom_camera_3d.set_priority(10000)
	animated_sprite.play(animation_name)
	await animated_sprite.animation_finished
	animated_sprite.play(loop_death_animation)

	SceneLoader.load_scene("uid://dbx0mdbod3dh8")


func exit() -> void: pass


func process(_delta: float) -> void: pass


func physics_process(_delta: float) -> void: pass


func _validate_property(property: Dictionary) -> void:
	super._validate_property(property)
	if property.name == "loop_death_animation" and animated_sprite:
		property.hint = PROPERTY_HINT_ENUM_SUGGESTION
		property.hint_string = ",".join(animated_sprite.sprite_frames.get_animation_names())
