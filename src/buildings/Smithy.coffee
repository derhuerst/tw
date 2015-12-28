config =			require '../../config'

TimeoutQueue =		require '../util/TimeoutQueue'
NumericValue =		require '../util/NumericValue'
GameError =			require '../util/GameError'

Building =			require '../core/Building'
Research =			require '../core/Research'





class Smithy extends Building



	# isSmithy

	# reasearches
	# reasearched
	# timeFactor



	constructor: (props) ->
		@isSmithy = true
		props.type = 'smithy'
		super props

		@reasearches = new TimeoutQueue()
		@reasearched = {}
		for type of config.units
			@reasearched[type] = !!config.units[type].researched
		@timeFactor = new NumericValue @config.timeFactor @level

		@on 'upgrade.finish', @onConstructionFinish
		@on 'downgrade.finish', @onConstructionFinish



	onConstructionFinish: (construction) =>
		@timeFactor.reset @config.timeFactor @level
		# todo: speed up / slow down queued research tasks?



	research: (type) ->
		if @researched[type]
			throw new GameError "#{config.units[type].title} is already researched."

		research = new Research this, type
		@reasearches.add research
		return research





module.exports = Smithy
