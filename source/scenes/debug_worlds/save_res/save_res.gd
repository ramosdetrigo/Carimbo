extends Node2D


@export var resources: Array[Texture2D] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for res: Texture2D in resources:
		res.get_image().save_png(res.resource_path.replace("tres", "png"))
	get_tree().quit()
