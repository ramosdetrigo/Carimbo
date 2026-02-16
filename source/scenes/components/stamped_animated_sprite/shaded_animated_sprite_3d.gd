@tool
class_name StampedAnimatedSprite3D
extends AnimatedSprite3D


@export
var carimbo: Texture2D = Consts.TRANSPARENT :
	set(image):
		if image == null:
			image = Consts.TRANSPARENT
		carimbo = image
		material.set_shader_parameter("texture_carimbo", carimbo)

var material: ShaderMaterial = material_override

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	frame_changed.connect(update_shader_anim)
	update_shader_anim()


# Atualiza a texture no shader de acordo com a animação atual
func update_shader_anim() -> void:
	var curr_frame = sprite_frames.get_frame_texture(animation, frame)
	material.set_shader_parameter("texture_albedo", curr_frame)
