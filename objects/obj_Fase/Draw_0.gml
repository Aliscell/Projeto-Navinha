
draw_self();
if (estadoDaFase = enum_estadosFase.Ativa) draw_sprite_ext(spr_faseAuxiliar, 0, x,y, escala,escala, 0, c_white, 1);


draw_set_halign(fa_center)
draw_set_valign(fa_top)
draw_text(x, y+18, string_concat(numeroDaFase, "(", numeroDaCamada, ")"))
draw_set_valign(-1)
draw_set_halign(-1)

if !isFinal {
	for(var i = 0; i < array_length(ids_proximasFases); i++) {
		var _x = ids_proximasFases[i].x;
		var _y = ids_proximasFases[i].y;
	
		draw_line(x,y, _x,_y);
	}
}

draw_circle_color(x,y,2, c_black, c_black, false);