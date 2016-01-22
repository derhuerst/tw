TimeoutQueue =		require '../util/TimeoutQueue'
NumericValue =		require '../util/NumericValue'

Building =			require '../core/Building'
Recruitment =		require '../core/Recruitment'





class Statue extends Building



	# isStatue

	# recruitments
	# timeFactor



	constructor: (props = {}) ->
		isStatue = true
		props.type = 'statue'
		super props

		@recruitments = new TimeoutQueue()




	recruit: (units) -> # todo





module.exports = Statue
