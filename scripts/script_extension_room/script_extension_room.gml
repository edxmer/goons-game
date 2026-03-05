function goto_extension_room_main_menu(room_id){
	if asset_get_type(room_id)== asset_room
	{
		room_persistent = true
		global.pause_sprite = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
		room_goto(room_id)
	
	}
}