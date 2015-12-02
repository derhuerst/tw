assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

Duration =			require '../../src/util/Duration'
Timeout =			require '../../src/util/Timeout'





describe 'Timeout', ->

	a = null
	spy = sinon.spy()
	clock = null

	before -> clock = sinon.useFakeTimers()
	after -> clock.restore()

	beforeEach ->a = new Timeout 100
	afterEach ->
		a.stop()
		spy.reset()

	it '`isTimeout`', ->
		assert.strictEqual a.isTimeout, true

	it 'should inherit from `EventEmitter`', ->
		assert a instanceof EventEmitter



	describe 'Timeout::duration', ->

		b = null
		beforeEach -> b = new Timeout new Duration 100

		it 'should return the duration passed to the constructor', ->
			assert.strictEqual a.duration() + 0, 100
			assert.strictEqual b.duration() + 0, 100



	describe 'Duration::start', ->

		it 'should return the instance', ->
			assert.strictEqual a.start(), a # call with the timeout not running
			assert.strictEqual a.start(), a # call with the timeout running

		it 'should emit `start` exactly once', ->
			a.on 'start', spy
			a.start() # call with the timeout not running
			a.start() # call with the timeout running
			assert spy.calledOnce



	describe 'Duration::stop', ->

		it 'should return the instance', ->
			assert.strictEqual a.stop(), a # call with the timeout not running
			a.start()
			assert.strictEqual a.stop(), a # call with the timeout running

		it 'should emit `stop` exactly once', ->
			a.on 'stop', spy
			a.start()
			a.stop() # call with the timeout running
			a.stop() # call with the timeout not running
			assert spy.calledOnce



	describe 'Duration::finish', ->

		it 'should return the instance', ->
			assert.strictEqual a.finish(), a # call with the timeout not running
			a.start()
			assert.strictEqual a.finish(), a # call with the timeout running

		it 'should emit `finish` exactly once', ->
			a.on 'finish', spy
			a.start()
			a.finish() # call with the timeout running
			a.finish() # call with the timeout not running
			assert spy.calledOnce



	describe 'Duration::running', ->

		beforeEach -> a.start()

		it 'should return `true` for started timeouts', ->
			assert.strictEqual a.running(), true

		it 'should return `false` for stopped timeouts', ->
			a.stop()
			assert.strictEqual a.running(), false

		it 'should return `false` for finished timeouts', ->
			a.start(); a.finish()
			assert.strictEqual a.running(), false



	describe 'Duration::progress', ->

		beforeEach -> a = new Timeout 500

		it 'should return `0` in the beginning', ->
			assert.strictEqual a.progress(), 0

		it 'should return `0` for stopped timeouts', ->
			a.stop()
			assert.strictEqual a.progress(), 0

		it 'should return `1` for finished timeouts', ->
			a.start(); a.finish()
			assert.strictEqual a.progress(), 1

		it 'should return ~ `.33` after a third of the given `Duration`', ->
			a.start()
			clock.tick 500 / 3 + 5
			assert .315 < a.progress() < .345



	describe 'Duration::remaining', ->

		beforeEach -> a = new Timeout 500

		it 'should return `0` in the non-running timeout', ->
			assert.strictEqual a.remaining(), 0
			a.start();a.stop()
			assert.strictEqual a.remaining(), 0
			a.start(); a.finish()
			assert.strictEqual a.remaining(), 0

		it 'should return ~ the remaining duration', ->
			expected = a.duration() * 2 / 3
			a.start()
			clock.tick 500 / 3 + 5
			assert .95 < (a.remaining() / expected) < 1.05



	it 'should emit `finish` exactly once after the given `Duration`', ->
		a.on 'finish', spy
		a.start()
		clock.tick 105
		assert spy.calledOnce

	it 'should emit `finish` only once & immediatly when called `finish()`', ->
		a.on 'finish', spy
		a.start()
		assert.strictEqual spy.callCount, 0
		a.finish()
		clock.tick 105
		assert spy.calledOnce



	describe 'Timeout::clone', ->

		a = null
		b = null

		beforeEach ->
			a = new Timeout 2, 'test'
			b = a.clone()

		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isTimeout, true
			assert b instanceof EventEmitter

		it 'should return a `Timeout` with an equal duration', ->
			assert.strictEqual a.valueOf(), b.valueOf()



	describe 'Timeout::valueOf', ->

		it 'should return the duration', ->
			assert.strictEqual a.valueOf(), 100



	describe 'Timeout::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
