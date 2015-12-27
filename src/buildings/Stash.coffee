NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'





class Stash extends Building



	# isStash

	# capacity



	constructor: (props = {}) ->
		@isStash = true
		props.type = 'stash'
		super props

		@capacity = new NumericValue()
		@_updateCapacity()

		@on 'upgrade.finish', @_updateCapacity
		@on 'downgrade.finish', @_updateCapacity



	_updateCapacity: => @capacity.reset new Resources
		wood: @config.capacity.wood @level
		clay: @config.capacity.clay @level
		iron: @config.capacity.iron @level



	# todo?





module.exports = Stash
