extends AudioStreamPlayer

func _ready() -> void:
	bus = "Music"
	AudioServer.set_bus_volume_linear(Consts.BUS_MUSIC, 0.3)
