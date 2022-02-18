shader_type canvas_item;
const float TAU = 6.283185307;
const float PI = 3.1415;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	float sintime = 0.5*sin(-PI/4. + TIME*TAU/4.);
	COLOR *= sqrt(sintime*sintime);
}