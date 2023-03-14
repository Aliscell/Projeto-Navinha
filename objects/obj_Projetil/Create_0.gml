
#region VARIÁVEIS
	//	Propriedades
	
	pai = noone;
	alvo = noone;
	velh = 0;
	velv = 0;


#endregion

construtor = function(_pai, _velh, _velv) {
	pai = _pai;
	velh = _velh;
	velv = _velv;
	
	if (object_get_name(pai.object_index) == obj_InimigoBase) alvo = obj_Entidade;
	else alvo = obj_InimigoBase;
	
}
