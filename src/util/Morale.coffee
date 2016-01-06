{EventEmitter} =	require 'events'

Interval =			require '../util/Interval'
Duration =			require '../util/Duration'





class Morale extends EventEmitter



	# isMorale

	# _value
	# _interval



	constructor: (value = 100) ->
		@isMorale = true
		super()

		@_value = value
		@_interval = new Interval (new Duration '1h'), @_onTick
		if @_interval then @_interval.start()

		return this



	reset: (value) ->
		return this unless value?

		if value > 100 then value = 100
		return this if value is @_value
		before = @_value

		@_value = 0 + value
		@_interval.start() unless @_value is 100

		@emit 'change', before, @_value
		return this



	subtract: (subtrahend) ->
		return this unless subtrahend?
		return this if subtrahend is 0

		before = @_value
		@_value -= subtrahend
		@_interval.start()

		@emit 'change', before, @_value
		return this



	_onTick: =>
		@_value++
		@emit 'change', @_value - 1, @_value
		if @_value is 100 then @_interval.stop()



	valueOf: -> @_value



	toString: -> "#{@_value}m"





module.exports = Morale
