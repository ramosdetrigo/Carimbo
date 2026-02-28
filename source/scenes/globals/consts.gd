extends Node

const CARIMBO: Texture2D = preload("uid://bvav1abqdnltd")

const PARTICLE_SPARK: PackedScene = preload("uid://mgp02mkor0at")

var BUS_MUSIC: int = AudioServer.get_bus_index("Music")
var BUS_SOUNDS: int = AudioServer.get_bus_index("Sounds")

var MENUS: Dictionary[String, PackedScene] = {
	"main": load("res://scenes/ui/menu/submenus/main.tscn"),
	"config": load("res://scenes/ui/menu/submenus/config.tscn"),
	"credits": load("res://scenes/ui/menu/submenus/credits.tscn"),
}

class SONGS:
	const BATTLE1: AudioStreamInteractive = preload("res://assets/sounds/music/battle_music1.tres")
	const MENU: AudioStreamInteractive = preload("res://assets/sounds/music/menu_music.tres")
