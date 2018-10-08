QUnit.module('App V2')

QUnit.test "albion parsed correctly", (assert)->
  data = shootDataAlbion
  adapter = new XCard.ScoreDataAdapter(data)

  assert.equal(adapter.distances.length, 3, 'correct distance count')
  assert.equal(adapter.distances[0].shotsPerEnd, 6, 'correct shotsPerEnd')
  assert.equal(adapter.distances[1].distanceEnds.length, 6, 'correct distanceEnds count')

QUnit.test "folded into scoresheet", (assert)->
  data = shootDataAlbion
  sdAdapter = new XCard.ScoreDataAdapter(data)
  trAdapter = new XCard.TargetDataAdapter(getTargetRound('albion'), 'recurve')

  # 80yds
  scoreDistance = sdAdapter.distances[0]
  config = new XCard.DistanceConfig(trAdapter.distances[0], scoreDistance)
  assert.equal(config.shotsPerEnd, 6)

  block = new XCard.DistanceBlock({config: config}, scoreDistance.distanceEnds)
  assert.equal(block.chunkedEndsScoreData[0].length, 2)

  # First row totals correct
  assert.equal(block.rows[1].totalsBlock.cells[0].attributes['textContent'], '100', 'row summary is correct')
  assert.equal(block.rows[1].totalsBlock.cells[1].attributes['textContent'], '12', 'total hits correct')
  assert.equal(block.rows[1].totalsBlock.cells[2].attributes['textContent'], '8', 'total golds correct')

  # Final total row filled correctly
  assert.equal(block.rows[4].cells[1].attributes['textContent'], '36', 'total hits correct')
  assert.equal(block.rows[4].cells[2].attributes['textContent'], '19', 'total golds correct')
  assert.equal(block.rows[4].cells[3].attributes['textContent'], '284', 'total score correct')
