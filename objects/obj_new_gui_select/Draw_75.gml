// Inherit the parent event
event_inherited();

if !on_mouse && slider_selected
{
	draw_nametag_gui(string(gooning_goons_count())+"/"+string(useful_goons_count()))
}
else if option_change_hover
{
	draw_nametag_gui(options_changes_current.name)
}