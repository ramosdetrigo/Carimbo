class_name CharacterController3D
extends StampableCharacter

@export var state_machine: StateMachine

static var instance: CharacterController3D

func _ready() -> void:
	if not instance: instance = self
	else: queue_free(); return
	state_machine.initialize(self)


func death() -> void:
	if not stampable_sprite: return
	stampable_sprite.trigger_burn_fx()
