shader_type canvas_item;
const vec2 centre = vec2(0.5);

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (COLOR.a == -1.){
		vec2 offset = UV - centre;
		COLOR = texture(TEXTURE, UV+offset*offset);
	}
}