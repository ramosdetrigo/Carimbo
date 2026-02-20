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


static func is_flag_true(value: int, flag: Flags) -> bool:
	return value & (1 << flag) != 0

func _validate_property(property: Dictionary) -> void:
	if property.name == "flags":
		property.hint = PROPERTY_HINT_FLAGS
		property.hint_string = ",".join(Flags.keys())
