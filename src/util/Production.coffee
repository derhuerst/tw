{EventEmitter} =	require 'events'

Resources =			require '../util/Resources'
Duration =			require '../util/Duration'
GameError =			require '../util/GameError'





class Production extends EventEmitter



	# isProduction

	# resources
	# duration



	constructor: (resources, duration) ->
		@isProduction = true

		throw new Error 'Missing `resources` argument.' unless resources.isResources
		@resources = resources.clone()
		@resources.on 'change', @_propertyOnChange

		if duration and duration.isDuration
			@duration = duration
		else @duration = new Duration '1h'
		@duration.on 'change', @_propertyOnChange



	_propertyOnChange: => @emit 'change'



	add: (production) ->
		return this unless production and production.isProduction
		@resources.add production.resourcesDuring @duration
		return this

	subtract: (production) ->
		return this unless production and production.isProduction
		@resources.subtract production.resourcesDuring @duration
		return this



	resourcesDuring: (duration = 0) -> @resources.clone().multiply duration / @duration


	durationToGet: (resources) ->
		factors = new Resources()
		for type in ['wood', 'clay', 'iron']
			continue if resources[type] is 0
			return Infinity if @resources[type] is 0
			factors[type] = resources[type] / @resources[type]
		return new Duration @duration * factors[factors.highest()]



	clone: -> new Production @resources.clone(), @duration.clone()

	toString: -> "#{@resources}/#{@duration.toString()}"





module.exports = Production
