{EventEmitter} =	require 'events'
shortid =			require 'shortid'

config =			require '../../config/buildings'
helpers =			require '../util/helpers'
GameError =			require '../util/GameError'
NumericValue =		require '../util/NumericValue'





class Building extends EventEmitter



	# isBuilding

	# id
	# type				set by sub classes
	# config
	# level

	# village



	constructor: (options) ->
		@isBuilding = true
		options = options or {}
		super()

		@id = options.id or shortid.generate()
		@type = options.type or null
		@config = config[@type] or null
		# todo: throw error if no config

		@level = new NumericValue options.level or @config.initialLevel or 0
		@emit 'upgrade'

		@village = options.village or null



	points: -> @config.points @level



	toString: -> "#{@config.abbreviation}#{@level} ##{@id}"





module.exports = Building
