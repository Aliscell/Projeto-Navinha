
#region VARIÁVEIS
	//	Propriedades (Default)
estadoDaFase = enum_estadosFase.Bloqueada;
numeroDaFase = 0;
numeroDaCamada = 0;
isPrincipal = true;
isFinal = false;

	// Dados
//isAnteriorConcluida = false;
ids_proximasFases = array_create(3, noone);
//angulo = array_create(1, 3);

	//	Aparência
image_blend = c_white;
image_index = random(image_number-1);
crescendo = true;
escala = choose(.8, .9, 1);
//qtd_particulas = 0;
#endregion

randomize();



#region CONSTRUTOR
construtor = function(numeroDaFase, isPrincipal, inversoOrigem) {
	//*
	if (numeroDaFase == 0) estadoDaFase = enum_estadosFase.Ativa;
	self.numeroDaFase = numeroDaFase;
	numeroDaCamada = abs(get_camada(x, y));
	self.isPrincipal = isPrincipal;
	
	#region DECIDE QUANTAS FASES VAI GERAR
	var quantidadeDeFases; //, quantidadeMinima;
	switch(numeroDaCamada) {
		case 0:
			quantidadeDeFases = 1//3;
			//quantidadeMinima = 3;
		break;
		
		case 1: //Só gera uma fase extra e quando houver espaço o suficiente
			isFinal = true //false;
			
			quantidadeDeFases = 1; //2;
			//quantidadeMinima = isPrincipal;
		break;
		
		case 2: //Pode gerar até no maximo duas fases (+1 se for principal) opicionalmente (minimo 1 se for principal)
		case 3:
			isFinal = false;
			
			quantidadeDeFases = 1; //irandom(numeroDaFase-1) + isPrincipal;
			//quantidadeMinima = numeroDaFase-2 + isPrincipal;
		break;
		
		case 4: // obrigatoriamente acaba (se for principal vira uma BossBattle)
			isFinal = true; //if (isPrincipal) isFinal = true
		break; 
	}
	#endregion
	
	// 3. Procurar ao redor se há fases com um número diferente do seu para se conectarem
	//collision_circle(x,y, aumentaDependendoDaCamada, obj_Fase, false, true);
	
	if (!isFinal) and (quantidadeDeFases > 0) gerar_fases_adicionais(quantidadeDeFases, inversoOrigem);
	//*/
}
#endregion

#region GERADOR DE FASES ADICIONAIS
gerar_fases_adicionais = function(quantidade, inversoOrigem) {	
	var angulo = array_create(quantidade, 0);
	var distancia = array_create(quantidade, 0);
	
	if (numeroDaFase == 0) {
		angulo[0] = irandom(359); /*
		angulo[1] = irandom_range(80, 150);
		angulo[2] = irandom_range(90, 190 - (angulo[1]-80));
		
		var direcao = choose(-1, 1);
		angulo[1] = angulo[0] + angulo[1] * direcao;
		angulo[2] = angulo[0] + angulo[2] * -direcao;
		
		if (direcao == 1) angulo[2] += 360;
		else angulo[1] += 360;//*/
		for(var i = 0; i < quantidade; i++) distancia[i] = 60 + irandom(3)*10;
	} else {
		{/*}	Rascunho
			Se é principal, primeiro angulo para a próxima camada
			for(var i = isPrincipal; i < quantidade; i++)
				Decide entre essa camada e próxima (quando possivel)
				Escolhe um angulo baseado no calculo correto
				Se não existir angulo que se encaixe, desiste e parte para a proxima tentativa
			
			
			Calculo para próxima camada: angulo[i] = InversoAnguloOrigem + irandom(40) * choose(-1, 1) - 10 * (sentidoRaiz) + K;
				Sendo: sentidoRaiz = sentido que leva para a fase raiz (fase 0)
				Sendo: K = angulo necessario para não levar para fora da tela (só relevante a partir da camada 3 eu acho)
			
			Calculo para camada atual: angulo[i] = ?
				Rascunho: tomando a direcao para a fase raiz como o angulo 0, o angulo para a proxima fase deverá ser esse "0" mais
				um intervalo [70,140](?), porém deve está dentro da camada e não pode está a menos que 100(?) graus do anguloOrigem 
		*/}
		
		if (isPrincipal) {
			
			var direcaoRaiz = point_direction(x,y, room_width/2,room_height/2);
			//var sentidoRaiz = sign(inversoOrigem - direcaoRaiz);
			//if (abs(inversoOrigem - direcaoRaiz) < 180) sentidoRaiz = -sentidoRaiz;
			var sentidoRaiz = (abs(inversoOrigem - direcaoRaiz) < 180) ? -sign(inversoOrigem - direcaoRaiz) : sign(inversoOrigem - direcaoRaiz);
			
			angulo[0] = inversoOrigem + irandom(40) * choose(-1, 1) - 20 * (sentidoRaiz); //+ K;
			
			var passos_min = 0;
			var passos_max = 0;
			do {
				passos_max++;
				
				var _x = x + lengthdir_x(passos_max*10, angulo[0]);
				var _y = y + lengthdir_y(passos_max*10, angulo[0]);
				var camadaDestino = get_camada(_x, _y);
				
				if (abs(camadaDestino) <= numeroDaCamada) passos_min++;
			} until(camadaDestino <= -(numeroDaCamada+1)) or (numeroDaCamada+1 < camadaDestino);
			passos_min = max(passos_min+1, 6 + numeroDaCamada);
			passos_max--; //= min(passos_max-1, 3 * power(2, numeroDaCamada+1));
			
			distancia[0] = irandom_range(passos_min, passos_max)*10;
		}
		
		/*for(var i = isPrincipal; i < quantidade - isPrincipal; i++) {
			//Cuida do resto das fases: usa o metodo comentado(*) assim
		}*/	
	}
	
	for(var i = 0; i < quantidade; i++) {
		var _x = x + lengthdir_x(distancia[i], angulo[i]);
		var _y = y + lengthdir_y(distancia[i], angulo[i]);
		
		ids_proximasFases[i] = instance_create_layer(_x, _y, "Fases", obj_Fase);
		ids_proximasFases[i].construtor(numeroDaFase+1, true, angulo[i]);
	}
	
	for(var i = array_length(ids_proximasFases)-1; i >= 0; i--) {
		if (ids_proximasFases[i] == noone) array_pop(ids_proximasFases);
		else break;
	}
	
}
#endregion

/*
#region 
geraAngulo = function(inversoOrigem, proximaCamada) {
	checaEmVolta = function() {
		var _array = [];
		
		for(var i = 0; i < 18; i++) {
			var _x = lengthdir_x(50, i*20);
			var _y = lengthdir_y(50, i*20);
			
			if (get_camada(_x, _y) == numeroDaCamada) and (!collision_circle(_x,_y,50, obj_Fase, false, true)) array_insert(_array, array_length(_array), i);
		}
		
		return choose(_array)
	}

	var direcaoRaiz = point_direction(x,y, room_width/2,room_height/2);
	//var sentidoRaiz = sign(inversoOrigem - direcaoRaiz);
	//if (abs(inversoOrigem - direcaoRaiz) < 180) sentidoRaiz = - sentidoRaiz;
	var sentidoRaiz = (abs(inversoOrigem - direcaoRaiz) < 180) ? -sign(inversoOrigem - direcaoRaiz) : sign(inversoOrigem - direcaoRaiz);
	
	//Muda a forma de pegar o angulo conforme a inteção
	if(proximaCamada) var angulo = inversoOrigem + irandom(40) * choose(-1, 1) - 20 * (sentidoRaiz); //+ K;
	else var angulo = checaEmVolta();
		
	return angulo;
}

geraDistancia = function(proximaCamada) {
	var passos_min = 0;
	var passos_max = 0;
	do {
		passos_max++;
				
		var _x = x + lengthdir_x(passos_max*10, angulo[0]);
		var _y = y + lengthdir_y(passos_max*10, angulo[0]);
		var camadaDestino = get_camada(_x, _y);
				
		if (abs(camadaDestino) <= numeroDaCamada) passos_min++;
	} until(camadaDestino <= -(numeroDaCamada+1)) or (numeroDaCamada+1 < camadaDestino);
	passos_min = max(passos_min+1, 6 + numeroDaCamada);
	passos_max--; //= min(passos_max-1, 3 * power(2, numeroDaCamada+1));
			
	distancia[0] = irandom_range(passos_min, passos_max)*10;
}
#endregion

