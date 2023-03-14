
//numeroDaCamada = 0;
//isPrincipal = true;
//isFinal = false;

//ids_fasesConectadas = array_create(3, noone);
//angulo = array_create(3, 0);
//distancia = array_create(3, 0);

dadosFase = noone;


construirFase = function(_numeroDaFase = 0, _isPrincipal = true, _inversoOrigem = 0) {
	{/*}
		var quantidadeDeFases, quantidadeMinima;
		switch(numeroDaCamada) {
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
		
	show_message("Construindo Fase")
	var camada = abs(get_camada(x, y));
	var quantidadeDeFases;
	switch(camada) {
		case 0:
			quantidadeDeFases = 1;
		break;
		
		case 1:
			quantidadeDeFases = 0; 
		break;
		
		//case 2:
		//	quantidadeDeFases = 0; 
		//break;
	}
	
	show_message("antes de construir a struct");
	dadosFase = new fase_struct(_numeroDaFase, camada, _isPrincipal, quantidadeDeFases);
	//show_message(string_concat("struct criada: ", dadosFase));
	
	//*
	if (camada > 0) {} //criarFase_Geral(quantidadeDeFases, _inversoOrigem)
	else {
		var angulo = array_create(quantidadeDeFases, 0);
		angulo[0] = 0//irandom(359);
		
		if (quantidadeDeFases > 1) {
			var direcao = choose(-1, 1);
			
			angulo[1] = irandom_range(80, 150);
			angulo[1] = angulo[0] + angulo[1] * direcao;
			if (direcao == -1) angulo[1] += 360;
			
			if (quantidadeDeFases > 2) {
				angulo[2] = irandom_range(90, 190 - (angulo[1]-80));
				angulo[2] = angulo[0] + angulo[2] * -direcao;
				if (direcao == 1) angulo[2] += 360;
			}
		}
		
		for(var i = 0; i < quantidadeDeFases; i++) {
			var distancia = 60 + irandom(3)*10;
			
			//show_message(string_concat("angulo: ", angulo[i], " distancia: ", distancia));
			
			criarFase(distancia, angulo[i]);
		}
	} //*/
}

//criarFase_Geral = function(_quantidade, _inversoOrigem) {
//	for(var i = 0; i < _quantidade; i++) {
//		var direcaoRaiz = point_direction(x,y, room_width/2,room_height/2);
//		//var sentidoRaiz = sign(inversoOrigem - direcaoRaiz);
//		//if (abs(inversoOrigem - direcaoRaiz) < 180) sentidoRaiz = - sentidoRaiz;
//		var sentidoRaiz = (abs(_inversoOrigem - direcaoRaiz) < 180) ? -sign(_inversoOrigem - direcaoRaiz) : sign(_inversoOrigem - direcaoRaiz);
//		var angulo = 0 //funçãoDePegarÂngulo(_inversoOrigem, sentidoRaiz); (*)
		
//		#region QUANTIDADE DE PASSOS (*)
//		var passos_min = 0, passos_max = 0;
//		do {
//			passos_max++;
				
//			var _x = x + lengthdir_x(passos_max*10, angulo);
//			var _y = y + lengthdir_y(passos_max*10, angulo);
//			var camadaDestino = get_camada(_x, _y);
				
//			if (abs(camadaDestino) <= numeroDaCamada) passos_min++;
//		} until(camadaDestino <= -(numeroDaCamada+1)) or (numeroDaCamada+1 < camadaDestino);
//		passos_min = max(passos_min+1, 6 + numeroDaCamada);
//		passos_max--; //= min(passos_max-1, 3 * power(2, numeroDaCamada+1));
//		#endregion
//		var distancia = irandom_range(passos_min, passos_max)*10;
		
//		criarFase(distancia, angulo);
//	}
//}

{//}	checaEmVolta = function() {
	//	var _array = [];
		
	//	for(var i = 0; i < 18; i++) {
	//		var _x = lengthdir_x(50, i*20);
	//		var _y = lengthdir_y(50, i*20);
			
	//		if (get_camada(_x, _y) == numeroDaCamada) and (!collision_circle(_x,_y,50, obj_Fase, false, true)) array_insert(_array, array_length(_array), i);
	//	}
		
	//	return choose(_array)
	//}
}

criarFase = function(_distancia, _angulo) {
	var _x = x + lengthdir_x(_distancia, _angulo);
	var _y = y + lengthdir_y(_distancia, _angulo);
	
	var n = dadosFase.addFase(instance_create_layer(_x, _y, "Fases", obj_Fase_1));
	dadosFase.addCoordenada(_distancia, _angulo, n);
	//show_message(string_concat("Fase criada: ", dadosFase.ids_fasesConectadas[n]));
	dadosFase.ids_fasesConectadas[n].construirFase(dadosFase.numeroDaFase+1, true, 0); //dadosFase.numeroDaFase+1, true, _angulo);
}

//gerarAngulo_CamadaSeguinte = function() {}

//gerarAngulo_MesmaCamada = function() {}
