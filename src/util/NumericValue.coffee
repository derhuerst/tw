{EventEmitter} =	require 'events'





class NumericValue extends EventEmitter



	# isNumericValue

	# value
	# abbreviation



	constructor: (value, abbreviation) ->
		@isNumericValue = true

		@value = value or 0
		@abbreviation = abbreviation or ''



	reset: (newValue = 0) ->
		oldValue = @value
		if newValue.isNumericValue then newValue = newValue.value
		@value = newValue
		@emit 'change', oldValue, @value
		return this



	add: (summand = 0) =>
		oldValue = @value
		if summand.isNumericValue then summand = summand.value
		return this if summand is 0
		@value += summand
		@emit 'change', oldValue, @value
		return this

	subtract: (subtrahend = 0) -> @add -subtrahend


	multiply: (factor = 1) ->
		oldValue = @value
		if factor.isNumericValue then factor = factor.value
		return this if factor is 1
		@value *= factor
		@emit 'change', oldValue, @value
		return this


	round: () ->
		oldValue = @value
		@value = Math.round this
		return this if @value is oldValue
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
