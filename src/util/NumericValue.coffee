{EventEmitter} =	require 'events'





class NumericValue extends EventEmitter



	# value
	# abbreviation

	isNumericValue: true



	constructor: (value, abbreviation) ->
		@value = value or 0
		@abbreviation = abbreviation or ''



	reset: (value) ->
		value = value + 0 or 0
		delta = value - @value
		@value = value
		@emit 'change', delta
		return this



	add: (summand) =>
		delta = if summand and summand.isNumericValue then summand.value else summand
		@value += delta
		@emit 'change', delta
		return this


	subtract: (subtrahend) ->
		delta = if subtrahend.isNumericValue then subtrahend.value else subtrahend
		@value -= delta
		@emit 'change', delta
		return this


	multiply: (factor) ->
		delta = @value
		@value *= if factor and factor.isNumericValue then factor.value else factor
		@emit 'change', @value - delta
		return this


	round: () ->
		delta = @value
		@value = Math.round this
		@emit 'change', @value - delta
		return this



	watch: (points) =>
		points.on 'change', @add
		return this

	unwatch: (points) =>
		points.off 'change', @add
		return this



	clone: () ->
		return new NumericValue @value



	valueOf: () ->
		return @value


	toString: () ->
		return "#{@value}#{@abbreviation}"





module.exports = NumericValue
