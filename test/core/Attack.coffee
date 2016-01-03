assert =			require 'assert'
sinon =				require 'sinon'

Attack =			require '../../src/core/Attack'
Movement =			require '../../src/core/Movement'
Vector =			require '../../src/util/Vector'
Village =			require '../../src/core/Village'
Units =				require '../../src/util/Units'
GameError =			require '../../src/util/GameError'





describe 'Attack', ->

	origin = null
	destination = null
	d = null
	units = null
	a = null

	beforeEach ->
		origin = new Village position: new Vector 0, 0
		destination = new Village position: new Vector 1, 0
		d = destination.position.distanceTo origin.position
		origin.rallyPoint.units.available.add new Units axeman: 2, scout: 3
		units = new Units axeman: 1, scout: 1
		a = new Attack {origin, destination, units}


	it '`isAttack`', ->
		assert.strictEqual a.isAttack, true

	it 'should inherit from `Movement`', ->
		assert a instanceof Movement



	describe 'Attack::constructor', ->

		it 'should set `haul` to a `Resources`', ->
			assert.strictEqual a.haul.isResources, true



	describe 'Attack::start', ->

		start = null
		beforeEach -> start = -> a.start()


		it 'should throw a `GameError` if noblemen would travel further than `50`', ->
			a.units.nobleman = 1
			a.destination.position.x = 51
			assert.throws start, GameError

		it 'should throw a `GameError` if attacking with not enough population', ->
			a.origin.points.reset 1000
			assert.throws start, GameError



	describe 'event handling', ->

		spy = null
		beforeEach -> spy = sinon.spy()

		clock = null
		beforeEach -> clock = sinon.useFakeTimers()
		afterEach -> clock.restore()

		assertSpyCalledOnceWithA = ->
			assert spy.calledOnce
			assert spy.calledWithExactly a



		describe 'when starting at `origin`', ->

			it 'should emit `outgoing-movement` on `origin`', ->
				origin.on 'outgoing-movement', spy
				a.start()
				assertSpyCalledOnceWithA()

			it 'should emit `outgoing-movement.start` on `origin`', ->
				origin.on 'outgoing-movement.start', spy
				a.start()
				assertSpyCalledOnceWithA()

			it 'should emit `incoming-movement` on `destination`', ->
				destination.on 'incoming-movement', spy
				a.start()
				assertSpyCalledOnceWithA()

			it 'should emit `incoming-movement.start` on `destination`', ->
				destination.on 'incoming-movement.start', spy
				a.start()
				assertSpyCalledOnceWithA()



		describe 'when arriving at `destination`', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + a.units.speed() * d


			it 'should emit `outgoing-movement.finish` on `origin`', ->
				origin.on 'outgoing-movement.finish', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()

			it 'should emit `incoming-movement.finish` on `destination`', ->
				destination.on 'incoming-movement.finish', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()



		describe 'when aborted on the way from `origin` to `destination`', ->

			it 'should emit `outgoing-movement.abort` on `origin`', ->
				origin.on 'outgoing-movement.abort', spy
				a.start()
				clock.tick 10
				a.abort()
				assertSpyCalledOnceWithA()

			it 'should emit `incoming-movement.abort` on `destination`', ->
				destination.on 'incoming-movement.abort', spy
				a.start()
				clock.tick 10
				a.abort()
				assertSpyCalledOnceWithA()

			it 'should emit `incoming-movement` on `origin`', ->
				origin.on 'incoming-movement', spy
				a.start()
				clock.tick 10
				a.abort()
				clock.tick 5
				assertSpyCalledOnceWithA()

			it 'should emit `incoming-movement.start` on `origin`', ->
				origin.on 'incoming-movement.start', spy
				a.start()
				clock.tick 10
				a.abort()
				clock.tick 5
				assertSpyCalledOnceWithA()



		describe 'starting at `destination`', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + a.units.speed() * d


			it 'should emit `incoming-movement` on `origin`', ->
				origin.on 'incoming-movement', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()

			it 'should emit `incoming-movement.start` on `origin`', ->
				origin.on 'incoming-movement.start', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()

			it 'should emit `outgoing-movement` on `destination`', ->
				destination.on 'outgoing-movement', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()

			it 'should emit `outgoing-movement.start` on `destination`', ->
				destination.on 'outgoing-movement.start', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()



		describe 'when arriving at `origin`', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + 2 * a.units.speed() * d


			it 'should emit `incoming-movement.finish` on `origin`', ->
				origin.on 'incoming-movement.finish', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()

			it 'should emit `outgoing-movement.finish` on `destination`', ->
				destination.on 'outgoing-movement.finish', spy
				a.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithA()
