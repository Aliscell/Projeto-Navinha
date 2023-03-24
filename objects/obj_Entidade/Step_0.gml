
#region COMANDOS
var up, down, right, left, shoot//, dash;
up = keyboard_check(ord("W"));
down = keyboard_check(ord("S"));
right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
shoot = keyboard_check(ord("J"));
//dash = keyboard_check_pressed(ord("K"));

var direcionalH = (right ^^ left);
var direcionalV = (down ^^ up);
#endregion

#region CONTROLE DE BUFFERS
if (shoot_cooldown > 0) shoot_cooldown--;
//...
#endregion


#region ATIRAR
if shoot and shoot_cooldown == 0 {
	var id_obj = instance_create_layer(x, y-8, "Projeteis", obj_Projetil);
	id_obj.construtor(id, 0, -5);
	shoot_cooldown = shoot_cooldown_time;
}
#endregion


#region MOVIMENTAÇÃO
var direcao = point_direction(0,0, (right - left), (down - up));
velh = calcular_velocidade(velh, direcao, true, direcionalH);
velv = calcular_velocidade(velv, direcao, false, direcionalV);

move_and_collide(velh, velv, obj_InimigoBase);

if (x-sprite_xoffset < 162) or (room_width-162 < x+sprite_xoffset) {
	x = clamp(x, 161+sprite_xoffset, room_width-161-sprite_xoffset);
	velh = 0;
}
if (y-sprite_yoffset < 0) or (room_height < y+sprite_xoffset) {
	y = clamp(y, 0+sprite_yoffset, room_height-sprite_yoffset);
	velv = 0;
}

show_debug_message("velh: {0} | velv: {1}", velh, velv);
#endregion
