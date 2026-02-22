class_name StampableCharacter
extends CharacterBody3D

@export var stampable_sprite: ShadedAnimatedSprite3D
@export var invert_flip: bool = false

func _physics_process(_delta: float) -> void:
	if velocity.x != 0.0: stampable_sprite.set_flip_h(velocity.x < 0.0 if invert_flip else velocity.x > 0.0)
	move_and_slide()


func death() -> void:
	if not stampable_sprite: return
	stampable_sprite.trigger_burn_fx()
	stampable_sprite.burned.connect(queue_free)
