assert =			require 'assert'
sinon =				require 'sinon'

container = require '../../src/container'
require '../../src/util/Interval'
Duration = container 'util.Duration'
Interval = container 'util.Interval'





describe 'Interval', ->

	spy = sinon.spy()
	a = null
	clock = null

	before -> clock = sinon.useFakeTimers()
	after -> clock.restore()

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



	it 'should have called `callback` exactly twice after twice the `duration`', ->
		a.start()
		clock.tick 220
		assert spy.calledTwice



	it 'should have not called `callback` called `stop()`', ->
		a.start()
		clock.tick 110
		a.stop()
		clock.tick 110
		assert spy.calledOnce



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
