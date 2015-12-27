TimeoutQueue =		require '../util/TimeoutQueue'

Building =			require '../core/Building'
Recruitment =		require '../core/Recruitment'





class Academy extends Building



	# isAcademy

	# recruitments



	constructor: (props = {}) ->
		@isAcademy = true
		props.type = 'academy'
		super props

		@recruitments = new TimeoutQueue()



	recruit: (units) ->
		recruitment = new Recruitment this, units.subset 'noblemen'
		@recruitments.add recruitment
		return recruitment





module.exports = Academy
