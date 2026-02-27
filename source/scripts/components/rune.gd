@tool
class_name Rune
extends Resource

enum RuneFlags {
	LIFE_STEAL,
	ARMOR_PROVIDER,
}

@export var name: String:
	set(v): name = v; resource_name = name
@export var icon: Texture2D
@export var large_icon: Texture2D
@export var attack_scene: PackedScene
@export var rune_scene: PackedScene
@export var cooldown: float = 0.5
@export var flags: int = 0

func is_flag_true(flag: RuneFlags) -> bool:
	return flags & (1 << flag) != 0

func _validate_property(property: Dictionary) -> void:
	if property.name == "flags":
		property.hint = PROPERTY_HINT_FLAGS
		property.hint_string = ",".join(RuneFlags.keys().map(
			func(c:String) -> String: return c.capitalize()))
