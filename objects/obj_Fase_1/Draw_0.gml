
//draw_circle_color(x, y, 18, image_blend, image_blend, false);
draw_self();

if is_struct(dadosFase) {
	with(dadosFase) {
		if !isFinal {
			for(var i = 0; i < array_length(ids_fasesConectadas); i++) {
				if(ids_fasesConectadas[i] != noone) {
					var _x = ids_fasesConectadas[i].x;
					var _y = ids_fasesConectadas[i].y;
	
					draw_line_color(other.x,other.y, _x,_y, c_dkgray, c_gray);
				}
			}
		}
	}
	
	if (dadosFase.numeroDaFase != 0) draw_circle(x,y, (6 + dadosFase.camada)*10, true)

	if (dadosFase.isFinal) draw_set_color(c_red);
	else draw_set_color(c_black);
	draw_set_halign(fa_middle);
	draw_set_valign(fa_center);
	draw_text(x,y, string_concat(dadosFase.numeroDaFase, "(", dadosFase.camada, ")"));
	draw_set_valign(-1);
	draw_set_halign(-1);
	draw_set_color(-1);
}
