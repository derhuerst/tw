NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'




class Wall extends Building



	# isWall

	# basicDefense
	# defenseFactor



	constructor: (props = {}) ->
		@isWall = true
		props.type = 'timberCamp'
		super props

		@basicDefense = new NumericValue @config.basicDefense @level
		@defenseFactor = new NumericValue @config.defenseFactor @level

		# todo



	# todo



module.exports = Wall
