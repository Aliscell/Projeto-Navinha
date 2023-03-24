
if (keyboard_check_pressed(vk_end)) game_restart();

if (keyboard_check_pressed(vk_control)) exibir_camadas = !exibir_camadas;

if (id_faseOrigem == noone) {
	if instance_exists(obj_Fase_1) id_faseOrigem = instance_find(obj_Fase_1, 0);
	else id_faseOrigem = instance_create_layer(0,0, "Fases", obj_Fase_1);
	
	with (id_faseOrigem) {
		x = room_width/2;
		y = room_height/2;
		construirFase();
	}
}
