if mouse_check_button_pressed(mb_left)
{
	if selected_index!=-1
	{
		var play_id=saves[selected_index]
		if play_id==newgame
		{
			global.open_save_name="Gootopia "+string(array_length(saves))
			room_goto(room_first_cutscene)
		}
		else
		{
			global.open_save_name=play_id
			room_goto(room_game)
		}
		
	}
}