
#region COMANDOS
var up, down, right, left, shoot, dash;
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
shoot = keyboard_check(ord("J"));
dash = keyboard_check(ord("K"));

var direcionalH = (right ^^ left);
var direcionalV = (down ^^ up);
#endregion


#region ataque

#endregion


#region MOVIMENTAÇÃO
var direcao = point_direction(0,0, (right - left), (down - up));

velh_max = lengthdir_x(6, direcao) * direcionalH;

var velh_sinalCombina = sign(velh) == sign(velh_max) or sign(velh == 0);
if ((abs(velh) < abs(velh_max)) and velh_sinalCombina) velh += .3 * sign(velh_max);
else if ((abs(velh) < abs(velh_max) + .3) and velh_sinalCombina) velh = velh_max;
else if ((abs(velh) > abs(velh_max) + .3) or not velh_sinalCombina) velh -= min(.3, abs(velh)) * sign(velh);

/*
acelera
estabiliza
desacelera
*/

velv_max = lengthdir_y(6, direcao) * direcionalV;

var velv_sinalCombina = sign(velv) == sign(velv_max) or sign(velv == 0);
if ((abs(velv) < abs(velv_max)) and velv_sinalCombina) velv += .3 * sign(velv_max);
else if ((abs(velv) < abs(velv_max) + .3) and velv_sinalCombina) velv = velv_max;
else if ((abs(velv) > abs(velv_max) + .3) or not velv_sinalCombina) velv -= min(.3, abs(velv)) * sign(velv);

show_debug_message("velh: {0} | velh_max: {1}", velh, velh_max);
move_and_collide(velh, velv, all)
#endregion
