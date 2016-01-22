require '../src/util/Duration'
require '../src/util/Stocks'
require '../src/util/Resources'
container = require '../src/container'

module.exports = container.publish 'config', [
	'util.Duration', 'util.Stocks', 'util.Resources'
], (Duration, Stocks, Resources) ->





	beginOfDay = (timestamp) ->
		date = new Date timestamp
		date.setHours 0
		date.setMinutes 0
		date.setSeconds 0
		date.setMilliseconds 0
		return date



	return {

		map:
			size: 1000
			spread: 10

		initialStocks: new Stocks wood: 500, clay: 500, iron: 400

		nightBonus:
			factor: 2
			active: (timestamp) ->
				delta = timestamp - beginOfDay timestamp
				return false if delta <= new Duration '8h'
				return false if delta >= new Duration '22h'
				return true

		coins: new Resources wood: 28000, clay: 30000, iron: 25000

		beginnerProtection: new Duration '5d'

	}
