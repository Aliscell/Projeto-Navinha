
if !instance_position(x,y, pai) {
	if (escala <= 0) instance_destroy();
	escala -= .01;
}
image_xscale = escala;
image_yscale = escala;

var _velh = velh * min(.6 + escala, 1);
var _velv = velv * min(.6 + escala, 1);

move_and_collide(_velh, _velv * escala, obj_Entidade);


/*
var _velh = sign(velh);

repeat(abs(velh)){
	x += _velh;
}

if floor(velh) < velh


var _velv = sign(velv);

repeat(abs(velv)){
	y += _velv;
}
