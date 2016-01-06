Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'





class Downgrade extends Timeout



	# isDowngrade

	# building

	# config

	# _targetLevel
	# _workers



	constructor: (building) ->
		@isDowngrade = true
		super()

		if building?.isBuilding then @building = building or null
		else throw new ReferenceError 'Missing `building` argument.'

		@_targetLevel = -1 + @building.village.headquarter.anticipatedLevel @building
		@_workers = @building.config.workers(@_targetLevel + 1) -
			@building.config.workers(@_targetLevel)

		@on 'start', @_onStart
		@on 'stop', @_onStop
		@on 'finish', @_onFinish

		return this



	start: ->
		return this if @running()

		targetLevel = -1 + @building.village.headquarter.anticipatedLevel @building
		if targetLevel isnt @_targetLevel
			throw new GameError "This #{@building.config.title} cannot be \
			downgraded to level #{@_targetLevel} anymore."

		if @_targetLevel < @building.config.minimalLevel
			throw new GameError "This #{@building} cannot be downgraded any further."

		if @building.village.headquarter.level < 15
			throw new GameError 'Your village\'s headquarter needs to be at least at level 15'

		if @building.village.loyalty < 100
			throw new GameError 'Your village\'s loyalty needs to be 100'

		duration = @building.config.costs.time @_targetLevel
		@duration().reset duration * @building.village.headquarter.timeFactor

		return super()



	_onStart: =>
		@building.emit 'downgrade.start', this


	_onStop: =>
		@building.emit 'downgrade.stop', this


	_onFinish: =>
		@building.level.subtract 1
		@building.village.farm.workers.add @_workers
		@building.emit 'downgrade.finish', this
		@building.emit 'downgrade', this



	toString: -> "(#{@building}) -1"





module.exports = Downgrade
