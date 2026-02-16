extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		if c is not AnimatedSprite3D: continue
		c.position.x = randi_range(-10, 10)
		c.position.z = randi_range(-10, 10)
		(c as AnimatedSprite3D).play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%Label.text = str(Engine.get_frames_per_second())
