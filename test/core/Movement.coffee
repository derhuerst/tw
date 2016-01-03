assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

config =			require '../../config/buildings/rally-point'
Vector =			require '../../src/util/Vector'
Village =			require '../../src/core/Village'
Units =				require '../../src/util/Units'
Movement =			require '../../src/core/Movement'
GameError =			require '../../src/util/GameError'
{equalUnits} =		require '../helpers'





describe 'Movement', ->

	origin = null
	destination = null
	d = null
	units = null
	m = null

	beforeEach ->
		origin = new Village position: new Vector 0, 0
		destination = new Village position: new Vector 1, 0
		d = destination.position.distanceTo origin.position
		origin.rallyPoint.units.available.add new Units axeman: 2, scout: 3
		units = new Units axeman: 1, scout: 1
		m = new Movement {origin, destination, units}


	it '`isMovement`', ->
		assert.strictEqual m.isMovement, true

	it 'should inherit from `EventEmitter`', ->
		assert m instanceof EventEmitter



	describe 'Movement::constructor', ->

		it 'should throw a `ReferenceError` if `origin` has not been passed', ->
			createWithoutOrigin = -> m = new Movement()
			assert.throws createWithoutOrigin, ReferenceError

		it 'should throw a `ReferenceError` if `destination` has not been passed', ->
			createWithoutDestination = -> m = new Movement()
			assert.throws createWithoutDestination, ReferenceError

		it 'should throw a `ReferenceError` if `units` have not been passed', ->
			createWithoutUnits = -> m = new Movement()
			assert.throws createWithoutUnits, ReferenceError

		it 'should throw a `GameError` if the `destination` is the `origin`', ->
			createWithOriginAsDestination = ->
				m = new Movement {origin, destination: origin, units}
			createWithDestinationAsOrigin = ->
				m = new Movement {origin: destination, destination, units}
			assert.throws createWithOriginAsDestination, GameError
			assert.throws createWithDestinationAsOrigin, GameError

		it 'should set `origin` to the passed one', ->
			assert.strictEqual m.origin, origin

		it 'should set `destination` to the passed one', ->
			assert.strictEqual m.destination, destination

		it 'should set `units` to the passed one', ->
			assert.strictEqual m.units, units



	describe 'Movement::running', ->

		it 'should return `false` in the beginning', ->
			assert.strictEqual m.running(), false

		it 'should return `true` after it has been started', ->
			m.start()
			assert.strictEqual m.running(), true

		# todo: move to `core/Attack`
		it.skip 'should return `true` when it is returning', ->
			m.start()
			clock.tick 100
			m.abort()
			assert.strictEqual m.running(), true



	describe 'Movement::returning', ->

		clock = null
		beforeEach -> clock = sinon.useFakeTimers()
		afterEach -> clock.restore()


		it 'should return `false` on the way to `destination`', ->
			m.start()
			clock.tick 100
			assert.strictEqual m.returning(), false

		it 'should return `true` after aborted', ->
			m.start()
			clock.tick 5
			m.abort()
			assert.strictEqual m.returning(), true

		# todo: move to `core/Attack`
		it.skip 'should return `true` after returning from `destination`', ->
			# todo



	describe 'Movement::aborted', ->

		clock = null
		beforeEach -> clock = sinon.useFakeTimers()
		afterEach -> clock.restore()


		it 'should return `false` on the way to `destination`', ->
			m.start()
			clock.tick 5
			assert.strictEqual m.aborted(), false

		it 'should return `true` after aborted and returning', ->
			m.start()
			clock.tick 100
			m.abort()
			assert.strictEqual m.aborted(), true

		it 'should return `true` after aborted and arrived at the `origin`', ->
			m.start()
			clock.tick 5
			m.abort()
			clock.tick 5
			assert.strictEqual m.aborted(), true



	describe 'Movement::start', ->

		start = null
		beforeEach -> start = -> m.start()


		it 'should throw a `GameError` if there are not enough units in `origin`', ->
			m.origin.rallyPoint.units.available.reset 0
			assert.throws start, GameError

		it 'should add the `units` to `origin.rallyPoint.units.away`', ->
			onChange = sinon.spy()
			origin.rallyPoint.units.away.on 'change', onChange

			m.start()
			assert onChange.calledOnce
			assert equalUnits origin.rallyPoint.units.away, new Units axeman: 1, scout: 1

		it 'should subtract the `units` from `origin.rallyPoint.units.available`', ->
			onChange = sinon.spy()
			origin.rallyPoint.units.available.on 'change', onChange

			m.start()
			assert onChange.calledOnce
			assert equalUnits origin.rallyPoint.units.available, new Units axeman: 1, scout: 2

		it 'should emit `start`', ->
			onStart = sinon.spy()
			m.on 'start', onStart
			m.start()
			assert onStart.calledOnce



	describe 'Movement::abort', ->

		clock = null
		beforeEach -> clock = sinon.useFakeTimers()
		afterEach -> clock.restore()

		expectedDuration = null
		beforeEach -> expectedDuration = 5 + m.units.speed() * d

		abort = null
		beforeEach -> abort = -> m.abort()


		it 'should throw a `GameError` if `config.movementsTimeToRevoke` is over', ->
			m.start()
			clock.tick 5 + config.movementsTimeToRevoke
			assert.throws abort, GameError

		it.skip 'should throw a `GameError` if `returning`', ->
			m.start()
			clock.tick expectedDuration
			assert m.returning()
			assert.throws abort, GameError

		it.skip 'should correctly set the time to return', ->
			before = m.origin.rallyPoint.units.available.clone()
			m.start()
			clock.tick 10
			m.abort()
			clock.tick 5
			assert equalUnits m.origin.rallyPoint.units.available, before

		it 'should emit `abort`', ->
			onAbort = sinon.spy()
			m.on 'abort', onAbort
			m.start()
			m.abort()
			assert onAbort.calledOnce



	describe 'Movement::toString', ->

		it.skip 'should return a `String`', ->
			assert.strictEqual typeof m.toString(), 'string'
			assert.strictEqual typeof ('' + m), 'string'
