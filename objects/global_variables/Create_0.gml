global.cam={}
global.select_mode=false

global.grid_mode=true
global.should_be_gridmode=false
global.grid_mode_sprite=spr_empty
global.grid_mode_max_points_of_interests=-1
global.grid_mode_poi_texture=spr_empty

global.island_unlocked=false
global.room_height=740
global.camera_room_height=920

global.goo_count = 0

global.objective_list = ["banana"]

global.reward_level=1

global.reward_mode=false
global.goon_edit_mode=false
global.pause_menu=false
global.special_mode=false
global.goon_edit_id=noone
global.special_coords=[0,0]
global.special_zoom_done=false

global.loaded_from_save=false

global.last_selected_goon=noone

global.is_hovering_gui = false
global.gui_hovering = []

global.camera_size=1

special_objectives_init()
//global.goon_count=0
if does_save_exist(global.open_save_name) && open_save(global.open_save_name)
{
	global.loaded_from_save=true

}
else
{

instance_create_depth(x,y,0,obj_tutorial_messages)

create_goon((room_width>>1)+20,(global.room_height>>1)+30)
create_goon((room_width>>1)+70,(global.room_height>>1)+10)
create_goon((room_width>>1)-90,(global.room_height>>1)+2)
create_work_station((room_width>>1)+400,(global.room_height>>1)+200,"trashcan")
create_work_station((room_width>>1)+500,300,"tree")
create_work_station((room_width>>1)-500,global.room_height-300,"sign")
create_work_station((room_width>>1)-300,(global.room_height>>1)-200,"woodcutter")
create_work_station(room_width>>1,global.room_height>>1,"primordeal_goo")
create_work_station((room_width>>1)+200,(global.room_height>>1)+irandom_range(-40,40),"goonificator")

create_item((room_width>>1)+300,(global.room_height>>1)+200,"goo")
items_scatter_start_of_game(["goo"],1)
items_scatter_start_of_game(["antlers"],1)
items_scatter_start_of_game(["hoe"],1)
items_scatter_start_of_game(["snow_globe"],1)
items_scatter_start_of_game(["constructors_belt"],1)
items_scatter_start_of_game(["ice_cream"],1)
items_scatter_start_of_game(["hammer"],1)
items_scatter_start_of_game(["logs"],10)
items_scatter_start_of_game(["rock"],7)
items_scatter_start_of_game(["banana","sock","logs","logs","rock","rock","cigarette"],20)
}

