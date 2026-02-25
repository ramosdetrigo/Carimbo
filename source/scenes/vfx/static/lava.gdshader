shader_type spatial;
render_mode unshaded;

uniform sampler2D displacement_map: repeat_enable;
uniform sampler2D liquid: repeat_enable;
uniform sampler2D color_ramp: source_color;
uniform float glow_strength: hint_range(0.0, 10.0, 0.1) = 2.0;
uniform float glow_oscillation: hint_range(0.0, 1.0, 0.1) = 0.0;
uniform float displacement_strength: hint_range(0.0, 1.0, 0.01) = 0.1;
uniform vec3 displacement_vector = vec3(0.0);
uniform float displacement_speed: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(0.0, 0.0);

void vertex() {
	vec2 uv_mod = (UV - 0.5) * uv_scale + 0.5
		 + uv_offset * TIME * displacement_speed;
	
	float displacement = texture(displacement_map, uv_mod).r;
	float centered = (displacement * 2.0 - 1.0) ;
	VERTEX += displacement_vector * centered * displacement_strength;
}

void fragment() {
	//vec2 uv_mod = (UV - 0.5) * uv_scale + 0.5
		 //+ uv_offset * TIME * displacement_speed;
	
	float map = texture(liquid, UV).r;
	vec4 color = texture(color_ramp, vec2(map, 0.0));
	ALBEDO = color.rgb;
	ALPHA = color.a;
	
	EMISSION = color.rgb;
}
