# todo: what if this file doesn't get required -> `….add …` will break



Array::has = (thing) -> @indexOf(thing) >= 0


Array::add = Array::push


Array::remove = (thing) ->
	return false unless @has thing
	@splice @indexOf(thing), 1
	return true





module.exports = {}
