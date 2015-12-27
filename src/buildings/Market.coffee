Building =			require '../core/Building'





class Market extends Building



	# isMarket



	constructor: (props = {}) ->
		@isMarket = true
		props.type = 'market'
		super props

		# todo



	# todo





module.exports = Market
