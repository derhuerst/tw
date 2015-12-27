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
		super()

		if not origin or origin.isVillage isnt true
			throw new ReferenceError "Missing `origin` argument."
		@origin = origin or null
		if not origin or origin.isVillage isnt true
			throw new ReferenceError "Missing `target` argument."
		@target = target or null
		if not units or units.isUnits isnt true
			throw new ReferenceError "Missing `units` argument."
		@units = units
		@returning = false

		@on 'start', @_onStart
		@on 'finish', @_onFinish



	start: ->
		return if @running()

		if @target is @origin
			throw new GameError "The target is the origin."

		unless @origin.rallyPoint.units.available.moreThan @units
			throw new GameError "Not enough units."
		@origin.rallyPoint.units.available.subtract @units
		@origin.rallyPoint.units.away.add @units # todo: improve this?

		@duration().reset @units.speed().multiply(@origin.position.distanceTo @target.position).valueOf()

		return super()




	_onStart: =>
		# todo: improve event names?
		if @returning then [to, from] = [@origin, @target]
		else [from, to] = [@origin, @target]
		from.emit 'outgoing-movement', this
		from.emit 'outgoing-movement.start', this
		to.emit 'incoming-movement', this
		to.emit 'incoming-movement.start', this


	_onFinish: =>
		# todo: improve event names?
		if @returning then [to, from] = [@origin, @target]
		else [from, to] = [@origin, @target]
		to.emit 'incoming-movement.finish', this
		from.emit 'outgoing-movement.finish', this

		if not @returning
			@returning = true
			Timeout.prototype.start.call this # todo: this is ugly.



	toString: -> [
		"(#{@units})"
		@origin.toString()
		if @returning then '<-' else '->'
		@target.toString()
	].join ' '





module.exports = Movement
