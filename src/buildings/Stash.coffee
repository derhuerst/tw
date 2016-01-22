NumericValue =		require '../util/NumericValue'
Resources =			require '../util/Resources'

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



	_updateCapacity: =>
		capacity = @config.capacity @level
		@capacity.reset new Resources wood: capacity, clay: capacity, iron: capacity



	# todo?





module.exports = Stash
