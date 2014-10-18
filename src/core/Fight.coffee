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
# wallBasicDefense				attackingSurvived
# wallDefenseFactor				defendingSurvived
# catapultsTargetLevel	->		wallNewLevel
# morale						catapultsTargetNewLevel
# nightBonus					haul
# luck
fight = (options) ->
	options = options or {}

	# input
	attacking =				options.attacking or new Units()
	defending =				options.defending or new Units()
	wallBasicDefense =		options.wallBasicDefense or 0
	wallDefenseFactor =		options.wallDefenseFactor or 1
	catapultsTargetLevel =	options.catapultsTargetLevel or 0
	morale =				options.morale or 1
	nightBonus =			options.nightBonus or true
	luck =					options.luck or 0

	# output
	attackingDead =				new Units()
	defendingDead =				new Units()
	attackingSurvived =			new Units()
	defendingSurvived =			new Units()
	wallNewLevel =				0
	catapultsTargetNewLevel =	0
	haul =						new Resources()


	# todo: complete & refactor
	# warning: WIP!

	# todo: incorporate morale
	# todo: incorporate night bonus

	# todo: rams?

	# normal fight
	x = attacking.infantry().offense() * defending.defenseInfantry()
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





module.exports = fight
