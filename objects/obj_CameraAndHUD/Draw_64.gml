

//768 x 432

#region DESENHA HUD
if surface_exists(srf_HUD)
{
	surface_set_target(srf_HUD);
	
	var display_width = display_get_gui_width();
	var display_height = display_get_gui_height();
	//show_message();

	#region DESENHA BARRAS PRETAS NA TELAS
	draw_set_color(c_black);
	draw_rectangle(0,0, display_width,display_height, false);
	//draw_set_color(c_white);
	
	//gpu_set_blendmode(bm_subtract);
	//if(global.GameStatus == "Pausado") draw_set_alpha(.6)
	//if(!resetando) draw_rectangle(0,barraSup_y, room_width,barraInf_y,false);
	//else draw_circle(player.x+6, player.y-18, raioCirculo, false);
	//draw_set_alpha(1);
	//gpu_set_blendmode(bm_normal);
	#endregion

	//draw_set_color(c_black);
	//var _x1 = camera_get_view_x(view_camera[0]);
	//var _x2 = _x1 + camera_get_view_width(view_camera[0])

	//draw_rectangle(_x1,0, _x1+127,room_height, false);
	//draw_rectangle(_x2,0, _x2-127,room_height, false);

	draw_set_color(-1);
	
	surface_reset_target();
	draw_surface(srf_HUD, 0, 0);
}
else srf_HUD = surface_create(768, room_height);
#endregion


