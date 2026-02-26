@tool
class_name EnemyCharacter
extends StampableCharacter

@export var beehave_tree: BeehaveTree
@export var stats_component: StatsComponent

func _ready() -> void:
	if not stats_component: stats_component = get_children().filter(
		func(c: Node) -> bool: return c is StatsComponent).front()
	if not beehave_tree: beehave_tree = get_children().filter(
		func(c: Node) -> bool: return c is BeehaveTree).front()


func on_being_hit() -> void:
	beehave_tree.disable()
	stampable_sprite.play(&"hit")
	if stampable_sprite.sprite_frames.get_animation_loop(&"hit"): await stampable_sprite.animation_looped
	else: await stampable_sprite.animation_finished
	beehave_tree.enable()
