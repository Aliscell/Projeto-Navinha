


/*	N_base ?(* ou ^) NumeroDaCamada + irandom_range(minimo, maximo) * 10;

minimo - 0 ou mais
maximo*10 - menos que o começo da próxima camada

*/


var _x = room_width/2;
var _y = room_height/2;
	
#region Teste de camadas
if exibir_camadas {
	for(var i = 0; i < 4; i++) {
		draw_set_color(c_green);
	
		var raio = 20 * power(2, i+1) + (i+1) * 20 //30 * power(2, i+1) - i * 10
		draw_circle(_x,_y, raio, true);
	
		draw_set_color(c_red);
	
		var raio = 20 * power(2, i+2) + (i+2) * 20 - power(2, i+1) * 10
		draw_circle(_x,_y, raio, true);
	}
	draw_set_color(-1);
}
#endregion


#region Teste de câmera
if (room_width == 2560) and (room_height == 1440) {
	//tamanho da camera 1280 x 720
	var x_camera_dest = map_value(mouse_x, _x-640, _x+640, 640, room_width-640);
	x_camera = lerp(x_camera, x_camera_dest, .1);
	var y_camera_dest = map_value(mouse_y, _y-360, _y+360, 360, room_height-360);
	y_camera = lerp(y_camera, y_camera_dest, .1);

	draw_set_alpha(.7);
	draw_set_color(c_aqua);
	draw_rectangle(_x-640, _y-360, _x+640, _y+360, true);

	draw_set_color(-1)
	draw_rectangle(x_camera-640, y_camera-360, x_camera+640, y_camera+360, true);
	draw_set_alpha(1);
}
#endregion
