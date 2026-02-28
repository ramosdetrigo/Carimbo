extends AudioStreamPlayer

func _ready() -> void:
	bus = "Music"
	process_mode = PROCESS_MODE_ALWAYS


func play_song(song: AudioStream) -> void:
	if stream != song:
		stop()
		stream = song
		play()
