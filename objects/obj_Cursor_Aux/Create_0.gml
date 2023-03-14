
raio = 0;
alvo = noone;
visivel = true;
seguindo = false;

velh = 0;
velv = 0;
acel_base =.2;		//com base na do player
desacel_base = .1;	//com base na do player
veloc_base = 2;		//com base na do player

construirCursor = function(_raio, _alvo = noone, _visivel = true) {
	raio = _raio;
	alvo = _alvo;
	visivel = _visivel
	
	//definir movimentação conforme o alvo (se tiver um)
}

seguirAlvo = function(_x, _y) {
	if seguindo {
		var direcao = point_direction(x,y, _x,_y);
		
		var velh_max = lengthdir_x(veloc_base, direcao);
		velh = lerp(velh, velh_max, acel_base);
		var velv_max = lengthdir_y(veloc_base, direcao);
		velv = lerp(velv, velv_max, acel_base);
	} else {
		velh = lerp(velh, 0, desacel_base);
		velv = lerp(velv, 0, desacel_base);
	}
	
}

