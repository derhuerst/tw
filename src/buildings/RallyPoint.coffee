Units =				require '../util/Units'

Building =			require '../core/Building'





class RallyPoint extends Building



	# units

	isRallyPoint: true



	constructor: (options) ->
		options = options or {}
		options.type = 'rallyPoint'
		super options

		options.units = options.units or {}
		@units =
			available:	new Units options.units.available
			away:		new Units options.units.away
			supporting:	{}



	attack: (target, units) ->
		return new Attack this.village, target, units


	support: (target, units) ->
		return new Support this.village, target, units



	allAvailableUnits: () ->
		result = new Units @units.available
		for village, units of @units.supporting
			result.add units
		retunr result





module.exports = RallyPoint
