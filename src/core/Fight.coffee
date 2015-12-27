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
helpers =			require '../util/helpers'
Units =				require '../util/Units'
Resources =			require '../util/Resources'




# attacking						attackingDead
# defending						defendingDead
# catapultsTargetLevel	->		wallNewLevel
# morale						catapultsTargetNewLevel
# nightBonus					haul
# luck
fight = (props = {}) ->
	# input
	attacking =				props.attacking or new Units()
	defending =				props.defending or new Units()
	wallBasicDefense =		props.wallBasicDefense or 0
	wallDefenseFactor =		props.wallDefenseFactor or 1
	catapultsTargetLevel =	props.catapultsTargetLevel or 0
	morale =				props.morale or 1
	nightBonus =			props.nightBonus or true
	luck =					props.luck or 0

	# output
	attackingDead =				new Units()
	defendingDead =				new Units()
	wallNewLevel =				0
	catapultsTargetNewLevel =	0
	haul =						new Resources()


	# todo: complete & refactor
	# warning: WIP!

	# todo: incorporate morale
	# todo: incorporate night bonus

	# todo: rams?

	# normal fight
	x = attacking.infantry().offense() * defending.defenseGeneral()
	x += attacking.cavalry().offense() * defending.defenseCavalry()
	x *= wallDefenseFactor
	x += wallBasicDefense
	x = Math.pow(attacking.offense(), 2) / x + luck / 100
	if x < 1
		attackingDead.add attacking
		defendingDead.add defending.clone().multiply(Math.pow x, 1.5).round()
	else
		attackingDead.add attacking.clone().multiply(Math.pow x, -1.5).round()
		defendingDead.add defending


	# scout fight
	xScouts = attacking.subset('scout').offenseScouts()
	xScouts /= defending.subset('scout').defenseCavalry()
	if xScouts < 1
		attackingDead.scout = attacking.scout
	else
		attackingDead.scout = Math.round attacking.scout * Math.pow x, -1.5

	# todo: rams?

	# todo: catapults

	return {attackingDead, defendingDead, wallNewLevel, catapultsTargetNewLevel, haul}





module.exports = fight
