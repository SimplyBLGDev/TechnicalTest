shader_type canvas_item;
render_mode blend_mix;

uniform vec3 over_exposition_color : source_color;
uniform float over_exposition : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	COLOR.rgb = mix(COLOR.rgb, over_exposition_color, over_exposition);
}
