assert =			require 'assert'
sinon =				require 'sinon'

NumericValue =		require '../../src/util/NumericValue'
Duration =			require '../../src/util/Duration'





describe 'Duration', ->

	ms =	1 # millisecond
	s =		1000 # second
	m =		1000 * 60 # minute
	h =		1000 * 60 * 60 # hour
	d =		1000 * 60 * 60 * 24 # day
	w =		1000 * 60 * 60 * 24 * 7 # week
	testAsNumber = 6 * ms + 5 * s + 4 * m + 3 * h + 2 * d + 1 * w
	testAsString = '1w 2d 3h 4m 5s 6ms'

	a = null
	beforeEach -> a = new Duration testAsNumber

	it '`isDuration`', ->
		assert.strictEqual a.isDuration, true

	it 'should inherit from `NumericValue`', ->
		assert a instanceof NumericValue



	describe 'Vector::units', ->

		it 'should have a correct value for `ms`', ->
			assert.strictEqual a.units.ms + 0, ms

		it 'should have a correct value for `s`', ->
			assert.strictEqual a.units.s + 0, s

		it 'should have a correct value for `m`', ->
			assert.strictEqual a.units.m + 0, m

		it 'should have a correct value for `h`', ->
			assert.strictEqual a.units.h + 0, h

		it 'should have a correct value for `d`', ->
			assert.strictEqual a.units.d + 0, d

		it 'should have a correct value for `w`', ->
			assert.strictEqual a.units.w + 0, w



	describe 'Vector::constructor', ->

		it 'should set `value` correctly, given a `Number`', ->
			assert.strictEqual a.value, testAsNumber

		it 'should set `value` correctly, given a `String`', ->
			a = new Duration testAsString
			assert.strictEqual a.value, testAsNumber

		it 'should set `value` correctly, given a `Duration`', ->
			b = new Duration a
			assert.strictEqual b.value, testAsNumber

		it 'should set `value` correctly, given no argument`', ->
			a = new Duration()
			assert.strictEqual a.value, 0



	describe 'clone', ->

		b = null
		beforeEach -> b = a.clone()

		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isDuration, true
			assert b instanceof NumericValue

		it 'should return a `Duration` with an equal `value`', ->
			assert.strictEqual a.value, b.value



	describe 'valueOf', ->

		it 'should return `value`', ->
			assert.strictEqual a.valueOf(), a.value
			assert.strictEqual 0 + a, a.value



	it 'should work with methods inherited from `NumericValue`', ->
		a = new Duration '2w 3d 1m'
		onChange = sinon.spy()
		a.on 'change', onChange

		a.multiply 2
		assert.strictEqual a.valueOf(), new Duration('4w 6d 2m').valueOf()
		assert onChange.calledOnce

		a.add new Duration '1w 2d 3m'
		assert.strictEqual a.valueOf(), new Duration('6w 1d 5m').valueOf()
		assert onChange.calledTwice



	describe 'toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
