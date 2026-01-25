global.cam={}
global.select_mode=false

global.goo_count = 0

global.text_box_gui_active = false

items_scatter_start_of_game(["logs"],5)
items_scatter_start_of_game(["rock"],4)
items_scatter_start_of_game(["banana","sock","logs","logs","rock","rock","cigarette"],16)

create_item(10,30,"logs")
create_item(10,30,"cigarette")

create_item(100,20,"logs")
create_item(70,40,"logs")
