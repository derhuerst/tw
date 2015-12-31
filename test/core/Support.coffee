assert =			require 'assert'
sinon =				require 'sinon'

Support =			require '../../src/core/Support'
Movement =			require '../../src/core/Movement'
Vector =			require '../../src/util/Vector'
Village =			require '../../src/core/Village'
Units =				require '../../src/util/Units'
GameError =			require '../../src/util/GameError'





describe 'Support', ->

	origin = null
	destination = null
	d = null
	units = null
	s = null

	beforeEach ->
		origin = new Village position: new Vector 0, 0
		destination = new Village position: new Vector 1, 0
		d = destination.position.distanceTo origin.position
		origin.rallyPoint.units.available.add new Units axeman: 2, scout: 3
		units = new Units axeman: 1, scout: 1
		s = new Support {origin, destination, units}

	it '`isSupport`', ->
		assert.strictEqual s.isSupport, true

	it 'should inherit from `Movement`', ->
		assert s instanceof Movement



	describe 'event handling', ->

		spy = null
		beforeEach -> spy = sinon.spy()

		clock = null
		beforeEach -> clock = sinon.useFakeTimers()
		afterEach -> clock.restore()

		assertSpyCalledOnceWithS = ->
			assert spy.calledOnce
			assert spy.calledWithExactly s



		describe 'when starting at `origin`', ->

			it 'should emit `outgoing-movement` on `origin`', ->
				origin.on 'outgoing-movement', spy
				s.start()
				assertSpyCalledOnceWithS()

			it 'should emit `outgoing-movement.start` on `origin`', ->
				origin.on 'outgoing-movement.start', spy
				s.start()
				assertSpyCalledOnceWithS()

			it 'should emit `incoming-movement` on `destination`', ->
				destination.on 'incoming-movement', spy
				s.start()
				assertSpyCalledOnceWithS()

			it 'should emit `incoming-movement.start` on `destination`', ->
				destination.on 'incoming-movement.start', spy
				s.start()
				assertSpyCalledOnceWithS()



		describe 'when arriving at `destination`', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + s.units.speed() * d

			it 'should emit `outgoing-movement.finish` on `origin`', ->
				origin.on 'outgoing-movement.finish', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()

			it 'should emit `incoming-movement.finish` on `destination`', ->
				destination.on 'incoming-movement.finish', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()



		describe 'when aborted on the way from `origin` to `destination`', ->

			it 'should emit `outgoing-movement.abort` on `origin`', ->
				origin.on 'outgoing-movement.abort', spy
				s.start()
				clock.tick 10
				s.abort()
				assertSpyCalledOnceWithS()

			it 'should emit `incoming-movement.abort` on `destination`', ->
				destination.on 'incoming-movement.abort', spy
				s.start()
				clock.tick 10
				s.abort()
				assertSpyCalledOnceWithS()

			it 'should emit `incoming-movement` on `origin`', ->
				origin.on 'incoming-movement', spy
				s.start()
				clock.tick 10
				s.abort()
				clock.tick 5
				assertSpyCalledOnceWithS()

			it 'should emit `incoming-movement.start` on `origin`', ->
				origin.on 'incoming-movement.start', spy
				s.start()
				clock.tick 10
				s.abort()
				clock.tick 5
				assertSpyCalledOnceWithS()



	describe 'event handling, returning', ->

		spy = null
		beforeEach -> spy = sinon.spy()

		clock = null
		beforeEach -> clock = sinon.useFakeTimers()
		afterEach -> clock.restore()

		beforeEach -> s = new Support {origin, destination, units, returning: true}

		assertSpyCalledOnceWithS = ->
			assert spy.calledOnce
			assert spy.calledWithExactly s



		describe 'starting at `destination`', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + s.units.speed() * d

			it 'should emit `incoming-movement` on `origin`', ->
				origin.on 'incoming-movement', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()

			it 'should emit `incoming-movement.start` on `origin`', ->
				origin.on 'incoming-movement.start', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()

			it 'should emit `outgoing-movement` on `destination`', ->
				destination.on 'outgoing-movement', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()

			it 'should emit `outgoing-movement.start` on `destination`', ->
				destination.on 'outgoing-movement.start', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()

		describe 'when arriving at `origin`', ->

			expectedDuration = null
			beforeEach -> expectedDuration = 5 + 2 * s.units.speed() * d

			it 'should emit `incoming-movement.finish` on `origin`', ->
				origin.on 'incoming-movement.finish', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()

			it 'should emit `outgoing-movement.finish` on `destination`', ->
				destination.on 'outgoing-movement.finish', spy
				s.start()
				clock.tick expectedDuration
				assertSpyCalledOnceWithS()
