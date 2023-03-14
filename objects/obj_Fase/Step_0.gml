


//if (mouse_check_button_pressed(mb_left)) get_camada(mouse_x, mouse_y);

#region Transformação
image_angle -= .5;

if crescendo {
	escala = lerp(escala, 1, .03);
	
	if (escala >= .99) crescendo = false;
} else {
	escala = lerp(escala, .8, .03);
	
	if (escala <= .81) crescendo = true;
}
image_xscale = escala;
image_yscale = escala;
#endregion


#region Particulas (talvez seja melho usar um sistema que recicle particulas)
/*
if (estado = estados_fase.Ativa) {
	var max_particulas = 10 + 20 *position_meeting(mouse_x,mouse_y, id);

	while qtd_particulas < max_particulas {
		instance_create_depth(x,y, depth+1, obj_Particula,{
			pai : id,
			sprite_index : spr_particula1,
			image_blend : other.image_blend,
			escala : choose(.5, .6, .7),
			direcao : irandom(359),
			veloc : (irandom(4) + 1)/5
		});
	
		qtd_particulas++;
	}

}*/
#endregion

/*
if (estado == estados_fase.Bloqueada) {
	if (sprite_index != spr_faseBloqueada) sprite_index = spr_faseBloqueada;
} else if (sprite_index != spr_fase) sprite_index = spr_fase;


/*
switch(estado)
{
	case estados_fase.Bloqueada:
	{
		
		break;
	}
	
	case estados_fase.Ativa:
	{
		
		break;
	}
	
	case estados_fase.Completa:
	{
		
		break;
	}
}
