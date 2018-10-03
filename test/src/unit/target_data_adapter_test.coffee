QUnit.module "Metric rounds"
QUnit.test "single distance", (assert) ->
  adapter = new XCard.TargetDataAdapter(getTargetRound('fita_70'), 'recurve')
  assert.equal adapter.distances.length, 1, 'correct distance count'

  d = adapter.distances[0]
  assert.equal d.shotsPerEnd, 6, 'correct SPE'
  assert.equal d.totalShots, 72, 'correct total shots'
  assert.equal d.title, '70m', 'correct title'
  assert.equal d.goldScore, 10, 'correct gold score'

QUnit.test "multi distance", (assert) ->
  adapter = new XCard.TargetDataAdapter(getTargetRound('gents_fita'), 'recurve')
  assert.equal adapter.distances.length, 4, 'correct distance count'

  d = adapter.distances[0]
  assert.equal d.shotsPerEnd, 6, 'correct SPE'
  assert.equal d.totalShots, 36, 'correct total shots'
  assert.equal d.title, '90m', 'correct title'
  assert.equal d.goldScore, 10, 'correct gold score'

  d = adapter.distances[2]
  assert.equal d.shotsPerEnd, 3, 'correct SPE'
  assert.equal d.totalShots, 36, 'correct total shots'
  assert.equal d.title, '50m', 'correct title'
  assert.equal d.goldScore, 10, 'correct gold score'
