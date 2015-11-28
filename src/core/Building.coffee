{EventEmitter} =	require 'events'

helpers =			require '../util/helpers'
config =			require '../util/config'

GameError =			require '../util/GameError'
NumericValue =		require '../util/NumericValue'





class Building extends EventEmitter



	# id
	# type				set by sub classes
	# config

	# level
	# points

	# village

	isBuilding: true



	constructor: (options) ->
		options = options or {}

		@id = options.id or helpers.uid 12
		@type = options.type or null
		@config = config.buildings[@type] or null

		@level = new NumericValue options.level or @config.initialLevel or 0
		@points = new NumericValue options.points or 0
		for level in [0 ... @level]
			@points.add @config.levels[level].points

		@village = options.village or null



	toString: () ->
		return "#{@config.abbreviation}#{@level} ##{@id}"





module.exports = Building