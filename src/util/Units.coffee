EventEmitter = require('events').EventEmitter
require '../../config/units'
require './Resources'
require './Duration'
container = require '../container'

module.exports = container.publish 'util.Units', [
	'config.units', 'util.Resources', 'util.Duration'
], (config, Resources, Duration) ->





	class Units extends EventEmitter



		# isUnits

		# spearFighter
		# swordsman
		# axeman
		# scout
		# lightCavalry
		# heavyCavalry
		# ram
		# catapult
		# paladin
		# nobleman



		constructor: (units = {}) ->
			@isUnits = true

			for type of config
				@[type] = units[type] or 0

			return this



		_set: (units) ->
			before = @clone()
			return this unless typeof units is 'function'
			for type of config
				@[type] = units type, @[type]
			@emit 'change', before, this
			return this



		reset: (units = 0) ->
			if units.isUnits then return @_set (type) -> units[type]
			else if typeof units is 'number' then return @_set -> units
			else return this


		add: (units) ->
			return this unless units?
			if units.isUnits
				return @_set (type, amount) -> amount + units[type]
			else if typeof units is 'number'
				return @_set (_, amount) -> amount + units
			else return this


		subtract: (units) ->
			return this unless units?
			if units.isUnits
				return @_set (type, amount) -> amount - units[type]
			else if typeof units is 'number'
				return @_set (_, amount) -> amount - units
			else return this


		multiply: (factor) ->
			return this unless typeof factor is 'number'
			return @_set (_, amount) -> amount * factor


		round: -> @_set (_, amount) -> Math.round amount



		count: ->
			result = 0
			result += @[type] for type, traits of config
			return result

		moreThan: (units) ->
			for type of config
				return false if @[type] < units[type]
			return true



		_trait: (trait) ->
			result = 0
			for type, traits of config
				result += traits[trait] * @[type]
			return result

		offense: -> @_trait 'offense'
		offenseScouts: -> @_trait 'offenseScouts'
		defenseGeneral: -> @_trait 'defenseGeneral'
		defenseCavalry: -> @_trait 'defenseCavalry'
		defenseArchers: -> @_trait 'defenseArchers'
		haul: -> @_trait 'haul'



		resources: ->
			result = new Resources()
			for type, traits of config
				result.add traits.costs.resources.clone().multiply @[type]
			return result

		duration: -> # todo: rename to `time`?
			result = 0
			for type, traits of config
				result += traits.costs.time * @[type]
			return new Duration result

		workers: ->
			result = 0
			for type, traits of config
				result += traits.costs.workers * @[type]
			return result



		speed: ->
			result = new Duration 0
			for type, traits of config
				if @[type] > 0 and traits.speed > result
					result = traits.speed
			return result.clone()



		subset: (types) ->
			types = [types] if typeof types is 'string'
			units = {}
			for type in types
				units[type] = @[type]
			return new Units units

		infantry: -> @subset ['spearFighter', 'swordsman', 'axeman', 'archer']
		cavalry: -> @subset ['scout', 'lightCavalry', 'mountedArcher', 'heavyCavalry']
		siege: -> @subset ['ram', 'catapult']
		special: -> @subset ['paladin', 'nobleman']



		clone: -> new Units this

		toString: ->
			result = for type, traits of config
				@[type] + traits.abbreviation unless @[type] is 0
			return result.join '|'
