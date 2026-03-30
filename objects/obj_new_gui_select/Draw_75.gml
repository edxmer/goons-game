// Inherit the parent event
event_inherited();

if !on_mouse && slider_selected
{
	draw_nametag_gui(string(gooning_goons_count())+"/"+string(global.goon_count))
}