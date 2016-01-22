EventEmitter = require('events').EventEmitter
require './Resources'
require './Duration'
require './GameError'
container = require '../container'

module.exports = container.publish 'util.Production', [
	'util.Resources', 'util.Duration', 'util.GameError'
], (Resources, Duration, GameError) ->





	class Production extends EventEmitter



		# isProduction

		# resources
		# duration



		constructor: (resources, duration) ->
			@isProduction = true

			unless resources and resources.isResources
				throw new ReferenceError 'Missing `resources` argument.'
			@resources = resources.clone()
			@resources.on 'change', @_resourcesOnChange

			if duration and duration.isDuration then @duration = duration.clone()
			else if typeof duration is 'number' then @duration = new Duration duration
			else @duration = new Duration '1h'
			@duration.on 'change', @_durationOnChange

			return this



		_resourcesOnChange: (before) =>
			productionBefore = new Production before, @duration
			@emit 'change', productionBefore, this

		_durationOnChange: (before) =>
			productionBefore = new Production @resources, before
			@emit 'change', productionBefore, this



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
