@tool
class_name MeleeAttackState
extends State

@export var walk: MoveState
@export var roll: RollState

func enter() -> void:
	animated_sprite.stop()
	animated_sprite.play(animation_name)
	await animated_sprite.animation_finished
	transitioned.emit(self, walk)


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	if Input.is_action_just_pressed(&"roll"):
		transitioned.emit(self, roll)
