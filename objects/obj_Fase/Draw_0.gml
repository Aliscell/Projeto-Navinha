
draw_self();
if (estadoDaFase = estados_fase.Ativa) draw_sprite_ext(spr_faseAuxiliar, 0, x,y, escala,escala, 0, c_white, 1);


if !isFinal {
	for(var i = 0; i < array_length(ids_proximasFases); i++) {
		//show_message(string(ids_proximasFases[i]))
		var _x = ids_proximasFases[i].x;
		var _y = ids_proximasFases[i].y;
	
		draw_line(x,y, _x,_y);
	}
}