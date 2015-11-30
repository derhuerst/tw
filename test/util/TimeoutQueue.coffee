assert =			require 'assert'
sinon =				require 'sinon'
{EventEmitter} =	require 'events'

Timeout =			require '../../src/util/Timeout'
TimeoutQueue =		require '../../src/util/TimeoutQueue'





describe 'TimeoutQueue', ->

	a = null
	t1 = null
	t2 = null
	spy = sinon.spy()

	beforeEach ->
		a = new TimeoutQueue()
		t1 = new Timeout 50
		t2 = new Timeout 100

	afterEach -> spy.reset()

	it '`isTimeoutQueue`', ->
		assert.strictEqual a.isTimeoutQueue, true

	it 'should inherit from `EventEmitter`', ->
		assert a instanceof EventEmitter



	describe 'TimeoutQueue::add', ->

		it 'should return the instance', ->
			assert.strictEqual a.add(), a
			assert.strictEqual a.add(t1), a

		it 'should emit `add` with the given `Timeout`', ->
			a.on 'add', spy
			a.add t1
			assert spy.calledOnce
			assert spy.calledWithExactly t1

		it 'should not emit `add` with an invalid timeout', ->
			a.on 'add', spy
			a.add {}
			a.add()
			assert.strictEqual spy.callCount, 0



	describe 'TimeoutQueue::remove', ->

		it 'should return the instance', ->
			assert.strictEqual a.remove(), a
			assert.strictEqual a.remove(t1), a

		it 'should emit `remove` with the given `Timeout`', ->
			a.on 'remove', spy
			a.add t1

			a.remove t1
			assert spy.calledOnce
			assert spy.calledWithExactly t1

		it 'should not emit `add` if the given `Timeout` is not in the list', ->
			a.on 'remove', spy
			a.remove t1
			a.remove t2
			assert.strictEqual spy.callCount, 0



	it 'should start each `Timeout` extactly once', (done) ->
		sinon.spy t1, 'start'
		sinon.spy t2, 'start'
		checkT2CalledOnce = ->
			assert t2.start.calledOnce
			done()

		a.add t1
		a.add t2
		assert t1.start.calledOnce
		setTimeout checkT2CalledOnce, 60



	it 'should emit `start` if the list was empty', (done) ->
		a.on 'start', spy
		checkCalledOnce = ->
			assert spy.calledOnce
			done()

		a.add t1
		a.add t2
		setTimeout checkCalledOnce, 60



	it 'should emit `finish` if the list will be empty', (done) ->
		a.on 'finish', spy
		checkCalledOnce = ->
			assert spy.calledOnce
			done()

		a.add t1
		a.add t2
		setTimeout (-> assert.strictEqual spy.callCount, 0), 60
		setTimeout checkCalledOnce, 160



	it 'should emit `progress` for each `Timeout` extactly once', (done) ->
		a.on 'progress', spy
		checkT1CalledOnce = ->
			assert spy.calledOnce
			assert spy.calledWithExactly t1
			spy.reset()
		checkT2CalledOnce = ->
			assert spy.calledOnce
			assert spy.calledWithExactly t2
			spy.reset()
			done()

		a.add t1
		a.add t2
		setTimeout checkT1CalledOnce, 60
		setTimeout checkT2CalledOnce, 160
