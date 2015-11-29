{EventEmitter} =	require 'events'





class Resources extends EventEmitter



	# isResources

	# wood
	# clay
	# iron



	constructor: (values) ->
		@isResources = true

		values = values or {}

		@wood = values.wood or 0
		@clay = values.clay or 0
		@iron = values.iron or 0



	reset: (value) ->
		@emit 'pre-change'
		@wood = @clay = @iron = value + 0 or 0
		@emit 'change'
		return this


	add: (summand) ->
		@emit 'pre-change'
		if summand.isResources
			@wood += summand.wood
			@clay += summand.clay
			@iron += summand.iron
		else
			@wood += summand
			@clay += summand
			@iron += summand
		@emit 'change'
		return this


	subtract: (subtrahend) ->
		if subtrahend.isResources
			subtrahend.multiply -1
		else
			subtrahend *= -1
		@add subtrahend
		return this


	multiply: (factor) ->
		@emit 'pre-change'
		if factor.isResources
			@wood *= factor.wood
			@clay *= factor.clay
			@iron *= factor.iron
		else
			@wood *= factor
			@clay *= factor
			@iron *= factor
		@emit 'change'
		return this


	round: () ->
		@emit 'pre-change'
		@wood = Math.round @wood
		@clay = Math.round @clay
		@iron = Math.round @iron
		@emit 'change'
		return this



	highest: () ->
		result = 'wood'
		result = 'clay' if @clay > @wood
		result = 'iron' if @iron > @clay
		return result

	lowest: () ->
		result = 'wood'
		result = 'clay' if @clay < @wood
		result = 'iron' if @iron < @clay
		return result


	count: () -> @wood + @clay + @iron


	moreThan: (resources) ->
		return @wood >= resources.wood and @clay >= resources.clay and @iron >= resources.iron



	clone: () -> new Resources this


	subset: (types) ->
		resources = {}
		types = [types] if typeof types is 'string'
		for type in types
			resources[type] = @[type]
		return new Resources resources



	toString: () -> "#{@wood}w|#{@clay}c|#{@iron}i"





module.exports = Resources
