class_name ConfigHandler
extends Node

const SETTINGS_FILE_PATH: String = "user://settings.ini"

var settings: ConfigFile = ConfigFile.new()

func _ready() -> void:
	if not FileAccess.file_exists(SETTINGS_FILE_PATH):
		settings.set_value("save", "last_level", "")
		settings.set_value("audio", "music", 0.5)
		settings.set_value("audio", "sounds", 0.5)
		settings.set_value("video", "fullscreen", true)
		settings.save(SETTINGS_FILE_PATH)
	else:
		settings.load(SETTINGS_FILE_PATH)


func save_game_info(scene_path: String) -> Error:
	settings.set_value("save", "last_level", scene_path)
	return settings.save(SETTINGS_FILE_PATH)


func load_last_level() -> String:
	return settings.get_value("save", "last_level", "")


func save_audio_setting(key: String, value: float) -> Error:
	settings.set_value("audio", key, value)
	return settings.save(SETTINGS_FILE_PATH)


func load_audio_settings() -> AudioSettings:
	var a: AudioSettings = AudioSettings.new()
	a.sounds_volume = settings.get_value("audio", "sounds", 0.5)
	a.music_volume = settings.get_value("audio", "music", 0.5)
	return a


func save_video_setting(key: String, value: Variant) -> Error:
	settings.set_value("video", key, value)
	return settings.save(SETTINGS_FILE_PATH)


func load_video_settings() -> VideoSettings:
	var v: VideoSettings = VideoSettings.new()
	v.fullscreen = settings.get_value("video", "fullscreen", true)
	return v


class AudioSettings:
	var sounds_volume: float
	var music_volume: float

class VideoSettings:
	var fullscreen: bool
