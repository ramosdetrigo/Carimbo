class_name Submenu
extends VBoxContainer

signal change_menu(new_menu: Submenu)

@export var buttons: Array[Button]
var fade_tween: Tween

func _ready() -> void:
	_fade_in()
	change_menu.connect(_fade_out)

static func _is_node_visible(node: Control) -> bool:
	return node.visible

func _disable_buttons() -> void:
	for button: Button in buttons:
		button.disabled = true

func _fade_out(_m: PackedScene, time: float = 1.0) -> void:
	if fade_tween: fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate", Color.TRANSPARENT, time)

func _fade_in(time: float = 1.0) -> void:
	modulate = Color.TRANSPARENT
	if fade_tween: fade_tween.kill()
	fade_tween = create_tween()
	fade_tween.tween_property(self, "modulate", Color.WHITE, time)
