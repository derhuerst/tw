Timeout =			require '../util/Timeout'
Units =				require '../util/Units'
GameError =			require '../util/GameError'





barracksLevel = ->
	if @units.infantry().count() > 0 and @village.barracks?.level < 1
		throw new GameError "There are no #{@village.barracks.config.title} \
			in your village."

stableLevel = ->
	if @units.cavalry().count() > 0 and @village.stable?.level < 1
		throw new GameError "There is no #{@village.stable.config.title} \
			in your village."

workshopLevel = ->
	if @units.siege().count() > 0 and @village.workshop?.level < 1
		throw new GameError "There is no #{@village.workshop.config.title} \
			in your village."

academyLevel = ->
	if @units.nobleman > 0 and @village.academy?.level < 1
		throw new GameError "There is no #{@village.academy.config.title} \
			in your village."

statueLevel = ->
	if @units.paladin > 0 and @village.statue?.level < 1
		throw new GameError "There is no #{@village.statue.config.title} \
			in your village."

paladinExistsInVillage = ->
	# todo: use `config.title`s in the error messages
	# todo: check all, not just available
	if @units.paladin > 0 and @village.rallyPoint.units.available.paladin > 0
		throw new GameError 'Your village already has a paladin.'



class Recruitment extends Timeout



	# isRecruitment

	# village
	# units



	constructor: (village, units) ->
		@isRecruitment = true
		super()

		if village?.isVillage then @village = village or null
		else throw new ReferenceError 'Missing `village` argument.'

		if units?.isUnits then @units = units.clone()
		else throw new ReferenceError 'Missing `units` argument.'

		@_startRequirements = [
			barracksLevel, stableLevel, workshopLevel, academyLevel, statueLevel,
			paladinExistsInVillage
		]

		@on 'start', @_onStart
		@on 'stop', @_onStop
		@on 'finish', @_onFinish

		return this



	_startRequirements: null

	start: ->
		return this if @running()
		vlg = @village

		requirement.call this for requirement in @_startRequirements

		resources = @units.resources()
		if vlg.warehouse.stocks.resources().moreThan resources
			vlg.warehouse.stocks.resources().subtract resources
		else throw new GameError "Not enough resources to recruit (#{@units})."

		workers = @units.workers()
		if vlg.farm.workers >= workers then vlg.farm.workers.subtract workers
		else throw new GameError "Not enough workers to recruit (#{@units})."

		@duration().reset (
			@units.infantry().duration() * (vlg.barracks?.timeFactor ? 1) +
			@units.cavalry().duration() * (vlg.stable?.timeFactor ? 1) +
			@units.siege().duration() * (vlg.workshop?.timeFactor ? 1) +
			@units.subset('paladin').duration() +
			@units.subset('nobleman').duration())

		return super()



	_onStart: =>
		@village.emit 'recruitment.start', this

	_onStop: =>
		# todo: correct?
		@village.warehouse.stocks.resources().add @units.resources().multiply 0.9
		@village.farm.workers.add @units.workers()
		@village.emit 'recruitment.stop', this

	_onFinish: =>
		@village.rallyPoint.units.available.add @units
		@village.emit 'recruitment.finish', this
		@village.emit 'recruitment', this



	toString: -> "+ (#{@units})"





module.exports = Recruitment
