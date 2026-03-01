extends Control

class Scene:
	var texture: CompressedTexture2D
	var dialogue: DialogueResource
	func _init(txt: CompressedTexture2D, dg: DialogueResource) -> void:
		texture = txt
		dialogue = dg

@onready var image: TextureRect = %Image
@onready var audio_player: AudioStreamPlayer = %AudioStreamPlayer
@export var trans_time: float = 2.0
var tween: Tween



var intro_scenes: Array[Scene] = [
	Scene.new(
		preload("res://assets/textures/intro/intro1.png"),
		preload("res://resources/dialog/intro/outro.dialogue")
	),
]

func _ready() -> void:
	image.modulate = Color.TRANSPARENT
	await get_tree().create_timer(1.0).timeout

	await _play_scene(intro_scenes[0])

	SceneLoader.load_scene("uid://dbdx47nsgglcq") # level 1


func _play_scene(scene: Scene) -> void:
	image.texture = scene.texture
	_image_fade_in()
	await tween.finished
	DialogueManager.show_dialogue_balloon(scene.dialogue)
	await DialogueManager.dialogue_ended
	_image_fade_out()
	await tween.finished
	await wait()


func _reset_tween() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)


func _image_fade_in() -> void:
	_reset_tween()
	image.scale = Vector2(1.5, 1.5)
	image.rotation_degrees = randf_range(-5.0, 5.0)

	tween.tween_property(image, "modulate", Color.WHITE, trans_time);
	tween.tween_property(image, "scale", Vector2.ONE, trans_time);
	tween.tween_property(image, "rotation", 0.0, trans_time);

func _image_fade_out() -> void:
	_reset_tween()
	tween.tween_property(image, "modulate", Color.TRANSPARENT, trans_time);

func wait(time: float = 1.0) -> void:
	await get_tree().create_timer(time).timeout
