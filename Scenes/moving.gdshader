shader_type canvas_item;

void vertex() {
	//VERTEX += vec2(cos(TIME)*500.0); // moving diagonally
	//VERTEX += vec2(cos(TIME)*500.0, 0.0); // moving side-to-side
	//VERTEX += vec2(cos(TIME)*500.0, cos(TIME)*500.0); // also moving diagonally
	VERTEX += vec2(cos(TIME)*500.0, sin(TIME)*500.0); // moving in a circle
}

void fragment() {
	// Place fragment code here.
}