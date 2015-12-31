config =			require '../../config/units'
Resources =			require '../util/Resources'
GameError =			require '../util/GameError'
Movement =			require '../core/Movement'
fight =				require '../core/fight'





noblemanDistance = ->
	distance = @origin.position.distanceTo @destination.position
	if @units.nobleman > 0 and distance > 50
		throw new GameError "A #{config.nobleman.title} cannot travel further than 50 fields."

enoughWorkers = ->
	if @units.workers() < @origin.points / 100
		throw new GameError "The number of workers of your army \
		has to be a hundredth of your village's workers."

notAnAlly = ->
	# todo



class Attack extends Movement



	# isAttack

	# haul



	constructor: (props = {}) ->
		@isAttack = true
		super props

		@haul = new Resources()
		if @units.catapult > 0
			unless props.catapultsTarget
				throw new GameError 'Catapults target not specified.'
			@catapultsTarget = props.catapultsTarget
		else @catapultsTarget = null

		@_startRequirements.push noblemanDistance, enoughWorkers, notAnAlly

		@_timeout.on 'start', @_onStart
		@_timeout.on 'stop', @_onAbort
		@_timeout.on 'finish', @_onFinish

		return this



	_onStart: => # started at `origin`
		return @_onReturn() if @returning()

		@origin.emit 'outgoing-movement', this
		@origin.emit 'outgoing-movement.start', this
		@destination.emit 'incoming-movement', this
		@destination.emit 'incoming-movement.start', this

	_onAbort: => # aborted
		@origin.emit 'outgoing-movement.abort', this
		@destination.emit 'incoming-movement.abort', this

	_onFight: => # arrived at `destination`
		@origin.emit 'outgoing-movement.finish', this
		@destination.emit 'incoming-movement.finish', this


		fight.fight this # todo: move fight.fight here?
		# todo: https://help.die-staemme.de/wiki/Farmlimit

		@emit 'fight'

		@_returning = true
		@_timeout.start()

	_onReturn: => # started at `destination`
		@origin.emit 'incoming-movement', this
		@origin.emit 'incoming-movement.start', this
		unless @aborted()
			@destination.emit 'outgoing-movement', this
			@destination.emit 'outgoing-movement.start', this

		@emit 'return'

	_onFinish: => # back at `origin`, either aborted or returning
		return @_onFight() unless @returning()

		@origin.emit 'incoming-movement.finish', this
		@destination.emit 'outgoing-movement.finish', this

		@origin.warehouse.stocks.resources().add @haul
		@origin.rallyPoint.units.available.add @units
		@origin.rallyPoint.units.away.subtract @units

		@emit 'finish'





module.exports = Attack
