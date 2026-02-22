class_name CharacterController3D
extends StampableCharacter

@export var state_machine: StateMachine


func _ready() -> void:
	state_machine.initialize(self)


func death() -> void:
	if not stampable_sprite: return
	stampable_sprite.trigger_burn_fx()
