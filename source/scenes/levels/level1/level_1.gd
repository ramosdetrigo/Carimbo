extends LevelScene

func _ready() -> void:
	if starting_dialog:
		DialogueManager.show_dialogue_balloon(starting_dialog)
	if exit_door: exit_door.lock()
	DialogueManager.dialogue_ended.connect(exit_door.unlock.unbind(1))
	DialogueManager.dialogue_ended.connect(_play_main_song)


func _play_main_song(_r = null) -> void:
	MusicPlayer.play_song(Consts.SONGS.BATTLE1)
