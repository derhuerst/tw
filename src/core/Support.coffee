GameError =			require '../util/GameError'
Movement =			require '../core/Movement'
Units =				require '../util/Units'





class Support extends Movement



	# isSupport



	constructor: (props = {}) ->
		@isSupport = true
		super props

		@_timeout.on 'start', @_onStart
		@_timeout.on 'stop', @_onAbort
		@_timeout.on 'finish', @_onFinish

		if @returning() then [@_to, @_from] = [@origin, @destination]
		else [@_from, @_to] = [@origin, @destination]

		return this



	_onStart: => # started at `origin`
		@_from.emit 'outgoing-movement', this
		@_from.emit 'outgoing-movement.start', this
		@_to.emit 'incoming-movement', this
		@_to.emit 'incoming-movement.start', this

	_onAbort: => # aborted
		@origin.emit 'outgoing-movement.abort', this
		@destination.emit 'incoming-movement.abort', this

		[@_from, @_to] = [@_to, @_from]

	_onFinish: => # back at `origin`, either aborted or returning
		@_from.emit 'outgoing-movement.finish', this
		unless @aborted() then @_to.emit 'incoming-movement.finish', this

		if @returning()
			@origin.rallyPoint.units.away.subtract @units
			@origin.rallyPoint.units.available.add @units
		else
			@destination.rallyPoint.units.supporting[@origin.id] ?= new Units()
			@destination.rallyPoint.units.supporting[@origin.id].add @units

		@emit if @returning() then 'finish' else 'support'





module.exports = Support
