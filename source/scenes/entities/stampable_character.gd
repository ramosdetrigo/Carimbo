class_name StampableCharacter
extends CharacterBody3D

@export var stampable_sprite: ShadedAnimatedSprite3D


func _physics_process(_delta: float) -> void:
	move_and_slide()


func death() -> void:
	if not stampable_sprite: return
	stampable_sprite.trigger_burn_fx()
	stampable_sprite.burned.connect(queue_free)
