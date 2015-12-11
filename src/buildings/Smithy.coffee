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



	constructor: (options) ->
		@isSmithy = true
		options = options or {}
		options.type = 'smithy'
		super options

		@reasearches = new TimeoutQueue()
		@reasearched = {}
		for type of config.units
			@reasearched[type] = !!config.units[type].researched
		@timeFactor = new NumericValue options.timeFactor or @config.levels[@level].timeFactor or 1

		@on 'upgrade.finish', @onConstructionFinish
		@on 'downgrade.finish', @onConstructionFinish



	onConstructionFinish: (construction) =>
		@timeFactor.reset construction.config.timeFactor or 1
		# todo: speed up / slow down queued research tasks?



	research: (type) ->
		if @researched[type]
			throw new GameError "#{config.units[type].title} is already researched."

		research = new Research this, type
		@reasearches.add research
		return research





module.exports = Smithy
