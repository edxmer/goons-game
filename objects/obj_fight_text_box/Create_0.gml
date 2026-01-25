text=["aaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaa","aadaaaaaaaaaaaaaaaaaaaaaaaa\nb"]
print_text=""
print_text_id=1
bubble_number=0
wait=1000
ticker=0
sound=[sound_silence]
name=""

function append_char_from(texta, textb, i) {
    // make sure i is valid
    if (i > string_length(texta)) {
		wait--
		if wait<=0{
			bubble_number++
			print_text_id=1
			print_text=""
			wait=string_length(texta)*0.03+34
			return ""
		
		}
        return textb; // out of range, just return textb unchanged
    }
    wait=string_length(texta)*0.03+34
	print_text_id++
    var ch = string_char_at(texta, i);
	if ch=="¤"{
	return textb
	}
	if ch!=" " and ch!="¤" and ch!="\n"and i%3==0{
	audio_play_sound(sound[irandom_range(0,array_length(sound)-1)],1,false)
	}
    return textb + ch;
}