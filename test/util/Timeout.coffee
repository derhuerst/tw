assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

Duration =		require '../../src/util/Duration'
Timeout =		require '../../src/util/Timeout'





describe 'Timeout', ->

	a = null
	spy = sinon.spy()

	beforeEach -> a = new Timeout 100
	afterEach -> spy.reset()

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

		it 'should return ~ `.33` after a third of the given `Duration`', (done) ->
			checkIfRoughlyHalf = ->
				p = a.progress()
				assert .315 < p < .345
				done()

			setTimeout checkIfRoughlyHalf, a.duration() / 3
			a.start()



	describe 'Duration::remaining', ->

		beforeEach -> a = new Timeout 500

		it 'should return `0` in the non-running timeout', ->
			assert.strictEqual a.remaining(), 0
			a.start();a.stop()
			assert.strictEqual a.remaining(), 0
			a.start(); a.finish()
			assert.strictEqual a.remaining(), 0

		it 'should return ~ the remaining duration', (done) ->
			expected = a.duration() * 2 / 3
			checkIfRoughlyHalf = ->
				precision = a.remaining() / expected
				assert .95 < precision < 1.05
				done()

			setTimeout checkIfRoughlyHalf, a.duration() / 3
			a.start()



	it 'should emit `finish` exactly once after the given `Duration`', (done) ->
		a.on 'finish', spy
		checkIfCalledOnce = ->
			assert spy.calledOnce
			done()

		a.start()
		setTimeout checkIfCalledOnce, 110



	it 'should emit `finish` only once & immediatly when called `finish()`', (done) ->
		a.on 'finish', spy
		checkIfCalledOnce = ->
			assert spy.calledOnce
			done()

		a.start()
		setTimeout checkIfCalledOnce, 400

		a.finish()
		assert spy.calledOnce



	describe 'Timeout::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
