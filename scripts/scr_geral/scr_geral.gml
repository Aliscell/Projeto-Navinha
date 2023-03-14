
	//	Global's
//global.camadaLiberada = 1;

	//	Enum's
enum enum_estadosFase {
	Bloqueada,
	//Desbloqueando
	Ativa,
	//...
	Completa //Concluida
}

enum enum_tiposFase {
	Padrao = c_white,
	Combate = c_red,
	//Corrida = c_blue,
	//Exploracao = c_green
}

	//	Functions/*
function fase_struct(_numeroDaFase, _camada, _isPrincipal, _quantidadeDeFases) constructor { //_isFinal = false, _numeroDaFase = 0
	numeroDaFase = _numeroDaFase;
	camada = _camada;
	isPrincipal = _isPrincipal;
	isFinal = !_quantidadeDeFases;
	//if (isPrincipal) {
	//	isFinal = (camada == 4);
	//} else {
	//	//Se (numeroDaCamada > ? and numeroDaFase > ?) or (_qtd_fasesSeguintes == 0) isFinal = true;
	//}


	ids_fasesConectadas = array_create(_quantidadeDeFases, noone);
	angulo = array_create(_quantidadeDeFases, 0);
	distancia = array_create(_quantidadeDeFases, 0);
	
	static addFase = function(_idFase) {
		var posicaoArray;
		for(var i = 0; i < array_length(ids_fasesConectadas); i++) {
			if (ids_fasesConectadas[i] == noone) {
				ids_fasesConectadas[i] = _idFase;
				posicaoArray = i;
				break;
			}
		}
		
		return posicaoArray;
	}
	
	static addCoordenada = function(_distancia, _angulo, _index) {
		distancia[_index] = _distancia;
		angulo[_index] = _angulo;
	}
	
	//static limparArrayVazio = function() {}
} //*/

function get_camada(_x, _y) {
	var numeroDaCamada = 0;
	var distancia = ceil(point_distance(_x,_y, room_width/2, room_height/2));
	
	for(var i = 1; i < 5; i++) {
		var raio_min = 20 * power(2, i) + (i) * 20
		var raio_max = 20 * power(2, i+1) + (i+1) * 20 - power(2, i) * 10
		
		if (raio_min <= distancia) and (distancia <= raio_max) {
			numeroDaCamada = i;
			break;
		} else if (raio_max < distancia) numeroDaCamada = -i;
			else if (distancia < raio_min) break;
	}
	
	return numeroDaCamada
}

#region FUNÇÃO: MAPEAR VALORES
/// @function map_value(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound);
/// @arg {real} valor
/// @arg {real} menor_medida_atual
/// @arg {real} maior_medida_atual
/// @arg {real} menor_medida_desejada
/// @arg {real} maior_medida_desejada
function map_value(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound) {
    return (((_value - _current_lower_bound) / (_current_upper_bound - _current_lower_bound)) * (_desired_upper_bound - _desired_lowered_bound)) + _desired_lowered_bound;
}
#endregion
