QUnit.test "DistanceConfig has sensible defaults", (assert)->
  config = new XCard.DistanceConfig
  assert.equal(config.withHits, true)
  assert.equal(config.withPoints, false)

QUnit.test "DistanceConfig hides hits if match", (assert)->
  config = new XCard.DistanceConfig({
    recurveMatch: true
  })
  assert.equal(config.withHits, false)

  config = new XCard.DistanceConfig({
    compoundMatch: true
  })
  assert.equal(config.withHits, false)

QUnit.test "DistanceConfig shows points if recurve match", (assert)->
  config = new XCard.DistanceConfig({
    recurveMatch: true
  })
  assert.equal(config.withPoints, true)

QUnit.test "DistanceConfig shows points if compound match", (assert)->
  config = new XCard.DistanceConfig({
    recurveMatch: true
  })
  assert.equal(config.withPoints, true)
