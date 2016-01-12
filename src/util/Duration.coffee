_Duration =			require 'duration-js'

NumericValue =		require '../util/NumericValue'





unitsToMethods =
	ms:	'milliseconds'
	s:	'seconds'
	m:	'minutes'
	h:	'hours'
	d:	'days'
	w:	'weeks'



class Duration extends NumericValue



	units:
		ms:	_Duration.millisecond
		s:	_Duration.second
		m:	_Duration.minute
		h:	_Duration.hour
		d:	_Duration.day
		w:	_Duration.week

	# isDuration

	# _duration



	constructor: (duration = 0) ->
		@isDuration = true
		super()

		@on 'change', @_valueOnChange
		if duration.isDuration then duration = duration.valueOf()
		@reset new _Duration(duration).valueOf()

		return this



	_valueOnChange: ->
		@_duration = new _Duration @value



	as: (digit) ->
		return NaN unless @_duration[unitsToMethods[digit]]
		return @_duration[unitsToMethods[digit]]()



	get: (digit = 'ms') ->
		return NaN unless @_duration[unitsToMethods[digit]]
		rest = @_duration
		for name in ['w', 'd', 'h', 'm', 's', 'ms']
			method = unitsToMethods[name]
			if name is digit then return rest[method] name
			rest = new _Duration rest - rest[method](name) * @units[name]



	clone: -> new Duration @value

	valueOf: -> @value

	toString: -> @_duration.toString 1 # alternative format





module.exports = Duration
