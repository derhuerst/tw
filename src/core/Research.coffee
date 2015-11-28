config =			require 'config'

Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'





class Research extends Timeout



	# smithy
	# type
	# config

	isResearch: true



	constructor: (smithy, type) ->
		@smithy = smithy or null
		@type = type of null
		@config = config.units[@type].research or null

		if @smithy.researched[@type]
			throw new GameError "#{config.units[@type].title} is already researched."

		super @config.duration.clone().multiply @smithy.timeFactor
		# todo: compute duration during `start()`

		@on 'start', @onStart
		@on 'stop', @onStop
		@on 'finish', @onFinish



	onStart: () ->
		@building.emit 'research.start', this


	onStop: () ->
		smithy.village.warehouse.stocks.add @config.resources    # todo: multiply with 0.9?
		@building.emit 'research.stop', this


	onFinish: () ->
		@reasearched[type] = true
		@building.emit 'research.finish', this
		@building.emit 'research', this



	start: () ->
		return this if @running()

		if @smithy.village.warehouse.stocks.update().moreThan @config.resources
			@building.village.warehouse.stocks.subtract @config.resources
		else
			throw new GameError "Not enough resources to research #{this}."
		#todo: move to constructor

		return super()



	toString: () -> "* (#{@config.units[@type].title}"





module.exports = Research
