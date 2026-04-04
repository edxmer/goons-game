function staydata_get_value(staydata,value_name){
	for (var i=0;i<array_length(staydata);i++)
	{
		if staydata[i][0]==value_name
		{
			return [true,staydata[i][1]]
		}
	}
	return [false,-1]
}

function staydata_set_value(staydata,value_name,setto){
	for (var i=0;i<array_length(staydata);i++)
	{
		if staydata[i][0]==value_name
		{
			staydata[i][1]=setto
			return true
		}
	}
	return false
}

function staydata_lower_value(staydata,value_name)
{
	var val_start=staydata_get_value(staydata,value_name)
	if !val_start[0]
	{
		return false
	}
	else
	{
		staydata_set_value(staydata,value_name,val_start[1]-1)
	}
}