extends AudioStreamPlayer

func _ready() -> void:
	bus = "Music"


func play_song(song: AudioStream) -> void:
	if stream != song:
		stop()
		stream = song
		play()
