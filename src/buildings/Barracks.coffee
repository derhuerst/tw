TimeoutQueue =		require '../util/TimeoutQueue'
NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'
Recruitment =		require '../core/Recruitment'





class Barracks extends Building



	# isBarracks

	# recruitments
	# timeFactor



	constructor: (options) ->
		isBarracks = true
		options.type = 'barracks'
		super options

		@recruitments = new TimeoutQueue()
		@timeFactor = new NumericValue @config.timeFactor @level

		@on 'upgrade.finish', @onConstructionFinish
		@on 'downgrade.finish', @onConstructionFinish



	onConstructionFinish: (construction) =>
		@timeFactor.reset @config.timeFactor @level
		# todo: speed up / slow down queued recruitment tasks?




	recruit: (units) ->
		recruitment = new Recruitment this, units.infantry()
		@recruitments.add recruitment
		return recruitment





module.exports = Barracks
