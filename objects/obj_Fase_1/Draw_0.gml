
draw_circle_color(x, y, 18, image_blend, image_blend, false);


with(dadosFase) {
	if !isFinal {
		for(var i = 0; i < array_length(ids_fasesConectadas); i++) {
			var _x = ids_fasesConectadas[i].x;
			var _y = ids_fasesConectadas[i].y;
	
			draw_line_color(other.x,other.y, _x,_y, c_dkgray, c_gray);
		}
	}
}

draw_set_color(c_black);
draw_set_halign(fa_middle);
draw_set_valign(fa_center);
draw_text(x,y, string(dadosFase.numeroDaFase));
draw_set_valign(-1);
draw_set_halign(-1);
draw_set_color(-1);
