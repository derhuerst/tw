###
todo: make Fight compute a typical fight:
- rams?
- normal fight
- scouts fight
- rams?
- catapults
- spying
- haul
- nobleman
###
config =			require '../../config'
helpers =			require '../util/helpers'
Units =				require '../util/Units'
Resources =			require '../util/Resources'





haul = (stored, capacity) ->
	v = [stored.wood, stored.clay, stored.iron]
	isnt0 = (x) -> x isnt 0

	# balance the values
	while capacity isnt 0 and v.some isnt0
		part = capacity / v.filter(isnt0).length
		capacity = 0
		v = v
			.map (x) -> if x isnt 0 then x - part else x
			.map (x) ->
				return x if x > 0
				capacity -= x
				return 0

	# round them, keeping the sum
	d = 0
	v = v.map (x) ->
		rounded = if d >= 0 then Math.floor(x) else Math.ceil(x)
		d += rounded - x
		return rounded

	v = new Resources wood: v[0], clay: v[1], iron: v[2]
	return stored.clone().subtract v



# attacking							attackingDead
# defending							defendingDead
# catapultsTargetLevel	->			wallNewLevel
# morale							catapultsTargetNewLevel
# nightBonus						haul
# luck
simulate = (props = {}) ->
	# default values
	props.attacking ?=				new Units()
	props.defending ?=				new Units()
	props.wallBasicDefense ?=		0
	props.wallDefenseFactor ?=		1
	props.catapultsTargetLevel ?=	0
	props.morale ?=					1
	props.nightBonus ?=				config.nightBonus.active Date.now()
	props.luck ?=					0

	# output
	attackingDead =					new Units()
	defendingDead =					new Units()
	wallNewLevel =					0
	catapultsTargetNewLevel =		0
	haul =							0


	# todo: complete & refactor
	# warning: WIP!

	# todo: incorporate morale
	# todo: incorporate night bonus

	# todo: rams?

	# normal fight
	x = props.attacking.infantry().offense() * props.defending.defenseGeneral()
	x += props.attacking.cavalry().offense() * props.defending.defenseCavalry()
	x *= props.wallDefenseFactor
	x += props.wallBasicDefense
	x = Math.pow(props.attacking.offense(), 2) / x + props.luck / 100
	if x < 1
		attackingDead.add props.attacking
		defendingDead.add props.defending.clone().multiply(Math.pow x, 1.5).round()
	else
		attackingDead.add props.attacking.clone().multiply(Math.pow x, -1.5).round()
		defendingDead.add props.defending


	# scout fight
	xScouts = props.attacking.subset('scout').offenseScouts()
	xScouts /= props.defending.subset('scout').defenseCavalry()
	if xScouts < 1
		attackingDead.scout = props.attacking.scout
	else
		attackingDead.scout = Math.round props.attacking.scout * Math.pow x, -1.5

	# todo: rams?

	# todo: catapults

	return {attackingDead, defendingDead, wallNewLevel, catapultsTargetNewLevel, haul}





module.exports = {haul, simulate}
