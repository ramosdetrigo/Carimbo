@tool
class_name FPPhantomCamera3D
extends PhantomCamera3D

@export var should_set_priority: bool = true

func _ready():
	super._ready()
	if Engine.is_editor_hint(): return
	SceneLoader.scene_loaded.connect(_pick_player, CONNECT_ONE_SHOT)
	set_noise_emitter_layer_value(1, true)
	if should_set_priority: set_priority(1)


func _pick_player() -> void:
	set_follow_target.call_deferred(SceneLoader._player)
