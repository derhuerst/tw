Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'





class Downgrade extends Timeout



	# building

	# config

	isDowngrade: true



	constructor: (building) ->
		@building = building or null

		@on 'start', @onStart
		@on 'stop', @onStop
		@on 'finish', @onFinish

		super()



	start: () ->
		return if @running()

		if @building.level <= @building.config.minimumLevel
			throw new GameError "#{@building} cannot be downgraded any further."
		# todo: move to constructor

		@config = @building.config.levels[@building.level - 1]

		@duration.reset @config.duration.clone().multiply @building.village.headquarter.timeFactor
		return super()



	onStart: () ->
		@building.emit 'downgrade.start', this


	onStop: () ->
		@building.emit 'downgrade.stop', this


	onFinish: () ->
		@building.level.subtract 1
		@building.village.points.subtract @config.points
		@building.village.farm.workers.add @config.workers
		@building.emit 'downgrade.finish', this
		@building.emit 'downgrade', this



	toString: () ->
		return "(#{@building}) -1"





module.exports = Downgrade
