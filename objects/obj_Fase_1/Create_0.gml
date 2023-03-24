
//camada = 0;
//isPrincipal = true;
//isFinal = false;

//ids_fasesConectadas = array_create(3, noone);
//angulo = array_create(3, 0);
//distancia = array_create(3, 0);

dadosFase = noone;


#region CONSTRUIR FASE
construirFase = function(_numeroDaFase = 0, _isPrincipal = true, _inversoOrigem = 0) {
	{/*}
		var quantidadeDeFases, quantidadeMinima;
		switch(camada) {
			case 0:
				quantidadeDeFases = 3;
				quantidadeMinima = 3;
			break;
		
			case 1: //Gera uma fase principal e (quando houver espaço o suficiente) uma fase extra
				quantidadeDeFases = isPrincipal + 1;
				quantidadeMinima = isPrincipal;
			break;
		
			case 2: //Pode gerar até no maximo duas fases opicionalmente (+1 se for principal) (minimo 1 se for principal)
			case 3:
				quantidadeDeFases = 1; //irandom(numeroDaFase-1) + isPrincipal;
				//quantidadeMinima = numeroDaFase-2 + isPrincipal;
			break;
		
			case 4: // obrigatoriamente acaba (se for principal vira uma BossBattle)
				isFinal = true; //if (isPrincipal) isFinal = true
			break; 
		}
	*/}
	#region CONSTROI STRUCT DE DADOS
	var camada = abs(get_camada(x, y));
	var quantidadeDeFases;
	switch(camada) {
		case 0:
			quantidadeDeFases = 1;
		break;
		
		case 1:
			quantidadeDeFases = 2*_isPrincipal;
		break;
		
		case 2:
			quantidadeDeFases = 0//_isPrincipal; 
		break;
		
		//case 3:
		//	quantidadeDeFases = 0//_isPrincipal; 
		//break;
		
		//case 4:
		//	quantidadeDeFases = 0;
		//break;
	}
	if (!_isPrincipal) image_blend = c_ltgray;
	dadosFase = new fase_struct(_numeroDaFase, camada, _isPrincipal, quantidadeDeFases);
	#endregion
	
	//show_message("TESTE")
	
	#region GERA PROXIMAS FASES
	if (_isPrincipal) {
		if (camada > 0) criarFase_Geral(quantidadeDeFases, _inversoOrigem);
		else {
		//if (camada == 0) {
			var angulo = array_create(quantidadeDeFases, 0);
			angulo[0] = irandom(359);
			//angulo[1] = 120 + irandom_range(-25, 25);
			//angulo[2] = 120 + irandom_range(-25, 25);
		
			//var direcao = choose(-1, 1);
			//angulo[1] = angulo[0] + angulo[1] * direcao;
			//angulo[2] = angulo[0] + angulo[2] * -direcao;
		
			//if (direcao == 1) angulo[2] += 360;
			//else angulo[1] += 360;
		
			for(var i = 0; i < quantidadeDeFases; i++) {
				var distancia = 60 + irandom(4)*10;
			
				criarFase(distancia, angulo[i], true);
			}
		}
	}
	#endregion
}
#endregion

criarFase_Geral = function(_quantidade, _inversoOrigem) {
	for(var i = 0; i < _quantidade; i++) {
		var angulo, distancia;
		
		if (i == 0) and (dadosFase.isPrincipal or choose(true, false, false)) {
			//angulo = _inversoOrigem + (irandom_range(-25, 25) - 15);
			//distancia = gerarDistancia(angulo, dadosFase.camada+1, 6 + dadosFase.camada, 40);
			
			//if (distancia != -1) criarFase(distancia, angulo, (dadosFase.isPrincipal and i == 0));
			////else i--;
			
			////continue;
		} else { //Bug aqui ====================================================
			
			angulo = gerarAngulo_MesmaCamada(_inversoOrigem);
			distancia = gerarDistancia(angulo, dadosFase.camada, 6 + dadosFase.camada, 8 + dadosFase.camada*3);
			
			show_message(string_concat(distancia, " ", angulo));
			criarFase(distancia, angulo, false);
			
			
		//	repeat(3) {
		//		angulo = gerarAngulo_MesmaCamada(_inversoOrigem);
		//		distancia = gerarDistancia(angulo, dadosFase.camada, 6 + dadosFase.camada, 8 + dadosFase.camada*3);
			
		//		if (distancia != -1) {
		//			criarFase(distancia, angulo, false);
		//			break;
		//		}
		//	}
		}
		
		{//}
			//if (i == 0) and (dadosFase.isPrincipal or choose(true, false, false)) {
			//	angulo = _inversoOrigem + (irandom_range(-25, 25) - 15);
			//	distancia = gerarDistancia(angulo, dadosFase.camada+1, 6 + dadosFase.camada, 40);
			
			//	if (distancia != -1) criarFase(distancia, angulo, (dadosFase.isPrincipal and i == 0));
			//	else i--;
			//} else {
			//	{/*}	Rascunho
			//		pegar o angulo e a distancia em um "repeat(3){}", se o angulo e a distancia forem
			//		diferentes de -1 o repeat é encerrado com um "break" e a próxima fase é cirada,
			//		se ele tentar todas as três vezes e não conseguir ele desiste.
			//	*/}
			
			//	repeat(3) {
			//		angulo = gerarAngulo_MesmaCamada(_inversoOrigem);
			//		distancia = gerarDistancia(angulo, dadosFase.camada, 6 + dadosFase.camada, 8 + dadosFase.camada*3);
			
			//		if (distancia != -1) {
			//			criarFase(distancia, angulo, false);
			//			break;
			//		}
			//	}
			//}
		}
	}
}

#region GERA ANGULO (MESMA CAMADA)
gerarAngulo_MesmaCamada = function(_inversoOrigem) {
	var anguloOrigem = (_inversoOrigem < 180) ? _inversoOrigem+180 : _inversoOrigem-180;
	var dist_min = (6 + dadosFase.camada)*10;
	
	var angulo = 30;
	var arrayAngulos = array_create(0);
	repeat(29) { //BUG DE ESTAR RETORNANDO -1 APARENTIMETE SEM MOTIVO
		angulo += 10;
		var _x = x + lengthdir_x(dist_min, anguloOrigem + angulo);
		var _y = y + lengthdir_y(dist_min, anguloOrigem + angulo);
		
		if (dadosFase.camada != get_camada(_x, _y) or collision_circle(_x,_y, dist_min, obj_Fase_1, true, true)) continue; //criarFase só que vermelha
		else array_push(arrayAngulos, angulo);
	}
	if (array_length(arrayAngulos) == 0) return -1;
	angulo = array_get(arrayAngulos, irandom(array_length(arrayAngulos)-1));
	//show_message(string_concat(dadosFase.isPrincipal, " ", arrayAngulos, " ", angulo));
	
	return angulo;
}
#endregion

#region GERAR DISTANCIA
gerarDistancia = function(_angulo, _camadaAlvo, _minimo, _maximo) {
	if (_angulo == -1) return -1;
	
	#region DEFINE INTERVALO
	var passos_min = _minimo-1, passos_max = _minimo-1, dentroCamadaAlvo = false;
	do {
		passos_max++;
		
		var _x = x + lengthdir_x(passos_max*10, _angulo);
		var _y = y + lengthdir_y(passos_max*10, _angulo);
		var camadaAtual = get_camada(_x, _y);
		
		if (camadaAtual != _camadaAlvo) passos_min++;
		else dentroCamadaAlvo = true;
	} until (camadaAtual != _camadaAlvo and dentroCamadaAlvo)
	passos_min = max(passos_min+1, _minimo);
	passos_max = min(passos_max-1, _maximo);
	if (passos_min > passos_max) return -1;
	#endregion
	var distancia = irandom_range(passos_min, passos_max) * 10;
	//show_message(string_concat(dadosFase.isPrincipal, " [", passos_min, ",", passos_max, "] ", distancia div 10));
	return distancia;
	
	
	//#region VALIDA INTERVALO (!) IMCAPAZ DE VALIDAR INTERVALO, APENAS ESCOLHE O ULTIMO
	//var distancia = -1;
	//var arrayDistancias = array_create(0);
	//for(var i = passos_max; i <= passos_max; i++) {
	//	var _x = x + lengthdir_x(i*10, _angulo);
	//	var _y = y + lengthdir_y(i*10, _angulo);
		
	//	if (collision_circle(_x,_y, _minimo, obj_Fase_1, true, true)) continue;
	//	else array_push(arrayDistancias, i);
	//}
	//if (array_length(arrayDistancias) == 0) return -1;
	//show_message(string_concat("[", passos_min, ",", passos_max, "] ", arrayDistancias));
	//#endregion
	
	//distancia = array_get(arrayDistancias, irandom(array_length(arrayDistancias)-1)) * 10;
	//return distancia;
}
#endregion


#region CRIAR FASE
criarFase = function(_distancia, _angulo, _isPrincipal) {
	//show_message(string_concat("angulo: ", _angulo, " distancia: ", _distancia));
	var _x = x + lengthdir_x(_distancia, _angulo);
	var _y = y + lengthdir_y(_distancia, _angulo);
	
	var n = dadosFase.addFase(instance_create_layer(_x, _y, "Fases", obj_Fase_1), _distancia, _angulo);
	dadosFase.ids_fasesConectadas[n].construirFase(dadosFase.numeroDaFase+1, _isPrincipal, _angulo);
}
#endregion
