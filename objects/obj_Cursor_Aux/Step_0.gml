
if (alvo == noone) {
	var _x = mouse_x;
	var _y = mouse_y;
} else {
	var _x = alvo.x;
	var _y = alvo.y;
}

if (!point_in_circle(_x,_y, x,y,raio)) seguindo = true;
else if (point_in_circle(_x,_y, x,y,5)) seguindo = false;

seguirAlvo(_x, _y);

move_and_collide(velh, velv, all);
