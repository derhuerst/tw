GameError =			require '../util/GameError'

Movement =			require '../core/Movement'
Fight =				require '../core/Fight'





class Attack extends Movement



	isAttack: true



	start: () ->
		return if @running()

		# todo: check if noble men. if, check if distance is > 50 fields

		# todo: check if origin inhabitans / 100 > units workers

		return super()



	onStart: () ->
		super()
		origin.emit 'outgoing-attack', this
		origin.emit 'outgoing-attack.start', this
		origin.emit 'incoming-attack', this
		origin.emit 'incoming-attack.start', this


	onStop: () ->
		super()
		origin.emit 'outgoing-attack.stop', this
		origin.emit 'incoming-attack.stop', this


	onFinish: () ->
		super()
		origin.emit 'outgoing-attack.finish', this
		origin.emit 'incoming-attack.finish', this

		# todo: initialize fight
		fight = new Fight
			attacking:				@units
			defending:				@target.rallyPoint.allAvailableUnits()
			wallBasicDefense:		@target.wall.basicDefense
			wallDefenseFactor:		@target.wall.defenseFactor
			catapultsTargetLevel:	@target.wall.defenseFactor





module.exports = Attack
