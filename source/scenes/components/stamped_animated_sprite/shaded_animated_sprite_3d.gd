@tool
class_name StampedAnimatedSprite3D
extends AnimatedSprite3D

var material: ShaderMaterial = material_override


func _ready() -> void:
	frame_changed.connect(update_shader_anim)
	update_shader_anim()
	update_viewport_size()


## Desenha uma imagem por cima do sprite
func stamp(image: Texture2D) -> void:
	%Stamp.texture = image
	%StampViewport.render_target_update_mode = SubViewport.UPDATE_ONCE


## Atualiza o tamanho do viewport de carimbos de acordo com a animação
func update_viewport_size() -> void:
	var max_x: int = 0
	var max_y: int = 0
	
	# Itera por cada frame de cada animação
	for anim in sprite_frames.get_animation_names():
		for f in sprite_frames.get_frame_count(anim):
			var tex = sprite_frames.get_frame_texture(anim, f)
			max_x = max(max_x, tex.get_width())
			max_y = max(max_y, tex.get_height())
	
	var size = Vector2(max_x, max_y)
	%StampViewport.size = size
	%Stamp.position = size / 2.0
	%Stamp.scale = Vector2(0.5, 0.5)


## Atualiza a texture no shader de acordo com a animação atual
func update_shader_anim() -> void:
	var curr_frame = sprite_frames.get_frame_texture(animation, frame)
	material.set_shader_parameter("texture_albedo", curr_frame)
