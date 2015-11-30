Timeout =			require '../util/Timeout'
Units =				require '../util/Units'





class Recruitment extends Timeout



	# isRecruitment

	# building
	# units



	constructor: (building, units) ->
		@isRecruitment = true

		@building = building or null
		@units = units or new Units()

		super @units.duration().clone().multiply @building.village.headquarter.timeFactor
		# todo: compute duration during `start()`

		@on 'start', @onStart
		@on 'stop', @onStop
		@on 'finish', @onFinish



	onStart: ->
		@building.emit 'recruitment.start', this


	onStop: ->
		building.village.warehouse.stocks.add @units.resources().multiply 0.9
		@building.emit 'recruitment.stop', this


	onFinish: ->
		@building.village.rallyPoint.units.add @units
		@building.emit 'recruitment.finish', this
		@building.emit 'recruitment', this



	start: ->
		if @running()
			throw new GameError "#{this} is already running."

		if @building.village.warehouse.stocks.update().moreThan @units.resources()
			@building.village.warehouse.stocks.subtract @units.resources()
		else
			throw new GameError "Not enough resources to train (#{@units})."
		# todo: move to constructor

		return super()



	toString: -> "+ (#{@units})"





module.exports = Recruitment
