TimeoutQueue =		require '../util/TimeoutQueue'
NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'
Recruitment =		require '../core/Recruitment'





class Stable extends Building



	# isStable

	# recruitments
	# timeFactor



	constructor: (options) ->
		@isStable = true
		options.type = 'stable'
		super options

		@recruitments = new TimeoutQueue()
		@timeFactor = new NumericValue @config.timeFactor @level

		@on 'upgrade.finish', @onConstructionFinish
		@on 'downgrade.finish', @onConstructionFinish



	onConstructionFinish: (construction) =>
		@timeFactor.reset @config.timeFactor @level
		# todo: speed up / slow down queued research tasks?




	recruit: (units) ->
		recruitment = new Recruitment this, units.cavalry()
		@recruitments.add recruitment
		return recruitment





module.exports = Stable
