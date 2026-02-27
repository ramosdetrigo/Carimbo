extends AudioStreamPlayer


func _ready() -> void:
	bus = "Music"
	stream = load("res://assets/sounds/music/battle_music1.tres")
	play()
