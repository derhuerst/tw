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



	_valueOnChange: ->
		@_duration = new _Duration @value

	# todo: use moment.duration here
	parse: (string) ->
		return 0 if string is '0' or string is '-0'

		duration = 0
		regex = /(\-?[\d.]+)(ms|s|m|h|d)/g
		sign = 1
		if string.charAt(0) is '-'
			sign = -1
			string = string.slice 1

		while match = regex.exec string
			value = parseFloat match[1]
			if isNaN value
				throw new Error 'invalid duration'
			duration += value * @units[match[2]]

		return sign * duration





	clone: -> new Duration @value

	valueOf: -> @value

	toString: -> @_duration.toString 1 # alternative format





module.exports = Duration
