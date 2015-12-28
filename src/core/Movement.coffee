Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'
Units =				require '../util/Units'





class Movement extends Timeout



	# isMovement

	# origin
	# target
	# units

	# returning
	# stopped



	constructor: (props = {}) ->
		@isMovement = true
		super()

		if props.origin and props.origin.isVillage is true then @origin = props.origin
		else throw new ReferenceError "Missing `origin` argument."
		if props.target and props.target.isVillage is true then @target = props.target
		else throw new ReferenceError "Missing `target` argument."

		if props.units and props.units.isUnits is true then @units = props.units
		else throw new ReferenceError "Missing `units` argument."

		@returning = false
		@stopped = false

		@on 'start', @_onStart
		@on 'stop', @_onStop
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

	stop: ->
		passed = @duration() - @remaining()

		if @returning
			throw new GameError "The units are already on their way home."
		if passed > @origin.rallyPoint.config.movementsTimeToRevoke
			throw new GameError "You can only call units back for #{@origin.rallyPoint.config.movementsTimeToRevoke}."

		super()
		@returning = true
		@stopped = true
		@duration().reset passed
		Timeout.prototype.start.call this # todo: this is ugly.



	_onStart: =>
		# todo: improve event names?
		#console.log '_onStart', '@returning', @returning, '@stopped', @stopped
		if @returning then [to, from] = [@origin, @target]
		else [from, to] = [@origin, @target]
		if not @stopped
			from.emit 'outgoing-movement', this
			from.emit 'outgoing-movement.start', this
		to.emit 'incoming-movement', this
		to.emit 'incoming-movement.start', this

	_onStop: =>
		# todo: improve event names?
		#console.log '_onStop', '@returning', @returning, '@stopped', @stopped
		@origin.emit 'outgoing-movement.stop', this
		@target.emit 'incoming-movement.stop', this

	_onFinish: =>
		# todo: improve event names?
		#console.log '_onFinish', '@returning', @returning, '@stopped', @stopped
		if @returning then [to, from] = [@origin, @target]
		else [from, to] = [@origin, @target]
		if not @stopped then from.emit 'outgoing-movement.finish', this
		to.emit 'incoming-movement.finish', this

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
