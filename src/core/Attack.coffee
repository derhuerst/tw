config =			require '../../config/units'
GameError =			require '../util/GameError'
Movement =			require '../core/Movement'
Fight =				require '../core/Fight'





class Attack extends Movement



	# isAttack



	constructor: ->
		@isAttack = true
		super arguments...



	start: ->
		return if @running()

		distance = @origin.position.distanceTo @target.position
		if @units.nobleman > 0 and distance > 50
			throw new GameError "A #{config.nobleman.title} cannot travel further than 50 fields."

		if @units.workers > @origin.farm.workers / 100
			throw new GameError "The number of workers of your army has to be a hundredth of your village's workers."

		return super()



	onStart: ->
		super()
		origin.emit 'outgoing-attack', this
		origin.emit 'outgoing-attack.start', this
		origin.emit 'incoming-attack', this
		origin.emit 'incoming-attack.start', this


	onStop: ->
		super()
		origin.emit 'outgoing-attack.stop', this
		origin.emit 'incoming-attack.stop', this


	onFinish: ->
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
