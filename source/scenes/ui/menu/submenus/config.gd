extends Submenu

@onready var music_slider: HSlider = %MusicSlider
@onready var sounds_slider: HSlider = %SoundsSlider

func _ready() -> void:
	super()
	music_slider.value = AudioServer.get_bus_volume_linear(Consts.BUS_MUSIC)
	sounds_slider.value = AudioServer.get_bus_volume_linear(Consts.BUS_SOUNDS)


func _on_back_button_pressed() -> void:
	change_menu.emit(Consts.MENUS["main"])


func _on_sounds_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(Consts.BUS_SOUNDS, value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(Consts.BUS_MUSIC, value)
