assert =			require 'assert'
sinon =				require 'sinon'

Duration =		require '../../src/util/Duration'
Interval =		require '../../src/util/Interval'





describe 'Interval', ->

	spy = sinon.spy()
	a = null

	beforeEach -> a = new Interval 100, spy
	afterEach ->
		a.stop()
		spy.reset()

	it '`isInterval`', ->
		assert.strictEqual a.isInterval, true



	describe 'Interval::noop', ->

		it 'should be a `Function`', ->
			assert.strictEqual typeof a.noop, 'function'



	describe 'Interval::constructor', ->

		it 'should set `callback`', ->
			assert.strictEqual a.callback, spy



	describe 'Interval::duration', ->

		it 'should return the duration passed to the constructor', ->
			assert.strictEqual a.duration().valueOf(), 100

			d = new Duration 100
			b = new Interval d, spy
			assert.strictEqual b.duration(), d



	describe 'Interval::start', ->

		it 'should return the instance', ->
			assert.strictEqual a.start(), a # call with the timeout not running
			assert.strictEqual a.start(), a # call with the timeout running



	describe 'Interval::stop', ->

		it 'should return the instance', ->
			assert.strictEqual a.stop(), a # call with the timeout not running
			a.start()
			assert.strictEqual a.stop(), a # call with the timeout running



	it 'should have called `callback` exactly twice after twice the `duration`', (done) ->
		checkIfCalledTwice = ->
			assert spy.calledTwice
			done()

		a.start()
		setTimeout checkIfCalledTwice, 220



	it 'should have not called `callback` called `stop()`', (done) ->
		checkIfCalledOnce = ->
			assert spy.calledOnce
			done()
		stop = ->
			a.stop()

		a.start()
		setTimeout stop, 110
		setTimeout checkIfCalledOnce, 220



	describe 'Interval::clone', ->

		b = null
		beforeEach -> b = a.clone()

		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isInterval, true

		it 'should return an `Interval` with an equal `duration`', ->
			assert.strictEqual b.duration.valueOf(), a.duration.valueOf()

		it 'should return an `Interval` with an equal `callback`', ->
			assert.strictEqual b.callback, a.callback



	describe 'Interval::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
