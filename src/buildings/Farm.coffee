NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'





class Farm extends Building



	# isFarm

	# workers



	constructor: (props = {}) ->
		@isFarm = true
		props.type = 'farm'
		super props

		@workers = new NumericValue()
		@_updateWorkers()

		@on 'upgrade.finish', @_updateWorkers
		@on 'downgrade.finish', @_updateWorkers



	_updateWorkers: => @workers.reset @config.workers @level





module.exports = Farm
