# todo: what if this file doesn't get required -> `….add …` will break



Array::add = Array::push


Array::remove = (thing) ->
	i = @indexOf thing
	if i >= 0
		@splice i, 1





uid = (length = 6) ->
	# Shortest possible random ID generator
	# Leon Ochmann <leonochmann@outlook.com>, Jannis R <mail@jannisr.de>
	string = (Math.random() * 26 + 10 | 0).toString 36    # random letter
	while --length
		string += (Math.random() * 36 | 0).toString 36    # random letter or digit
	return string





module.exports =
	uid:			uid
