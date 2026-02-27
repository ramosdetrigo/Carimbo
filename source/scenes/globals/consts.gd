extends Node

const CARIMBO: Texture2D = preload("uid://bvav1abqdnltd")

const PARTICLE_SPARK: PackedScene = preload("uid://mgp02mkor0at")

var BUS_MUSIC: int = AudioServer.get_bus_index("Music")
var BUS_SOUNDS: int = AudioServer.get_bus_index("Sounds")

class SONGS:
	const BATTLE1: AudioStreamInteractive = preload("res://assets/sounds/music/battle_music1.tres")
	const MENU: AudioStreamInteractive = preload("res://assets/sounds/music/menu_music.tres")
