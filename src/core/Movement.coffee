Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'
Units =				require '../util/Units'





class Movement extends Timeout



	# isMovement

	# units
	# origin
	# target
	# returning



	constructor: (origin, target, units) ->
		@isMovement = true

		@units = new Units units
		@origin = origin or null
		@target = target or null
		@returning = false

		@on 'start', @onStart
		@on 'stop', @onStop
		@on 'finish', @onFinish

		super()



	start: () ->
		return if @running()

		if target is origin
			throw new GameError "The target is the origin."

		if origin.rallyPoint.units.available.moreThan @units
			throw new GameError "Not enough units."
		origin.rallyPoint.units.available.subtract @units
		origin.rallyPoint.units.away.add @units # todo: improve this?

		@duration.reset @units.speed().durationToTravel @origin.position.distanceTo @target.position
		return super()



	onStart: () ->
		# todo: improve event names?
		origin.emit 'outgoing-movement', this
		origin.emit 'outgoing-movement.start', this
		target.emit 'incoming-movement', this
		target.emit 'incoming-movement.start', this


	onStop: () ->
		@returning = true
		# todo: improve event names?
		origin.emit 'outgoing-movement.stop', this
		target.emit 'incoming-movement.stop', this


	onFinish: () ->
		# todo: improve event names?
		origin.emit 'outgoing-movement.finish', this
		target.emit 'incoming-movement.finish', this



	toString: () -> "(#{@building}) +1"





module.exports = Movement
