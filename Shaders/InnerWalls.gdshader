shader_type canvas_item;
uniform bool flashing = false;
uniform bool disappearing = true;
uniform float speed = 1;
const float TAU = 6.283185307;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (flashing){
		// total time must be a whole number for smooth transition
		float sintime;
		if (disappearing){
			sintime = sin(TAU*speed*TIME);
		} else {
			sintime = sin(TAU/2.+ TAU*speed*TIME);
		}
		COLOR *= sqrt(sintime*sintime);
	}
}