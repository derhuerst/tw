Building =			require '../core/Building'





class Market extends Building



	# isMarket



	constructor: (options) ->
		@isMarket = true
		options = options or {}
		options.type = 'market'
		super options

		# todo



	# todo





module.exports = Market
