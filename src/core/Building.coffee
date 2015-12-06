{EventEmitter} =	require 'events'
shortid =			require 'shortid'

config =			require '../../config'
helpers =			require '../util/helpers'
GameError =			require '../util/GameError'
NumericValue =		require '../util/NumericValue'





class Building extends EventEmitter



	# isBuilding

	# id
	# type				set by sub classes
	# config

	# level
	# points

	# village



	constructor: ->
		@isBuilding = true
		super arguments...



	constructor: (options) ->
		options = options or {}

		@id = options.id or shortid.generate()
		@type = options.type or null
		@config = config.buildings[@type] or null

		@level = new NumericValue options.level or @config.initialLevel or 0
		@points = new NumericValue options.points or 0
		for level in [0 ... @level]
			@points.add @config.levels[level].points

		@village = options.village or null



	toString: -> "#{@config.abbreviation}#{@level} ##{@id}"





module.exports = Building
