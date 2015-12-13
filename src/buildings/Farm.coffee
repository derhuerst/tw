NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'





class Farm extends Building



	# isFarm

	# workers



	constructor: (options) ->
		@isFarm = true
		options = options or {}
		options.type = 'farm'
		super options

		@workers = new NumericValue()
		@_updateWorkers()

		@on 'upgrade.finish', @_updateWorkers
		@on 'downgrade.finish', @_updateWorkers



	_updateWorkers: => @workers.reset @config.workers @level





module.exports = Farm
