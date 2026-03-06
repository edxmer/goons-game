sound_play_category_at(global.npc_data.npc_to_draw.sound,mouse_x,mouse_y)

coin_spr=spr_coin
summon_flies_amount=[]
coin_particle_coords=[-1000,-1000]
coin_shake_meter=0

if global.npc_data.show_money
{
	coin_particle_coords=[50,30]
}

returning_items=[]

change_modifier_npc_max=7
change_modifier_npc=change_modifier_npc_max
change_modifier_npc_second=change_modifier_npc_max>>2

hovering_offering_index=-1
hovering_offering_item_id="empty"
hovering_offering_textbox_sprite=-1


npc_draw_x=1000
npc_draw_y=420