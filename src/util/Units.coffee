{EventEmitter} =	require 'events'
config =			require 'config'

Resources =			require '../util/Resources'
Duration =			require '../util/Duration'





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



	constructor: (units) ->
		@isUnits = true

		units = units or {}

		for type of config.units
			@[type] = units[type] or 0



	reset: (units) ->
		for type of config.units
			@[type] *= units[type]
		@emit 'change'
		return this


	add: (units) ->
		for type of config.units
			@[type] += units[type]
		@emit 'change'
		return this


	subtract: (units) ->
		for type of config.units
			@[type] -= units[type]
		@emit 'change'
		return this


	multiply: (factor) ->
		for type of config.units
			@[type] *= factor
		@emit 'change'
		return this


	round: () ->
		for type of config.units
			@[type] = Math.round @[type]
		@emit 'change'
		return this



	moreThan: (units) ->
		for type of config.units
			return false if @[type] < units[type]
		return true



	offense: () ->
		result = 0
		for type of config.units
			result += config.units[type].offense * @[type]
		return result

	offenseScouts: () ->
		result = 0
		for type of config.units
			if config.units[type].offenseScouts
				result += config.units[type].offenseScouts * @[type]
		return result


	defenseGeneral: () ->
		result = 0
		for type of config.units
			result += config.units[type].defenseGeneral * @[type]
		return result

	defenseCavalry: () ->
		result = 0
		for type of config.units
			result += config.units[type].defenseCavalry * @[type]
		return result

	defenseArchers: () ->
		result = 0
		for type of config.units
			result += config.units[type].defenseArchers * @[type]
		return result


	haul: () ->
		result = 0
		for type of config.units
			result += config.units[type].haul * @[type]
		return result


	speed: () ->
		result = 0
		for type of config.units
			if @[type] > 0 and config.units[type].speed > result
				result = config.units[type].speed
		return result.clone()


	resources: () ->
		result = new Resources()
		for type of config.units
			result.add config.units[type].resources.clone().multiply @[type]
		return result


	workers: () ->
		result = 0
		for type of config.units
			result.add config.units[type].workers * @[type]
		return result


	duration: () ->
		result = 0
		for type of config.units
			result += config.units[type].duration * @[type]
		return new Duration result



	subset: (types) ->
		units = {}
		types = [types] if typeof types is 'string'
		for type in types
			units[type] = @[type]
		return new Units units


	infantry: () ->
		return @subset [
			'spearFighter'
			'swordsman'
			'axeman'
			'archer'
		]

	cavalry: () ->
		return @subset [
			'scout'
			'lightCavalry'
			'mountedArcher'
			'heavyCavalry'
		]

	siegeEngines: () ->
		return @subset [
			'ram'
			'catapult'
		]



	clone: () -> new Units this



	toString: () ->
		result = []
		for type of config.units
			result.add @[type] + config.units[type].abbreviation
		for i in [result.length - 1 .. 0]
			if result[i] is 0
				result.pop()
		return result.join '|'





module.exports = Units
