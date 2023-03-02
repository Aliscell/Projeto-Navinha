
#region VARIÁVEIS
	//	Propriedades
estadoDaFase = estados_fase.Bloqueada;
numeroDaFase = 0;
isPrincipal = false;
isFinal = false;

	// Dados
ids_proximasFases = array_create(3, noone);
//angulosConexoes = array_create(1, 3);

	//	Aparência
image_blend = c_white;
image_index = random(image_number);
crescendo = true;
escala = choose(.8, .9, 1);
qtd_particulas = 0;


#endregion


//randomize();

//Essa parte se tornou obsoleta, refazendo em um metodo
/*
if numeroDaFase == 0 {
	
	array_set(angulosConexoes, 0, irandom(359));
	//show_message(string_concat("angulosConexoes 1: ", angulosConexoes[0]))
	
	array_push(angulosConexoes, irandom(359));
	//show_message(string_concat("angulosConexoes 1: ", angulosConexoes[0], " | angulosConexoes 2: ", angulosConexoes[1]))
	while(abs(angulosConexoes[1] - angulosConexoes[0]) <= 70 or abs(angulosConexoes[1] - angulosConexoes[0]) >= 290) {
		angulosConexoes[1] += sign(angulosConexoes[1] - angulosConexoes[0]);
	}
	//show_message(string_concat("(CORRIGIDO) angulosConexoes 1: ", angulosConexoes[0], " | angulosConexoes 2: ", angulosConexoes[1]))
	
	array_push(angulosConexoes, irandom(359));
	//show_message(string_concat("angulosConexoes 1: ", angulosConexoes[0], " | angulosConexoes 2: ", angulosConexoes[1], " | angulosConexoes 3: ", angulosConexoes[2]))
	while(abs(angulosConexoes[2] - angulosConexoes[0]) <= 80 or abs(angulosConexoes[2] - angulosConexoes[1]) <= 80 or abs(angulosConexoes[2] - angulosConexoes[0]) >= 280 or abs(angulosConexoes[2] - angulosConexoes[1]) >= 280) {
		angulosConexoes[2] += 10; 
	}
	//show_message(string_concat("(CORRIGIDO) angulosConexoes 1: ", angulosConexoes[0], " | angulosConexoes 2: ", angulosConexoes[1], " | angulosConexoes 3: ", angulosConexoes[2]))
	
	for(var i = 0; i < 3; i++){
		var distancia = 60 + irandom(2)*10;
		ids_proximasFases[i] = instance_create_layer(x + lengthdir_x(distancia, angulosConexoes[i]), y + lengthdir_y(distancia, angulosConexoes[i]), "Fases", obj_Fase, {
			isPrincial : false,
			numeroDaFase : 1,
			estado : estados_fase.Bloqueada
		});
		
		//array_set(ids_proximasFases, i, id_obj);
		//show_message(string(id_obj));
		//ids_proximasFases[i] = id_obj;
		show_message(string(ids_proximasFases[i]));
	}
	
	
	//cria obrigatóriamente três mais fases
} else {
	if isPrincial {
		//cria pelo menos uma continuação ou vira um final (se entre numero entre 3 e 5)
	}
	//pode criar no maximo mais 2 fases
	
	//se há alguma fase com o numeroDaFase diferente próximo, cria uma conecção
}
//*/


construtor = function(estadoDaFase, numeroDaFase, isPrincipal, anguloOrigem) {
	
	// 1. defini as caracteristicas básicas passadas
	self.estadoDaFase = estadoDaFase;
	self.numeroDaFase = numeroDaFase;
	self.isPrincipal = isPrincipal;
	
	/* 2. decide as caracteristicas avaçadas
		quantas mais fases vai gerar (Se principal, gera pelo menos um ou fira fase final)
		...*/
	var quantidadeDeFases; //, quantidadeMinima;
	switch(numeroDaFase) {
		case 0:
			quantidadeDeFases = 1 //3;
			//quantidadeMinima = 3;
		break;
		
		case 1:
		case 2:
			// pode gerar até no maximo três fases opicionalmente (minimo 1 se for principal)
			quantidadeDeFases = 1 //choose(0, 1, 1, 2) + isPrincipal;
			//quantidadeMinima = 0 + isPrincipal;
		break;
		
		case 3:
			// obrigatoriamente acaba (se for principal vira uma BossBattle)
			isFinal = true;
			quantidadeDeFases = 0;
			//quantidadeMinima = 0;
		break;
	}
	
	// 3. chamar metodo gerador de fases por aqui
	if (quantidadeDeFases > 0) gerar_fases_adicionais(quantidadeDeFases, anguloOrigem);
}

gerar_fases_adicionais = function(quantidade, /*quantidadeMinima,*/ anguloOrigem) {
	//ir testando aos poucos. Caso fique muito pesado, realizar todo o processo de forma lenta.
	
	
	/* 1. escolhe um ângulo e checa se este é válido, se não tenta concertar
		.1 é valido se:
			está dentro da tela;
			não está na direção do angulo de origem; (se igual a -1, então não há origem)
			não está com o ângulo proximo ao ângulo de outra fase;
			não está muito próximo a outra fase
		.2 guardar temporariamente esse ângulo para passar de anguloOrigem e compara-lo com os proximos*/
	var angulos = array_create(quantidade, 0);
	
	
	if (numeroDaFase == 0) {
		angulos[0] = irandom(359);	
	} else {
		angulos[0] = anguloOrigem + 180 + irandom(35) * choose(-1, 1);
	}
	
	/*
	if (quantidade > 1) {
		angulos[1] = irandom(359);
		
		while(abs(angulos[1] - angulos[0]) <= 70 or abs(angulos[1] - angulos[0]) >= 290) {
			angulosConexoes[1] += sign(angulosConexoes[1] - angulosConexoes[0]);
		}
	}
	*/
	
	for(var i = 0; i < quantidade; i++) {
		// 2. decide caracteristicas básicas
	
		/* 3. cria a fase definindo suas caracteristicas (usar metodo construtor)
			.1 caracteristicas:
				é principal
				numero (distancia da origem)
				estado (Bloqueado)
				tipo de fase
				...*/
		var distancia = 60 + irandom_range(0 + numeroDaFase, 1 + numeroDaFase*2)*10;
		ids_proximasFases[i] = instance_create_layer(x + lengthdir_x(distancia, angulos[i]), y + lengthdir_y(distancia, angulos[i]), "Fases", obj_Fase);
		ids_proximasFases[i].construtor(estados_fase.Ativa, numeroDaFase+1, true, angulos[0]-180);
		
		//show_message(string(ids_proximasFases[i]));
			
		// 4. Procurar ao redor se há fases com um número diferente do seu para se conectarem
			
		// 5. repetir o processo pelo numero de vezes passado
	}
	
	for(var i = array_length(ids_proximasFases)-1; i >= 0; i--) {
		if (ids_proximasFases[i] == noone) array_pop(ids_proximasFases);
		else break;
	}
	
}

