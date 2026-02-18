@abstract
class_name StampStrategy
extends Resource
## Base Abstract class for a modular upgrade system for the stamps

@export var stamp_texture: Texture2D

## Called before the attack
@abstract func apply_upgrade(weapon: AttackInfo) -> void;

## Called after the target is damaged
@abstract func on_damaged(target: CharacterBody3D) -> void;
