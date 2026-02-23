class_name EnemyCharacter
extends StampableCharacter

@export var beehave_tree: BeehaveTree


func on_being_hit(_h: float) -> void:
	if _h <= 0: return
	beehave_tree.disable()
	stampable_sprite.play(&"hit")
	if stampable_sprite.sprite_frames.get_animation_loop(&"hit"): await stampable_sprite.animation_looped
	else: await stampable_sprite.animation_finished
	beehave_tree.enable()
