config =			require '../../config'

TimeoutQueue =		require '../util/TimeoutQueue'
NumericValue =		require '../util/NumericValue'
GameError =			require '../util/GameError'

Building =			require '../core/Building'
Research =			require '../core/Research'





class Smithy extends Building



	# isSmithy

	# researches
	# researched
	# timeFactor



	constructor: (props) ->
		@isSmithy = true
		props.type = 'smithy'
		super props

		@researches = new TimeoutQueue()
		@researched = {}
		for type of config.units
			@researched[type] = !!config.units[type].researched
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
		@researches.add research
		return research





module.exports = Smithy
