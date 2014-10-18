Building =			require '../core/Building'





class Market extends Building



	isMarket: true



	constructor: (options) ->
		options = options or {}
		options.type = 'market'
		super options

		# todo



	# todo





module.exports = Market
