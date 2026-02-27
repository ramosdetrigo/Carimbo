extends AudioStreamPlayer

func _ready() -> void:
	bus = "Music"
	
	stream = Consts.SONGS.BATTLE1
	play()
