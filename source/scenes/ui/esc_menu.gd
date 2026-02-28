extends CanvasLayer

@onready var ui_root: Control = %UIRoot

var open: bool = false
var fade_tween: Tween
@export var fade_time: float = 0.2


func open_menu() -> void:
	open = true
	if fade_tween: fade_tween.kill()
	get_tree().paused = true
	show()
	fade_tween = create_tween()
	fade_tween.tween_property(ui_root, "modulate", Color.WHITE, fade_time)


func close_menu() -> void:
	open = false
	if fade_tween: fade_tween.kill()
	get_tree().paused = false
	fade_tween = create_tween()
	fade_tween.tween_property(ui_root, "modulate", Color.TRANSPARENT, fade_time)
	await fade_tween.finished
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action("escape") and event.is_pressed():
		_toggle_menu()


func _toggle_menu() -> void:
	if open:
		close_menu()
	else:
		open_menu()


func _on_sounds_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(Consts.BUS_SOUNDS, value)


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(Consts.BUS_MUSIC, value)
