#version 120

varying vec4 texcoord;

uniform sampler2D gcolor;

void HDR (inout vec3 color) {
	vec3 overExposed = color * 1.2f;
	vec3 underExposed = color / 2.0f;

	color = mix(underExposed, overExposed, color);
}

void vignette (inout vec3 color) {
	float dist = distance(texcoord.st, vec2(0.5f))*2.0f;
	dist /= 1.5142f;

	dist = pow(dist, 1.1f);

	color.rgb *= 1.0f - dist;
}

void main () {
	vec4 color = texture2D(gcolor, texcoord.st);
	HDR(color.rgb);

	// vignette(color.rgb);

	gl_FragColor = color;
}

// void main() {
	// float square;
	//
	// float x = 0.0;
	// float y = 0.0;
	//
	// float xt;
	// float yt;
	//
	// vec2 c = (texcoord.st*color.st - vec2(0.5, 0.5)) * 4.0*0.2f+0.5f;
	//
	// for(float i = 0.0; i < 1.0; i += 0.001) {
	// 	xt = x * x - y * y + c.x;
	// 	yt = 2.0 * x * y + c.y;
	//
	// 	x = xt;
	// 	y = yt;
	//
	// 	square = x * x + y * y;
	// 	gl_FragColor = vec4(sin(i * 2.0), i, sin(i * 2.0)* 0.5f, 0.5)  + color;
	//
	// 	if(square >= 4.0) break;
	// }

// }
