Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'





class Upgrade extends Timeout



	# isUpgrade

	# building

	# config



	constructor: (building) ->
		@isUpgrade = true

		@building = building or null

		@on 'start', @onStart
		@on 'stop', @onStop
		@on 'finish', @onFinish

		super()



	start: ->
		return if @running()

		if @building.level >= @building.config.maximumLevel
			throw new GameError "#{@building} cannot be upgraded any further."

		@config = @building.config.levels[@building.level.value + 1]

		if @building.village.warehouse.stocks.update().moreThan @config.resources
			@building.village.warehouse.stocks.subtract @config.resources or 0
		else
			throw new GameError "Not enough resources to upgrade #{this}."
		# todo: move to constructor

		@building.village.farm.workers.subtract @config.workers or 0

		@duration.reset @config.duration.clone().multiply @building.village.headquarter.timeFactor
		return super()



	onStart: ->
		@building.emit 'upgrade.start', this


	onStop: ->
		@building.village.warehouse.stocks.add @config.resources
		@building.farm.workers.add @config.workers
		@building.emit 'upgrade.stop', this


	onFinish: ->
		@building.level.add 1
		@building.points.add @config.points
		@building.emit 'upgrade.finish', this
		@building.emit 'upgrade', this



	toString: -> "(#{@building}) +1"





module.exports = Upgrade
