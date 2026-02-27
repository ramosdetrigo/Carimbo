extends LevelScene

@export var animation_player: AnimationPlayer

func _ready() -> void:
	if exit_door: exit_door.lock()


func give_gift() -> void:
	animation_player.play(&"gift")
	await animation_player.animation_finished
	if animation_player.has_animation(&"rune"): animation_player.play(&"rune")


func dialog() -> void:
	if not exit_door: return
	if starting_dialog:
		DialogueManager.show_dialogue_balloon(starting_dialog)
		DialogueManager.dialogue_ended.connect(exit_door.unlock.unbind(1), CONNECT_ONE_SHOT)
		return
	exit_door.unlock()
