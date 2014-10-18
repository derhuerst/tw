# todo: what if this file doesn't get required -> `….add …` will break



Array::add = Array::push


Array::remove = (thing) ->
	i = @indexOf thing
	if i >= 0
		@splice i, 1





random = () ->
	min = 0
	max = 1
	round = false
	switch arguments.length
		when 3
			min = arguments[0]
			max = arguments[1]
			round = !!arguments[2]
		when 2
			if (helpers.typeof arguments[1]) is 'boolean'
				max = arguments[0]
				round = !!arguments[1]
			else
				min = arguments[0]
				max = arguments[1]
		when 1
			if (helpers.typeof arguments[0]) is 'boolean'
				round = !!arguments[0]
			else
				max = arguments[1]
	result = min + Math.random() * (max - min)
	if round
		return Math.round result
	return result





uid = (length = 6) ->
	# Shortest possible random ID generator
	# Leon Ochmann <leonochmann@outlook.com>, Jannis R <mail@jannisr.de>
	string = (Math.random() * 26 + 10 | 0).toString 36    # random letter
	while --length
		string += (Math.random() * 36 | 0).toString 36    # random letter or digit
	return string





module.exports =
	random:			random
	uid:			uid
