extends Submenu

const INTRO_SCENE = "uid://x7n822k4igmc"

@onready var continue_button: AnimatedButton = %ContinueButton
@onready var play_button: AnimatedButton = %PlayButton

func _ready() -> void:
	super._ready()
	continue_button.set_visible(not SaveSys.load_last_level().is_empty())
	(continue_button if continue_button.visible else play_button).grab_focus()


func _on_continue_button_pressed(source: AnimatedButton) -> void:
	_disable_buttons()
	source.burned.connect(SceneLoader.load_last_paint_room, CONNECT_ONE_SHOT)


func _on_play_button_pressed(source: AnimatedButton) -> void:
	_disable_buttons()
	SaveSys.save_game_info("")
	source.burned.connect(SceneLoader.load_scene.bind(INTRO_SCENE), CONNECT_ONE_SHOT) # intro


func _on_config_button_pressed(source: AnimatedButton) -> void:
	_disable_buttons()
	source.burned.connect(change_menu.emit.bind(Consts.MENUS["config"]), CONNECT_ONE_SHOT)


func _on_credits_button_pressed(source: AnimatedButton) -> void:
	_disable_buttons()
	source.burned.connect(change_menu.emit.bind(Consts.MENUS["credits"]), CONNECT_ONE_SHOT)


func _on_exit_button_pressed(source: AnimatedButton) -> void:
	_disable_buttons()
	source.burned.connect(get_tree().quit, CONNECT_ONE_SHOT)
