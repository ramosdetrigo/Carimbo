class_name Healerbox
extends Area3D

@export var heal_amount: float = 5.0
@export_group("Give Rune")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var rune_enable: bool = false
@export var rune: Rune

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body is not CharacterController3D: return
	var b: CharacterController3D = body
	b.stats.set_health_call(func(c: float) -> float: return c + heal_amount)
	if not rune_enable: return
	elif not rune: return
	WeaponManager.instance.append_rune(rune)
