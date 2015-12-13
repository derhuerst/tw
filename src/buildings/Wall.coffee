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

		@basicDefense = new NumericValue @config.basicDefense @level
		@defenseFactor = new NumericValue @config.defenseFactor @level

		# todo



	# todo



module.exports = Wall
