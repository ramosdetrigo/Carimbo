@tool
class_name Rune
extends Resource

@export var name: String:
	set(v): name = v; resource_name = name
@export var icon: Texture2D
@export var large_icon: Texture2D
@export var attack_scene: PackedScene
@export var rune_scene: PackedScene
@export var cooldown: float = 0.5
