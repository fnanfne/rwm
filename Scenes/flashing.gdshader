shader_type canvas_item;

const vec4 color1 = vec4(1.0, 1.0, 1.0, 1.0);
const vec4 color2 = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	float time = sin(TIME*10.0);
	
	if(time < 0.0) {
		time = -time;
	}
	COLOR = mix(color1, color2, time);
}
