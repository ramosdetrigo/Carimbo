@tool
class_name AttackInfo
extends Resource

enum Flags {
	CAN_BREAK_ARMOR,
	IGNORES_ARMOR,
	CAN_HIT_FLYING,
}

@export var damage: float = 1.0
#@export_custom(PROPERTY_HINT_NONE, "suffix:m") var reach: float = 2.0
@export var stamp_texture: Texture2D
@export var flags: int = 0


func is_flag_true(flag: Flags) -> bool:
	return flags & (1 << flag) != 0

func _validate_property(property: Dictionary) -> void:
	if property.name == "flags":
		property.hint = PROPERTY_HINT_FLAGS
		var keys: Array[String] = []
		for key: String in Flags.keys():
			keys.append(key.capitalize())
		property.hint_string = ",".join(keys)
