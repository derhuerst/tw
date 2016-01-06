Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'
Resources =			require '../util/Resources'





class Upgrade extends Timeout



	# isUpgrade

	# building

	# _targetLevel
	# _resources
	# _workers



	constructor: (building) ->
		@isUpgrade = true
		super()

		if building?.isBuilding then @building = building or null
		else throw new ReferenceError 'Missing `building` argument.'

		@_targetLevel = 1 + @building.village.headquarter.anticipatedLevel @building
		@_resources = new Resources
			wood: @building.config.costs.wood @_targetLevel
			clay: @building.config.costs.clay @_targetLevel
			iron: @building.config.costs.iron @_targetLevel
		@_workers = @building.config.workers(@_targetLevel - 1) -
			@building.config.workers(@_targetLevel)

		@on 'start', @_onStart
		@on 'stop', @_onStop
		@on 'finish', @_onFinish

		return this



	start: ->
		return this if @running()

		targetLevel = 1 + @building.village.headquarter.anticipatedLevel @building
		if targetLevel isnt @_targetLevel
			throw new GameError "This #{@building.config.title} cannot be \
			upgraded to level #{@_targetLevel} anymore."

		if @_targetLevel > @building.config.maximalLevel
			throw new GameError "This #{@building} cannot be upgraded any further."

		if @building.village.warehouse.stocks.resources().moreThan @_resources
			@building.village.warehouse.stocks.resources().subtract @_resources
		else throw new GameError "Not enough resources to upgrade #{this}."

		# todo: check if enough workers
		@building.village.farm.workers.subtract @_workers

		duration = @building.config.costs.time @_targetLevel
		@duration().reset duration * @building.village.headquarter.timeFactor

		return super()



	_onStart: =>
		@building.emit 'upgrade.start', this

	_onStop: =>
		@building.village.warehouse.stocks.resources().add @_resources
		@building.village.farm.workers.add @_workers
		@building.emit 'upgrade.stop', this

	_onFinish: =>
		@building.level.add 1
		@building.emit 'upgrade.finish', this
		@building.emit 'upgrade', this



	toString: -> "(#{@building}) +1"





module.exports = Upgrade
