extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in get_children():
		if c is not AnimatedSprite3D: continue
		for i in range(randi_range(1, 100)):
			c.stamp(preload("res://assets/tmp/carimbo.png"))
		c.position.x = randi_range(-20, 20)
		c.position.z = randi_range(-5, 20)
		(c as AnimatedSprite3D).play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	%Label.text = str(Engine.get_frames_per_second())
