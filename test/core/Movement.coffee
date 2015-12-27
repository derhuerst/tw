assert =			require 'assert'
sinon =				require 'sinon'

config =			require '../../config/buildings/rally-point'
Vector =			require '../../src/util/Vector'
Village =			require '../../src/core/Village'
Units =				require '../../src/util/Units'
Movement =			require '../../src/core/Movement'
Timeout =			require '../../src/util/Timeout'
GameError =			require '../../src/util/GameError'





equalUnits = (a, b) ->
	for type in ['spearFighter','swordsman','axeman','archer','scout','lightCavalry','mountedArcher','heavyCavalry','ram','catapult','paladin','nobleman']
		assert.strictEqual a[type], b[type]
	return true



describe 'Movement', ->

	origin = null
	target = null
	d = null
	u = null
	m = null

	beforeEach ->
		origin = new Village position: new Vector 0, 0
		target = new Village position: new Vector 1, 0
		d = target.position.distanceTo origin.position
		origin.rallyPoint.units.available.add new Units axeman: 2, scout: 3
		u = new Units axeman: 1, scout: 1
		m = new Movement origin, target, u

	beforeEach ->
		# todo

	it '`isMovement`', ->
		assert.strictEqual m.isMovement, true

	it 'should inherit from `Timeout`', ->
		assert m instanceof Timeout



	describe 'Movement::constructor', ->

		it 'should throw a `ReferenceError` if an `origin` has not been passed', ->
			createWithoutOrigin = -> m = new Movement()
			assert.throws createWithoutOrigin, ReferenceError

		it 'should throw a `ReferenceError` if an `target` has not been passed', ->
			createWithoutOrigin = -> m = new Movement()
			assert.throws createWithoutOrigin, ReferenceError

		it 'should throw a `ReferenceError` if an `units` has not been passed', ->
			createWithoutOrigin = -> m = new Movement()
			assert.throws createWithoutOrigin, ReferenceError

		it 'should set `origin` to the passed one', ->
			assert.strictEqual m.origin, origin

		it 'should set `target` to the passed one', ->
			assert.strictEqual m.target, target

		it 'should set `units` to the passed one', ->
			assert.strictEqual m.units, u

		it 'should set `returning` to `false`', ->
			assert.strictEqual m.returning, false



	describe 'Movement::start', ->

		it 'should throw a `GameError` if `origin` and `target` are the same', ->
			startWithSameOriginAndTarget = ->
				m.target = m.origin
				m.start()
			assert.throws startWithSameOriginAndTarget, GameError

		it 'should throw a `GameError` if there are not enough units in `origin`', ->
			m.origin.rallyPoint.units.available.reset 0
			start = -> m.start()
			assert.throws start, GameError

		it 'should add the `units` to `origin.rallyPoint.units.away`', ->
			onChange = sinon.spy()
			origin.rallyPoint.units.away.on 'change', onChange

			m.start()
			assert onChange.calledOnce
			equalUnits origin.rallyPoint.units.away, new Units axeman: 1, scout: 1

		it 'should subtract the `units` from `origin.rallyPoint.units.available`', ->
			onChange = sinon.spy()
			origin.rallyPoint.units.available.on 'change', onChange

			m.start()
			assert onChange.calledOnce
			equalUnits origin.rallyPoint.units.available, new Units axeman: 1, scout: 2

		it 'should `start` itself', ->
			m.start()
			assert m.running()



	describe 'event handling', ->

		spy = null
		clock = null

		beforeEach ->
			spy = sinon.spy()
			clock = sinon.useFakeTimers()

		afterEach -> clock.restore()

		assertSpyCalledOnceWithM = ->
			assert spy.calledOnce
			assert spy.calledWithExactly m



		describe 'when started', ->

			it 'should emit `outgoing-movement` on `origin`', ->
				origin.on 'outgoing-movement', spy
				m.start()
				assertSpyCalledOnceWithM()

			it 'should emit `outgoing-movement.start` on `origin`', ->
				origin.on 'outgoing-movement.start', spy
				m.start()
				assertSpyCalledOnceWithM()

			it 'should emit `incoming-movement` on `target`', ->
				target.on 'incoming-movement', spy
				m.start()
				assertSpyCalledOnceWithM()

			it 'should emit `incoming-movement.start` on `target`', ->
				target.on 'incoming-movement.start', spy
				m.start()
				assertSpyCalledOnceWithM()



		describe 'when arrived', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + m.units.speed() * d

			afterEach -> clock.restore()

			it 'should emit `outgoing-movement.finish` on `origin`', ->
				origin.on 'outgoing-movement.finish', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()

			it 'should emit `incoming-movement.finish` on `target`', ->
				target.on 'incoming-movement.finish', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()



		describe 'when started returning', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + m.units.speed() * d

			it 'should emit `incoming-movement` on `origin`', ->
				origin.on 'incoming-movement', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()

			it 'should emit `incoming-movement.start` on `origin`', ->
				origin.on 'incoming-movement.start', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()

			it 'should emit `outgoing-movement` on `target`', ->
				target.on 'outgoing-movement', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()

			it 'should emit `outgoing-movement.start` on `target`', ->
				target.on 'outgoing-movement.start', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()



		describe 'when arrived, after returned', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + 2 * m.units.speed() * d

			it 'should emit `incoming-movement.finish` on `origin`', ->
				origin.on 'incoming-movement.finish', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()

			it 'should emit `outgoing-movement.finish` on `target`', ->
				target.on 'outgoing-movement.finish', spy
				m.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithM()



		describe 'when stopped', ->

			it 'should emit `outgoing-movement.stop` on `origin`', ->
				origin.on 'outgoing-movement.stop', spy
				m.start()
				clock.tick 100
				m.stop()
				assertSpyCalledOnceWithM()

			it 'should emit `incoming-movement.stop` on `target`', ->
				target.on 'incoming-movement.stop', spy
				m.start()
				clock.tick 100
				m.stop()
				assertSpyCalledOnceWithM()

			it 'should emit `incoming-movement` on `origin`', ->
				origin.on 'incoming-movement', spy
				m.start()
				clock.tick 100
				m.stop()
				clock.tick 5
				assertSpyCalledOnceWithM()

			it 'should emit `incoming-movement.start` on `origin`', ->
				origin.on 'incoming-movement.start', spy
				m.start()
				clock.tick 100
				m.stop()
				clock.tick 5
				assertSpyCalledOnceWithM()



		describe 'when arrived after stopped', ->

			it 'should emit `incoming-movement.finish` on `origin`', ->
				origin.on 'incoming-movement.finish', spy
				m.start()
				clock.tick 100
				m.stop()
				clock.tick 100
				assertSpyCalledOnceWithM()



	describe 'Movement::stop', ->

		clock = null
		expectedDuration = null

		beforeEach ->
			clock = sinon.useFakeTimers()
			expectedDuration = 5 + m.units.speed() * d

		afterEach -> clock.restore()

		it 'should throw a `GameError` if `config.movementsTimeToRevoke` is over', ->
			stop = -> m.stop()
			m.start()
			clock.tick 5 + config.movementsTimeToRevoke
			assert.throws stop, GameError

		it 'should throw a `GameError` if `returning`', ->
			stop = -> m.stop()
			m.start()
			clock.tick expectedDuration
			assert.throws stop, GameError

		it 'should correctly set the time to return', ->
			m.start()
			clock.tick 100
			m.stop()
			assert.strictEqual m.remaining().valueOf(), 100

		it 'should set `returning` and `stopped` to `true`', ->
			m.start()
			clock.tick 100
			m.stop()
			assert.strictEqual m.returning, true
			assert.strictEqual m.stopped, true



	describe 'Movement::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof m.toString(), 'string'
			assert.strictEqual typeof ('' + m), 'string'
