class_name LoadingScreen
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_loading() -> void:
	animation_player.play(&"transition_in")
	await animation_player.animation_finished
	animation_player.play(&"mid_transition")
	await get_tree().create_timer(1.0).timeout


func close() -> void:
	animation_player.play(&"transition_out")
