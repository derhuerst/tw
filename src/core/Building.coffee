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



	constructor: (props = {}) ->
		@isBuilding = true
		super()

		@id = props.id or shortid.generate()
		@type = props.type or null
		@config = config[@type] or null
		# todo: throw error if no config

		@level = new NumericValue props.level or @config.initialLevel or 1
		@emit 'upgrade'

		@village = props.village or null



	points: -> @config.points @level



	toString: -> "#{@config.abbreviation}#{@level} ##{@id}"





module.exports = Building
