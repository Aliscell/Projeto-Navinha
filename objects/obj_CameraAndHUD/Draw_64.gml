
//768(448) x 432

//*
#region DESENHA HUD
if surface_exists(srf_HUD)
{
	surface_set_target(srf_HUD);
	
	{//}	Variáveis
		var display_width = display_get_gui_width();
		var display_height = display_get_gui_height();
		var x_offset = 161;
	}

	#region DESENHA BARRAS PRETAS NA TELAS
	draw_set_color(c_black);
	draw_rectangle(0,0, display_width,display_height, false);
	draw_set_color(c_white);
	
	gpu_set_blendmode(bm_subtract);
	//if(global.GameStatus == "Pausado") draw_set_alpha(.6)
	//if(!resetando)
	draw_rectangle(160,0, room_width-161,room_height, false); //draw_rectangle(0,barraSup_y, room_width,barraInf_y,false);
	//else draw_circle(player.x+6, player.y-18, raioCirculo, false);
	//draw_set_alpha(1);
	gpu_set_blendmode(bm_normal);
	#endregion
	
	var _x = map_value_ext(id_player.x, 0+x_offset, room_width-x_offset, 23, 136);
	var _y = map_value_ext(id_player.y, 0, room_height, 99, 208);
	
	draw_sprite(spr_HUD_radar01, 0, 0,32);
	draw_rectangle(_x-1,_y-1, _x+1,_y+1, false);
	
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

