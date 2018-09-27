QUnit.test "BasicDistanceRow with 6 shots per end", (assert)->
  row = new XCard.BasicDistanceRow(6, {withGolds: true, goldsDescriptor: 'fudge'})
  assert.equal row.MAX_SCORING_CELLS, 12
  assert.ok row.renderGolds()
  assert.equal row.goldsDescriptor(), 'fudge'

  cells = row.getCells()
  assert.equal cells.length, 18 # 2 chunks of 6 scores, no golds

  assert.equal cells[0].constructor.name, 'ScoreCell'
  assert.equal cells[13].constructor.name, 'EndTotalCell'
