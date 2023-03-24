
	//	Global's
//global.camadaLiberada = 1;

#region ENUM'S
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
#endregion

	//	Functions/*
// AJEITAR ESSE CONSTRUCT URGENTEMENTE
function fase_struct(_numeroDaFase, _camada, _isPrincipal, _quantidadeDeFases) constructor { //_isFinal = false, _numeroDaFase = 0
	numeroDaFase = _numeroDaFase; //só "numero"
	camada = _camada;
	isPrincipal = _isPrincipal;
	isFinal = !_quantidadeDeFases;
	
	ids_fasesConectadas = array_create(_quantidadeDeFases, noone);
	angulo = array_create(_quantidadeDeFases, 0);
	distancia = array_create(_quantidadeDeFases, 0);
	
	static addFase = function(_idFase, _distancia, _angulo) {
		for(var i = 0; i < array_length(ids_fasesConectadas); i++) {
			if (ids_fasesConectadas[i] == noone) {
				ids_fasesConectadas[i] = _idFase;
				distancia[i] = _distancia;
				angulo[i] = _angulo;
				
				return i;
			}
		}
		array_resize(ids_fasesConectadas, array_length(ids_fasesConectadas)+1)
		ids_fasesConectadas[array_length(ids_fasesConectadas)-1] = _idFase;
		distancia[i] = _distancia;
		angulo[i] = _angulo;
		return array_length(ids_fasesConectadas)-1;
		
		//show_error(string_concat("Erro ao tentar adicionar uma fase, array de tamanho: ", array_length(ids_fasesConectadas), " está totalmente cheio"), true);
	}
} //*/


function get_camada(_x, _y) {
	var numeroDaCamada = 0;
	var distancia = ceil(point_distance(_x,_y, room_width/2, room_height/2));
	
	for(var i = 1; i < 5; i++) {
		var raio_min = 20 * power(2, i) + (i) * 20
		var raio_max = 20 * power(2, i+1) + (i+1) * 20 - power(2, i) * 5
		
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

/// @function map_value_ext(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound, _limitar);
/// @arg {real} valor
/// @arg {real} menor_medida_atual
/// @arg {real} maior_medida_atual
/// @arg {real} menor_medida_desejada
/// @arg {real} maior_medida_desejada
/// @arg {boolean} limitar_valor
function map_value_ext(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound, _limitar = true) {
    var valor = map_value(_value, _current_lower_bound, _current_upper_bound, _desired_lowered_bound, _desired_upper_bound);
	if (_limitar ) valor = clamp(valor, _desired_lowered_bound, _desired_upper_bound);
	
	return valor;
}
#endregion
