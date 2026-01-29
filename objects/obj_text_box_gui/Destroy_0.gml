
instance_destroy(skip_btn_id)


var _hoverng_arr_ind = array_get_index(global.gui_hovering, self)
if (_hoverng_arr_ind != -1) {
	array_delete(global.gui_hovering, _hoverng_arr_ind, 1)
}