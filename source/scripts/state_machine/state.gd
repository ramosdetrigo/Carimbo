@abstract
class_name State
extends Node

@warning_ignore("unused_signal")
signal transitioned(from: State, to: State)


@abstract func exit() -> void;
@abstract func enter(actor: CharacterController3D) -> void;
@abstract func process(delta: float) -> void;
@abstract func physics_process(delta: float) -> void;
