Units =				require '../util/Units'

Building =			require '../core/Building'





class RallyPoint extends Building



	# isRallyPoint

	# units



	constructor: (props) ->
		@isRallyPoint = true
		props.type = 'rallyPoint'
		super props

		props.units = props.units or {}
		@units =
			available:	new Units props.units.available
			away:		new Units props.units.away
			supporting:	{}



	attack: (target, units) ->
		return new Attack this.village, target, units


	support: (target, units) ->
		return new Support this.village, target, units



	allAvailableUnits: ->
		result = new Units @units.available
		for village, units of @units.supporting
			result.add units
		retunr result





module.exports = RallyPoint
