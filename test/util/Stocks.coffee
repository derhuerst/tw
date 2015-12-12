assert =			require 'assert'
sinon =				require 'sinon'

Resources =			require '../../src/util/Resources'
Duration =			require '../../src/util/Duration'
Production =		require '../../src/util/Production'

Stocks =			require '../../src/util/Stocks'





equalResources = (a, b) ->
	assert.strictEqual a.wood, b.wood
	assert.strictEqual a.clay, b.clay
	assert.strictEqual a.iron, b.iron



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

		it 'should set `maxima` to the given `Resources`', ->
			assert.strictEqual s.maxima, m

		it 'should set `production` to the given `Production`', ->
			assert.strictEqual s.production, p



	describe 'Stocks::resources', ->

		it 'should return an instance of `Resources`', ->
			r = s.resources()
			assert.strictEqual r.isResources, true



	it 'should limit its `resources` to `maxima`', ->
		clock.tick (new Duration '4m5s').valueOf()
		r = s.resources()
		equalResources r, s.maxima
		s.maxima.subtract 100
		equalResources r, s.maxima



	it 'should update its `resources` according to its `production`', ->
		clock.tick (new Duration '30s').valueOf()
		equalResources s.resources(), new Resources {wood: 25, clay: 50, iron: 75}
		clock.tick (new Duration '1m').valueOf()
		equalResources s.resources(), new Resources {wood: 75, clay: 150, iron: 200}

	it 'should handle its `production` being 0', ->
		clock.tick (new Duration '30s').valueOf()
		s.production.resources.reset 0
		clock.tick (new Duration '2m').valueOf()
		equalResources s.resources(), new Resources {wood: 25, clay: 50, iron: 75}



	it 'should handle its `production` getting changed', ->
		clock.tick (new Duration '30s').valueOf()
		s.production.resources.add new Resources {wood: 150, clay: 100, iron: 50}
		clock.tick (new Duration '30s').valueOf()
		equalResources s.resources(), new Resources
			wood: 25 + 100
			clay: 50 + 100
			iron: 75 + 100



	describe 'Production::toString', ->

		it 'should return a `String`', ->
			assert.strictEqual typeof s.toString(), 'string'
			assert.strictEqual typeof ('' + s), 'string'
