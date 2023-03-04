
#region VARIÁVEIS
	//	Propriedades
estadoDaFase = estados_fase.Bloqueada;
numeroDaFase = 0;
numeroDaCamada = 0;
isPrincipal = false;
isFinal = false;

	// Dados
//isAnteriorConcluida = false;
ids_proximasFases = array_create(3, noone);
//angulos = array_create(1, 3);

	//	Aparência
image_blend = c_white;
image_index = random(image_number);
crescendo = true;
escala = choose(.8, .9, 1);
qtd_particulas = 0;


#endregion

randomize();


#region CONSTRUTOR
construtor = function(estadoDaFase, numeroDaFase, isPrincipal, anguloOrigem) {
	
	// 1. defini as caracteristicas básicas passadas
	self.estadoDaFase = estadoDaFase;
	self.numeroDaFase = numeroDaFase;
	numeroDaCamada = numeroDaFase + isPrincipal;
	self.isPrincipal = isPrincipal;
	
	/* 2. decide as caracteristicas avaçadas
		quantas mais fases vai gerar (Se principal, gera pelo menos um ou fira fase final)
		...*/
	var quantidadeDeFases; //, quantidadeMinima;
	switch(numeroDaFase) {
		case 0:
			quantidadeDeFases = 3;
			//quantidadeMinima = 3;
		break;
		
		case 1:
		case 2:
			isFinal = true;
			// pode gerar até no maximo três fases opicionalmente (minimo 1 se for principal)
			quantidadeDeFases = 0 //choose(0, 1, 1, 2) + isPrincipal;
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
#endregion


#region GERADOR DE FASES ADICIONAIS
gerar_fases_adicionais = function(quantidade, /*quantidadeMinima,*/ anguloOrigem) {
	//ir testando aos poucos. Caso fique muito pesado, realizar todo o processo de forma lenta.
	
	
	{/*}	1. Escolhe um ângulo e checa se este é válido, se não tenta concertar
		.1 é valido se:
			está dentro da tela;
			não está na direção do angulo de origem; (se igual a -1, então não há origem)
			não está com o ângulo proximo ao ângulo de outra fase;
			não está muito próximo a outra fase
		.2 guardar temporariamente esse ângulo para passar de anguloOrigem e compara-lo com os proximos
		
		//if (angulos[1] < 0 or angulos[1] > 359) angulos[1] -= sign(angulos[1]) * 360;
		//if (angulos[2] < 0 or angulos[2] > 359) angulos[2] -= sign(angulos[2]) * 360;
	*/}
	
	var angulos = array_create(quantidade, 0);
	if (numeroDaFase == 0) {
		angulos[0] = irandom(359);
		angulos[1] = irandom_range(80, 150);
		angulos[2] = irandom_range(90, 190 - (angulos[1]-80));
		
		var direcao = choose(-1, 1);
		angulos[1] = angulos[0] + angulos[1] * direcao;
		angulos[2] = angulos[0] + angulos[2] * -direcao;
	} else {
		
		//Rascunho: cria os angulos de forma que:
		//	Se for principal, obrigatoriamente vai para a proxima camada (explicado melhor no calculos da distância)
		//	Se não, cria na camada atual ou (mais raramente) cria na próxima camada (dividindo espaço com o seu principal, caso haja)
		
		//angulos[0] = anguloOrigem + 180 + irandom(35) * choose(-1, 1);
		
		/*
		if (quantidade > 1) { //possibilidade de transtormar em um for
			
			if(quantidade > 2) {
				
			}
		}*/
	}
	
	for(var i = 0; i < quantidade; i++) {
		/* 2. decide caracteristicas básicas
			Caracteristicas da fase por exemplo*/
	
		/* 3. cria a fase definindo suas caracteristicas (usar metodo construtor)
			.1 caracteristicas:
				é principal
				numero (distancia da origem)
				estado (Bloqueado)
				tipo de fase
				...*/
		
		{/*}	Rascunho: Camadas de fase
		Criar uma função em que a distancia seja medida tanto em relação a fase geradora quanto
		a primeira (Raiz), fazendo assim a distância de todas as fases com mesmo numero N ou N-1,
		mas sendo uma fase principal, seja relativamente próxima.
		Com isso vai ser possivel dividir as fases em "grupos de camadas" que vão sendo liberadas
		conforme você passa fases da "camada" anterior, impedindo o player de apenas avançar direto
		em uma ramificação ignorando as fases anteriores.
		*/}
		var distancia = 60 + irandom_range(numeroDaFase*2, (numeroDaFase+1)*3)*10;
		
		ids_proximasFases[i] = instance_create_layer(x + lengthdir_x(distancia, angulos[i]), y + lengthdir_y(distancia, angulos[i]), "Fases", obj_Fase);
		ids_proximasFases[i].construtor(estados_fase.Ativa, numeroDaFase+1, true, angulos[i]-180);
		
		//show_message(string(ids_proximasFases[i]));
			
		// 4. Procurar ao redor se há fases com um número diferente do seu para se conectarem
			
		// 5. repetir o processo pelo numero de vezes passado
	}
	
	for(var i = array_length(ids_proximasFases)-1; i >= 0; i--) {
		if (ids_proximasFases[i] == noone) array_pop(ids_proximasFases);
		else break;
	}
	
}
#endregion
