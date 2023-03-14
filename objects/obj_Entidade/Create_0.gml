
#region VARIÁVEIS
	//	Propriedades
estadoMovimentacao_H = "Parado H";
estadoMovimentacao_V = "Parado V"

	//	Movimentação
velh = 0;
velv = 0;
acel_base = .2; //+.1
desacel_base = .1; //+.1
veloc_base = 3; //+.5

	//Ataque
shoot_cooldown = 0;
shoot_cooldown_time = room_speed*.5; //-.1;
	
	//	Status


#endregion


calcular_velocidade = function(_veloc, _direcao, _isHorizontal, _teclaDirecional) {
	var veloc_max;
	if (_isHorizontal) veloc_max = lengthdir_x(veloc_base, _direcao) * _teclaDirecional;
	else veloc_max = lengthdir_y(veloc_base, _direcao) * _teclaDirecional;

	var _string;

	var sinalCombina = (sign(_veloc) == sign(veloc_max))
	var parado = (_veloc == 0);
	
	if (abs(_veloc) < abs(veloc_max)) { //Aceleração
		_veloc += acel_base * sign(veloc_max);
		_string = "Acelerando";
		
	} else if ((abs(_veloc) < abs(veloc_max) + acel_base) and (sinalCombina and not parado)) { //Estabilização
		_veloc = veloc_max;
		_string = "Estabilizando";
		
	} else if ((abs(_veloc) > abs(veloc_max) + acel_base) or not sinalCombina) { //Desaceleração
		_veloc -= min(desacel_base, abs(_veloc)) * sign(_veloc);
		_string = "Desacelerando"
		
	} else {
		_string = "Parado";
	}
	
	
	//if ((abs(_veloc) < abs(veloc_max)) and (sinalCombina or parado)) { //Aceleração
	//	_veloc += acel_base * sign(veloc_max);
	//	_string = "Acelerando";
		
	//} else if ((abs(_veloc) < abs(veloc_max) + acel_base) and (sinalCombina and not parado)) { //Estabilização
	//	_veloc = veloc_max;
	//	_string = "Estabilizando";
		
	//} else if ((abs(_veloc) > abs(veloc_max) + acel_base) or not sinalCombina) { //Desaceleração
	//	_veloc -= min(acel_base, abs(_veloc)) * sign(_veloc);
	//	_string = "Desacelerando"
		
	//} else {
	//	_string = "Parado";
	//}
	
	if (_isHorizontal) {
		estadoMovimentacao_H = string_concat(_string, " H\n", _veloc);
	} else {
		estadoMovimentacao_V = string_concat(_string, " V\n", _veloc);
	}
	
	
	return _veloc;
}
