extends Control

@onready var cover: ColorRect = %LogoCover

func _ready() -> void:
	MusicPlayer.stream = Consts.SONGS.MENU
	MusicPlayer.play()
	
	await get_tree().create_timer(1.0).timeout
	var logo_tween: Tween = create_tween()
	logo_tween.tween_property(self, "modulate", Color.BLACK, 1.0)
	logo_tween.tween_callback(cover.hide)
	logo_tween.tween_property(self, "modulate", Color.WHITE, 1.0)
	logo_tween.tween_callback(%PlayButton.grab_focus)
	


func _disable_buttons() -> void:
	for button: Button in %ButtonsVbox.get_children():
		button.disabled = true


func _on_continue_button_pressed() -> void:
	_disable_buttons()


func _on_play_button_pressed() -> void:
	_disable_buttons()
	%PlayButton.burned.connect(func():
		SceneLoader.load_scene("uid://x7n822k4igmc")) # intro


func _on_config_button_pressed() -> void:
	_disable_buttons()


func _on_credits_button_pressed() -> void:
	_disable_buttons()


func _on_exit_button_pressed() -> void:
	_disable_buttons()
	%ExitButton.burned.connect(get_tree().quit)
