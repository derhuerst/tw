{EventEmitter} =	require 'events'

Timeout =			require '../util/Timeout'
GameError =			require '../util/GameError'





enoughUnits = ->
	if @units.moreThan @origin.rallyPoint.units.available
		throw new GameError "There are not enough units available."

notReturning = ->
	if @returning() then throw new GameError "The units are already on their way home."

timeToRevoke = ->
	passed = @_timeout.duration() - @_timeout.remaining()
	limit = @origin.rallyPoint.config.movementsTimeToRevoke
	if passed > limit
		throw new GameError "You can only call units back for #{limit}."



class Movement extends EventEmitter



	# isMovement

	# origin
	# destination
	# units

	# _aborted

	# _timeout



	constructor: (props = {}) ->
		@isMovement = true
		super()

		if props.origin?.isVillage is true then @origin = props.origin
		else throw new ReferenceError "Missing `origin` argument."

		if props.destination?.isVillage is true then @destination = props.destination
		else throw new ReferenceError "Missing `destination` argument."

		if @destination is @origin
			throw new GameError "The destination is the origin."

		if props.units?.isUnits is true then @units = props.units
		else throw new ReferenceError "Missing `units` argument."

		@_returning = props.returning is true
		@_aborted = false

		@_timeout = new Timeout()

		@_startRequirements = [enoughUnits]
		@_abortRequirements = [notReturning, timeToRevoke]

		return this



	running: -> @_timeout.running()
	returning: -> @_returning
	aborted: -> @_aborted



	_startRequirements: null

	start: ->
		return if @running()
		requirement.call this for requirement in @_startRequirements

		@origin.rallyPoint.units.available.subtract @units
		@origin.rallyPoint.units.away.add @units # todo: improve this?
		@_aborted = false

		distance = 0 + @origin.position.distanceTo @destination.position
		@_timeout.duration().reset @units.speed().multiply distance
		@_timeout.start()

		@emit 'start'
		return this



	_abortRequirements: null

	abort: ->
		return unless @running()
		return if @aborted()
		requirement.call this for requirement in @_abortRequirements

		@_aborted = true
		@_returning = true

		@_timeout.stop()
		@_timeout.duration().reset @_timeout.duration() - @_timeout.remaining()
		@_timeout.start()

		@emit 'abort'
		return this



	toString: -> [
		@units
		@origin
		if @returning() then '<-' else '->'
		@destination
	].join ' '





module.exports = Movement
