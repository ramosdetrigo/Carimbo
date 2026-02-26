@tool
class_name FPPhantomCamera3D
extends PhantomCamera3D


func _ready():
	super._ready()
	if Engine.is_editor_hint(): return
	SceneLoader.scene_loaded.connect(set_follow_target.bind(SceneLoader._player))
	set_noise_emitter_layer_value(1, true)
	set_priority(1)
