
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

#endregion


#region ATIRAR
if shoot and shoot_cooldown == 0 {
	var id_obj = instance_create_layer(x, y-8, "Projeteis", obj_Projetil);
	id_obj.construtor(id, 0, -3);
	shoot_cooldown = shoot_cooldown_time;
}
#endregion


#region MOVIMENTAÇÃO
var direcao = point_direction(0,0, (right - left), (down - up));

velh = calcular_velocidade(velh, direcao, true, direcionalH);

velv = calcular_velocidade(velv, direcao, false, direcionalV);

show_debug_message("velh: {0} | velv: {1}", velh, velv);
move_and_collide(velh, velv, obj_InimigoBase); //Trocar função por uma "feita a mão"
if (x < 80) or (room_width-80 < x) {
	x = clamp(x, 80, room_width-80);
	velh = 0;
}

if (y < 16) or (room_height-16 < y) {
	y = clamp(y, 16, room_height-16);
	velv = 0;
}
#endregion
