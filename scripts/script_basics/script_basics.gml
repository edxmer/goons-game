function is_subset(arr, subset) {
    var count = ds_map_create();
    
    // Count frequencies in main array
    for (var i = 0; i < array_length(arr); i++) {
        var el = arr[i];
        ds_map_set(count, el, ds_map_exists(count, el) ? count[? el] + 1 : 1);
    }
    
    // Check subset
    var result = true;
    for (var i = 0; i < array_length(subset); i++) {
        var el = subset[i];
        if (!ds_map_exists(count, el) || count[? el] <= 0) {
            result = false;
            break;
        }
        ds_map_set(count, el, count[? el] - 1);
    }
    
    ds_map_destroy(count);
    return result;
}


function draw_text_ext_transformed_bold(xx,yy,_string,sep,w,xscale,yscale,ange)
{
	draw_text_ext_transformed(xx,yy,_string,sep,w,xscale,yscale,ange)
	draw_text_ext_transformed(xx+0.1*xscale,yy,_string,sep,w,xscale,yscale,ange)
	draw_text_ext_transformed(xx-0.1*xscale,yy,_string,sep,w,xscale,yscale,ange)
}


function one_or_minus_one()
{
	return irandom_range(0,1)*2-1
}

function sprite_get_current_subimg(sprite)
{
	return floor((current_time / 1000) * sprite_get_speed(sprite)) % sprite_get_number(sprite)
}

function is_value_between(item,mmin,mmax)
{
	var minr=min(mmin,mmax)
	var maxr=max(mmin,mmax)
	return item>=minr && item<=maxr


}

function array_to_distinct(array)
{
	var dist_array=[]
	for (var i=0;i<array_length(array);i++)
	{
		if !array_contains(dist_array,array[i])
		{
			array_push(dist_array,array[i])
		}
	}
	return dist_array
}

function array_count(array,item)
{
	var count=0
	for (var i=0;i<array_length(array);i++)
	{
		if array[i]==item
		{
			count++
		}
	}
	return count
}