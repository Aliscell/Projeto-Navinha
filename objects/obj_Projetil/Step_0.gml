




var saindo_H = (x+sprite_xoffset < 0 or room_width < x-sprite_xoffset) and (velh != 0 and sign(velh) == sign(x))
var saindo_V = (y+sprite_yoffset < 0 or room_height < y-sprite_yoffset) and (velv != 0 and sign(velv) == sign(y))
if (saindo_H or saindo_V) instance_destroy();


move_and_collide(velh, velv, alvo);