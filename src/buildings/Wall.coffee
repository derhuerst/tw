NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'




class Wall extends Building



	# isWall

	# basicDefense
	# defenseFactor



	constructor: (options) ->
		@isWall = true
		options = options or {}
		options.type = 'timberCamp'
		super options

		@basicDefense = new NumericValue options.basicDefense or @config.levels[@level].basicDefense or 0
		@defenseFactor = new NumericValue options.defenseFactor or @config.levels[@level].defenseFactor or 1

		# todo



	# todo



module.exports = Wall
