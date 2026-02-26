class_name CharacterController3D
extends StampableCharacter

@export var state_machine: StateMachine

@onready var splat: AudioStreamPlayer = $Splat
@export var death_state: DeathState

static var instance: CharacterController3D

func _ready() -> void:
	if not instance: instance = self
	else: queue_free(); return
	state_machine.initialize()


func death() -> void:
	if not stampable_sprite: return
	splat.play()
	state_machine.force_transition(death_state)
