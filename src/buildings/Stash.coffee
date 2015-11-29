NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'





class Stash extends Building



	# isStash

	# capacity



	constructor: (options) ->
		@isStash = true
		options = options or {}
		options.type = 'stash'
		super options

		@capacity = new NumericValue options.capacity or @config.levels[@level].capacity or 0



	# todo?





module.exports = Stash
