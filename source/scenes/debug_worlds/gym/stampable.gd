@tool
class_name StampableShadedAnimatedSprite3D
extends ShadedAnimatedSprite3D

const CARIMBO: Texture2D = preload("uid://bvav1abqdnltd")

@export var stamp_texture: Texture2D = CARIMBO


func _ready() -> void:
	super._ready()
	stamp_texture = CARIMBO


func _on_hitbox_damaged(_a: AttackInfo) -> void:
	stamp(stamp_texture)
