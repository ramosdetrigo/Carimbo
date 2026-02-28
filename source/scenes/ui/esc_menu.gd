extends CanvasLayer

@onready var ui_root: Control = %UIRoot
@onready var music_slider: HSlider = %MusicSlider
@onready var sounds_slider: HSlider = %SoundsSlider
@onready var fullscreen: CheckBox = %Fullscreen

var open: bool = false
var fade_tween: Tween
@export var fade_time: float = 0.2

func _ready() -> void:
	var a: ConfigHandler.AudioSettings = SaveSys.load_audio_settings()
	music_slider.value = a.music_volume
	sounds_slider.value = a.sounds_volume
	fullscreen.set_pressed(SaveSys.load_video_settings().fullscreen)


func open_menu() -> void:
	open = true
	if fade_tween: fade_tween.kill()
	get_tree().paused = true
	show()
	fade_tween = create_tween()
	fade_tween.tween_property(ui_root, "modulate", Color.WHITE, fade_time)
	fullscreen.grab_focus()


func close_menu() -> void:
	open = false
	if fade_tween: fade_tween.kill()
	get_tree().paused = false
	fade_tween = create_tween()
	fade_tween.tween_property(ui_root, "modulate", Color.TRANSPARENT, fade_time)
	await fade_tween.finished
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		_toggle_menu()


func _toggle_menu() -> void:
	if open:
		close_menu()
	else:
		open_menu()


func _on_sounds_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(Consts.BUS_SOUNDS, value)
	SaveSys.save_audio_setting("sounds", value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(Consts.BUS_MUSIC, value)
	SaveSys.save_audio_setting("music", value)


func _on_fullscreen_toggled(toggle: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN \
		if toggle else DisplayServer.WINDOW_MODE_WINDOWED)
	SaveSys.save_video_setting("fullscreen", toggle)


func quit(source: AnimatedButton) -> void:
	source.burned.connect(get_tree().quit, CONNECT_ONE_SHOT)
