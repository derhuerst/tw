equalUnits = (a, b) ->
	for type in [
		'spearFighter', 'swordsman', 'axeman', 'archer' # infantry
		'scout', 'lightCavalry', 'mountedArcher', 'heavyCavalry' # cavalry
		'ram', 'catapult' # siege
		'paladin', 'nobleman' # special
	]
		return false if a[type] isnt b[type]
	return true



equalDuration = (a, b) -> a.valueOf() is b.valueOf()



equalResources = (a, b) ->
	for type in ['wood', 'clay', 'iron']
		return false if a[type] isnt b[type]
	return true



equalProduction = (a, b) ->
	return false unless equalResources a.resources, b.resources
	return false unless equalDuration a.duration, b.duration
	return true





module.exports = {equalUnits, equalDuration, equalResources, equalProduction}
