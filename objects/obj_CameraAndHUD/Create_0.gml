
#region VARIÁVEIS
srf_HUD = surface_create(768, room_height);

id_player = instance_create_layer(room_width/2, room_height * 3/4, "Entidades", obj_Entidade);
//id_cursorAux = instance_create_layer(room_width/2, room_height * 3/4, "Controladores", obj_Cursor_Aux);
//id_cursorAux.construirCursor(50, id_player);

#endregion

