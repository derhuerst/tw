assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'

Production =		require '../../src/util/Production'
{equalResources} =	require '../helpers'





describe 'Production', ->

	d1 = null
	r1 = null
	a = null

	beforeEach ->
		d1 = new Duration '1m'
		r1 = new Resources {wood: 100, clay: 200, iron: 300}
		a = new Production r1, d1


	it '`isProduction`', ->
		assert.strictEqual a.isProduction, true

	it 'should inherit from `EventEmitter`', ->
		assert a instanceof EventEmitter



	describe 'Production::constructor', ->

		it 'should initialize `resources` correctly', ->
			assert.notEqual a.resources, r1
			assert.strictEqual a.resources.wood, 100
			assert.strictEqual a.resources.clay, 200
			assert.strictEqual a.resources.iron, 300

		it 'should throw `ReferenceError` is no `Resources` are given', ->
			assert.throws (-> new Production()), ReferenceError
			assert.throws (-> new Production 'foo'), ReferenceError

		it 'should initialize `duration` correctly', ->
			assert.notEqual a.duration, d1
			assert.strictEqual a.duration.as('m'), 1

			b = new Production r1 # testing the default value
			assert.strictEqual b.duration.as('h'), 1



	describe 'Production::add', ->

		r2 = null
		b = null
		spy = sinon.spy()

		beforeEach ->
			r2 = new Resources {wood: 300, clay: 200, iron: 100}
			b = new Production r2, d1

		afterEach -> spy.reset()


		it 'should properly add a `Production` with different `resources`', ->
			a.add b
			assert.strictEqual a.resources.wood, 400
			assert.strictEqual a.resources.clay, 400
			assert.strictEqual a.resources.iron, 400

		it 'should properly add a `Production` with different `duration`', ->
			d2 = new Duration '2m'
			b = new Production r1, d2 # same `resources`, different `duration`
			a.add b
			assert.strictEqual a.resources.wood, 150
			assert.strictEqual a.resources.clay, 300
			assert.strictEqual a.resources.iron, 450

		it 'should not change the passed `Resources` instance', ->
			r2.on 'change', spy
			b.add a
			assert.strictEqual spy.callCount, 0



	describe 'Production::subtract', ->

		r2 = null
		b = null
		spy = sinon.spy()

		beforeEach ->
			r2 = new Resources {wood: 300, clay: 200, iron: 100}
			b = new Production r2, d1

		afterEach -> spy.reset()


		it 'should properly subtract a `Production` with different `resources`', ->
			a.subtract b
			assert.strictEqual a.resources.wood, -200
			assert.strictEqual a.resources.clay, 0
			assert.strictEqual a.resources.iron, 200

		it 'should properly subtract a `Production` with different `duration`', ->
			d2 = new Duration '2m'
			b = new Production r1, d2 # same `resources`, different `duration`
			a.subtract b
			assert.strictEqual a.resources.wood, 50
			assert.strictEqual a.resources.clay, 100
			assert.strictEqual a.resources.iron, 150

		it 'should not change the passed `Resources` instance', ->
			r2.on 'change', spy
			b.subtract a
			assert.strictEqual spy.callCount, 0



	describe 'Production::resourcesDuring', ->

		b = null
		c = null
		d = null

		beforeEach ->
			b = a.resourcesDuring new Duration '2m'
			c = a.resourcesDuring new Duration '30s'
			d = a.resourcesDuring 3 * 60 * 1000


		it '`isResources`', ->
			assert.strictEqual b.isResources, true
			assert.strictEqual c.isResources, true

		it 'should properly compute the `Resources`', ->
			assert.strictEqual b.wood, 200
			assert.strictEqual b.clay, 400
			assert.strictEqual b.iron, 600
			assert.strictEqual c.wood, 50
			assert.strictEqual c.clay, 100
			assert.strictEqual c.iron, 150
			assert.strictEqual d.wood, 300
			assert.strictEqual d.clay, 600
			assert.strictEqual d.iron, 900



	describe 'Production::durationToGet', ->

		b = null
		c = null

		beforeEach ->
			b = a.durationToGet r1.clone().multiply 2
			c = a.durationToGet r1.clone().multiply 1 / 2


		it '`isDuration`', ->
			assert.strictEqual b.isDuration, true
			assert.strictEqual c.isDuration, true

		it 'should properly compute the `Duration`', ->
			assert.strictEqual b.valueOf(), d1 * 2
			assert.strictEqual c.valueOf(), d1 / 2



	describe 'Production::clone', ->

		b = null
		beforeEach -> b = a.clone()


		it 'should properly instanciate the clone', ->
			assert.strictEqual b.isProduction, true
			assert b instanceof EventEmitter

		it 'should return a `Production` with equal, but distinct `resources`', ->
			assert.notEqual a.resources, b.resources
			assert equalResources a.resources, b.resources

		it 'should return a `Production` with equal, but distinct `duration`', ->
			assert.notEqual a.duration, b.duration
			assert.strictEqual a.duration.valueOf(), b.duration.valueOf()



	it 'should correctly emit `change` if its `resources` emit `change`', ->
		spy = sinon.spy()
		a.on 'change', spy
		a.resources.multiply 2

		assert spy.calledOnce
		[before, after] = spy.firstCall.args
		assert equalResources before.resources, r1
		assert equalResources after.resources, a.resources
		assert.strictEqual before.duration.valueOf(), d1.valueOf()
		assert.strictEqual after.duration.valueOf(), a.duration.valueOf()

	it 'should correctly emit `change` if its `duration` emits `change`', ->
		spy = sinon.spy()
		a.on 'change', spy
		a.duration.multiply 2

		assert spy.calledOnce
		[before, after] = spy.firstCall.args
		assert equalResources before.resources, r1
		assert equalResources after.resources, a.resources
		assert.strictEqual before.duration.valueOf(), d1.valueOf()
		assert.strictEqual after.duration.valueOf(), a.duration.valueOf()



	describe 'Production::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof a.toString(), 'string'
			assert.strictEqual typeof ('' + a), 'string'
