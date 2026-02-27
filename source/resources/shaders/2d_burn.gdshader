shader_type canvas_item;

uniform sampler2D burn_texture;
uniform float burn_amount: hint_range(0.0, 1.0, 0.01);
uniform float burn_size: hint_range(0.0, 0.5, 0.001) = 0.15;
uniform float burn_smoothness: hint_range(0.0, 0.2, 0.001) = 0.133;
uniform vec3 burn_glow_color: source_color = vec3(1.0, 0.32, 0.0);
uniform float burn_glow_intensity: hint_range(0.0, 10.0, 0.1) = 10.0;

void fragment() {
	vec4 cor_og = texture(TEXTURE, UV);
	
	float burn_noise = texture(burn_texture, UV).r * (1.0 - burn_size) + burn_size;
	float burn_val = step(burn_amount, burn_noise);
	COLOR.a = cor_og.a * burn_val;
	
	// glow mask
	float glow_mask = 0.0;
	float border_size = burn_amount + burn_size;
	glow_mask = 1.0 - smoothstep(
		border_size - burn_smoothness,
		border_size + burn_smoothness,
		burn_noise * (1.0 - burn_smoothness) + burn_smoothness
	);
	
	vec3 glow_color = burn_glow_color * burn_glow_intensity * glow_mask;
	COLOR.rgb = mix(cor_og.rgb, glow_color, burn_amount);
	//COLOR.rgb = mix(cor_og.rgb, vec3(0.0), glow_mask);
}

