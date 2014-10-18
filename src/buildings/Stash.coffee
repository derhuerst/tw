NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'





class Stash extends Building



	# capacity

	isStash: true



	constructor: (options) ->
		options = options or {}
		options.type = 'stash'
		super options

		@capacity = new NumericValue options.capacity or @config.levels[@level].capacity or 0



	# todo?





module.exports = Stash
