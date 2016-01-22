EventEmitter = require('events').EventEmitter
container = require '../container'

module.exports = container.publish 'util.NumericValue', ->





	class NumericValue extends EventEmitter



		# isNumericValue

		# value
		# abbreviation



		constructor: (value, abbreviation) ->
			@isNumericValue = true
			EventEmitter.call this

			if value and value.isNumericValue then @value = value.valueOf()
			else @value = value or 0
			@abbreviation = abbreviation or ''

			return this



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


		round: ->
			oldValue = @value
			@value = Math.round this
			return this if @value is oldValue
			@emit 'change', oldValue, @value
			return this



		# todo: `watch`ing is confusing and unuseful when using `multiply`
		# on the watched `NumericValue`.

		_watchedOnChange: (before, after) =>
			@add after - before

		watch: (numericValue) ->
			numericValue.on 'change', @_watchedOnChange
			return this

		unwatch: (numericValue) ->
			numericValue.removeListener 'change', @_watchedOnChange
			return this



		clone: -> new NumericValue @value, @abbreviation



		valueOf: -> @value

		toString: -> "#{@value}#{@abbreviation}"
