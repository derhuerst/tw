assert =			require 'assert'
sinon =				require 'sinon'

Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
Production =		require '../../src/util/Production'

Stocks =			require '../../src/util/Stocks'
{equalResources} =	require '../helpers'
{equalProduction} =	require '../helpers'





describe 'Stocks', ->

	m = null
	p = null
	s = null
	clock = null

	before -> clock = sinon.useFakeTimers()
	after -> clock.restore()

	beforeEach ->
		m = new Resources {wood: 200, clay: 200, iron: 200}
		p = new Production new Resources({wood: 50, clay: 100, iron: 150}), new Duration '1m'
		s = new Stocks {maxima: m, production: p}

	it '`isStocks`', ->
		assert.strictEqual s.isStocks, true



	describe 'Stocks::constructor', ->

		it 'should set `maxima` to a clone of the given `Resources`', ->
			assert.notEqual s.maxima, m
			assert equalResources s.maxima, m

		it 'should set `production` to a clone of the given `Production`', ->
			assert.notEqual s.production, p
			assert equalProduction s.production, p



	describe 'Stocks::resources', ->

		it 'should return an instance of `Resources`', ->
			r = s.resources()
			assert.strictEqual r.isResources, true



	it 'should limit its `resources` to `maxima`', ->
		clock.tick (new Duration '4m5s').valueOf()
		r = s.resources()
		assert equalResources r, s.maxima
		s.maxima.subtract 100
		assert equalResources r, s.maxima



	it 'should update its `resources` according to its `production`', ->
		clock.tick (new Duration '30s').valueOf()
		assert equalResources s.resources(), new Resources {wood: 25, clay: 50, iron: 75}
		clock.tick (new Duration '1m').valueOf()
		assert equalResources s.resources(), new Resources {wood: 75, clay: 150, iron: 200}

	it 'should handle its `production` being 0', ->
		clock.tick (new Duration '30s').valueOf()
		s.production.resources.reset 0
		clock.tick (new Duration '2m').valueOf()
		assert equalResources s.resources(), new Resources {wood: 25, clay: 50, iron: 75}



	it 'should handle its `production` getting changed', ->
		clock.tick (new Duration '30s').valueOf()
		s.production.resources.add new Resources {wood: 150, clay: 100, iron: 50}
		clock.tick (new Duration '30s').valueOf()
		assert equalResources s.resources(), new Resources
			wood: 25 + 100
			clay: 50 + 100
			iron: 75 + 100



	describe 'Production::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof s.toString(), 'string'
			assert.strictEqual typeof ('' + s), 'string'
