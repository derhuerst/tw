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



	_set: (wood, clay, iron) ->
		before = @clone()

		@wood = wood
		@clay = clay
		@iron = iron

		@emit 'change', before, @clone()
		return this


	reset: (value = 0) ->
		if value.isResources then return @_set value.wood, value.clay, value.iron
		else return @_set value, value, value


	add: (summand = 0) ->
		return this if summand is 0
		if summand.isResources
			return @_set @wood + summand.wood, @clay + summand.clay, @iron + summand.iron
		else return @_set @wood + summand, @clay + summand, @iron + summand

	subtract: (subtrahend = 0) ->
		if subtrahend.isResources then return @add subtrahend.clone().multiply -1
		else return @add -subtrahend


	multiply: (factor = 1) ->
		return this if factor is 1
		if factor.isResources
			return @_set @wood * factor.wood, @clay * factor.clay, @iron * factor.iron
		else return @_set @wood * factor, @clay * factor, @iron * factor


	round: ->
		before = @clone()

		@wood = Math.round @wood
		@clay = Math.round @clay
		@iron = Math.round @iron

		@emit 'change', before, @clone()
		return this



	highest: ->
		result = 'wood'
		result = 'clay' if @clay > @wood
		result = 'iron' if @iron > @clay
		return result

	lowest: ->
		result = 'wood'
		result = 'clay' if @clay < @wood
		result = 'iron' if @iron < @clay
		return result


	count: -> @wood + @clay + @iron


	equalTo: (resources) ->
		return false unless resources and resources.isResources
		for unit in [ 'wood', 'clay', 'iron' ]
			return false unless @[unit] is resources[unit]
		return true

	moreThan: (resources) ->
		return this unless resources and resources.isResources
		return ( @wood >= resources.wood and
		@clay >= resources.clay and
		@iron >= resources.iron )



	clone: -> new Resources this



	toString: -> "#{@wood}w|#{@clay}c|#{@iron}i"





module.exports = Resources
