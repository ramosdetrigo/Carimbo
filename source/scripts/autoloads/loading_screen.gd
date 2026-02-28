class_name LoadingScreen
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

func _unhandled_input(_event: InputEvent) -> void:
	if not color_rect.visible: return
	get_viewport().set_input_as_handled()


func start_loading() -> void:
	animation_player.play(&"transition_in")
	await animation_player.animation_finished
	animation_player.play(&"mid_transition")
	await get_tree().create_timer(1.0).timeout


func close() -> void:
	animation_player.play(&"transition_out")
