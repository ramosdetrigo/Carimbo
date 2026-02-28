extends Control

@onready var cover: ColorRect = %LogoCover

func _ready() -> void:
	cover.show()
	MusicPlayer.play_song(Consts.SONGS.MENU)
	load_configs()
	await get_tree().create_timer(1.0).timeout
	var logo_tween: Tween = create_tween()
	logo_tween.tween_property(self, "modulate", Color.BLACK, 1.0)
	logo_tween.tween_callback(cover.hide)
	logo_tween.tween_property(self, "modulate", Color.WHITE, 1.0)


func _on_change_menu(menu_scene: PackedScene) -> void:
	if not menu_scene: return
	var new_menu: Submenu = menu_scene.instantiate()
	new_menu.change_menu.connect(_on_change_menu)
	%RightMargin.add_child(new_menu)


func load_configs() -> void:
	var a: ConfigHandler.AudioSettings = SaveSys.load_audio_settings()
	AudioServer.set_bus_volume_linear(Consts.BUS_SOUNDS, a.sounds_volume)
	AudioServer.set_bus_volume_linear(Consts.BUS_MUSIC, a.music_volume)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN \
		if SaveSys.load_video_settings().fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
