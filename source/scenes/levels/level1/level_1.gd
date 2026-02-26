extends LevelScene

func _ready() -> void:
	if starting_dialog:
		DialogueManager.show_dialogue_balloon(starting_dialog)
	if exit_door: exit_door.lock()
	DialogueManager.dialogue_ended.connect(exit_door.unlock.unbind(1))
