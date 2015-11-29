{EventEmitter} =	require 'events'





class NumericValue extends EventEmitter



	# isNumericValue

	# value
	# abbreviation



	constructor: (value, abbreviation) ->
		@isNumericValue = true

		@value = value or 0
		@abbreviation = abbreviation or ''



	reset: (value) ->
		value = value + 0 or 0
		delta = value - @value
		@value = value
		oldValue = @value
		@emit 'change', oldValue, @value
		return this



	add: (summand) =>
		delta = if summand and summand.isNumericValue then summand.value else summand
		@value += delta
		oldValue = @value
		@emit 'change', oldValue, @value
		return this


	subtract: (subtrahend) ->
		delta = if subtrahend.isNumericValue then subtrahend.value else subtrahend
		@value -= delta
		@emit 'change', delta
		return this


	multiply: (factor) ->
		delta = @value
		@value *= if factor and factor.isNumericValue then factor.value else factor
		oldValue = @value
		@emit 'change', oldValue, @value
		return this


	round: () ->
		delta = @value
		oldValue = @value
		@value = Math.round this
		@emit 'change', oldValue, @value
		return this



	watch: (points) =>
		points.on 'change', @add
		return this

	unwatch: (points) =>
		points.off 'change', @add
		return this



	clone: () -> new NumericValue @value



	valueOf: () -> @value

	toString: () -> "#{@value}#{@abbreviation}"





module.exports = NumericValue
