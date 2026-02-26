extends CanvasLayer

@onready var rune_selector_container: HBoxContainer = %RuneSelectorContainer
@onready var selected_rune: TextureRect = %SelectedRune
@onready var vida: TextureProgressBar = %Vida


func on_rune_change(rune: Rune) -> void:
	selected_rune.set_texture(rune.large_icon)


func on_runes_updated(runes: Array[Rune]) -> void:
	for rune: Rune in runes:
		if rune_selector_container.get_children().any(_run_filter.bind(rune)): return
		var texture: TextureRect = TextureRect.new()
		texture.set_texture(rune.icon)
		texture.set_expand_mode(TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL)
		texture.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT_CENTERED)
		texture.set_name(rune.name)
		rune_selector_container.add_child(texture)


func _run_filter(c: Node, rune: Rune) -> bool:
	return c is TextureRect and (c as TextureRect).texture == rune.icon


func _on_health_changed(health: float, stats_component: StatsComponent) -> void:
	vida.set_max(stats_component.max_health)
	vida.set_value(health)
