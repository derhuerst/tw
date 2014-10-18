# todo: remove the pre-change event. the delta production can be passed to the change event.
{EventEmitter} =	require 'events'

Resources =			require '../util/Resources'
Duration =			require '../util/Duration'
GameError =			require '../util/GameError'





class Production extends EventEmitter



	# resources
	# duration

	isProduction: true



	constructor: (resources, duration) ->
		@resources = resources or new Resources()
		@duration = duration or new Duration '1h'

		@resources.on 'change', @propertyOnChange
		@duration.on 'change', @propertyOnChange
		@resources.on 'pre-change', @propertyOnPreChange
		@duration.on 'pre-change', @propertyOnPreChange



	propertyOnChange: () =>
		@emit 'change'


	propertyOnPreChange: () =>
		@emit 'pre-change'



	add: (production) ->
		@resources.add production.resourcesDuring @duration


	subtract: (production) ->
		@resources.subtract production.resourcesDuring @duration



	resourcesDuring: (duration) ->
		return @resources.clone().multiply duration / @duration


	durationToGet: (resources) ->
		factors = new Resources()
		for type in ['wood', 'clay', 'iron']
			continue if resources[type] is 0
			return false if @resources[type] is 0
			factors[type] = resources[type] / @resources[type]
		return new Duration @duration * factors[factors.highest()]



	clone: () ->
		return new Production @resources, @duration



	toString: () ->
		return "#{@resources}/#{@duration.toString()}" # todo: remove toString; doesn't work by now





module.exports = Production
