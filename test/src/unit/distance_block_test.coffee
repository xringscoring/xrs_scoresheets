QUnit.module('Metric rounds')
QUnit.test "without scoring", (assert)->
  tRound = new XCard.TargetDataAdapter(getTargetRound('fita_70'), 'recurve')
  config = new XCard.DistanceConfig(tRound.distances[0])
  block = new XCard.DistanceBlock(config: config)
  assert.equal block.config.rowCount, 6, 'row count correct'


QUnit.module('Odd end count rounds')
QUnit.test "Half Metric rounds have 1.5-dozen rows", (assert)->
  tRound = new XCard.TargetDataAdapter(getTargetRound('half_metric_gents'), 'recurve')
  config = new XCard.DistanceConfig(tRound.distances[0])
  block = new XCard.DistanceBlock(config: config)
  assert.equal block.config.rowCount, 2, 'row count correct'
  assert.equal(block.rows[2].constructor.name, 'ScoringRow', 'is a ScoringRow')
  assert.equal(block.rows[2].scoringEnds.length, 2, 'Scoring ends count correct')

  scoringEnd = block.rows[2].scoringEnds[0]
  assert.ok(scoringEnd.endInUse, 'scoring cell in use')
  assert.equal(scoringEnd.cells()[0].attributes['className'], "score-cell", 'correct class')

  nonScoringEnd = block.rows[2].scoringEnds[1]
  assert.notOk(nonScoringEnd.endInUse, 'scoring cell unused')
  assert.equal(nonScoringEnd.cells()[0].attributes['className'], "score-cell unused", 'correct class')


QUnit.test "DistanceBlock configures for regular multi-distance shoots", (assert)->
  config = new XCard.DistanceConfig({
    shotsPerEnd: 6,
    totalShots: 36
  })

  block = new XCard.DistanceBlock({
    config: config
  })

  assert.equal(block.config.shotsPerEnd, 6, 'shots per end')
  assert.equal(block.config.endsPerRow, 2, 'ends per row')
  assert.equal(block.config.rowCount, 3, 'row count is correct')
  # assert.equal(block.config.titleCellSpan, 14, 'title cellspan')


QUnit.test "DistanceBlock configures for indoor-type shoot with 3 ends complete", (assert)->
  endsData = [
    {
      shots: [
        {
          score: 9,
        },
        {
          score: 9
        },
        {
          score: 8
        }
      ]
    },
    {
      shots: [
        {
          score: 10,
          isGold: true
        },
        {
          score: 9
        },
        {
          score: 8
        }
      ]
    },
    {
      shots: [
        {
          score: 10,
          isGold: true
        },
        {
          score: 10,
          isGold: true
        },
        {
          score: 8
        }
      ]
    }
  ]

  config = new XCard.DistanceConfig({
    shotsPerEnd: 3,
    totalShots: 60,
    withX: false
  })

  block = new XCard.DistanceBlock({
    config: config,
  }, endsData)

  assert.equal(block.config.withGolds, true, 'with golds')
  assert.equal(block.config.withPoints, false, 'points not shown')
  assert.equal(block.config.endsPerRow, 2, 'ends per row')
  assert.equal(block.config.rowCount, 10, 'row count')
  # assert.equal(block.config.titleCellSpan, 8, 'title cell span')
  assert.equal(block.rows[0].constructor.name, 'DistanceHeaderRow', 'constructor name correct')

  assert.equal(block.chunkedEndsScoreData[0].length, 2)
  assert.equal(block.chunkedEndsScoreData[1].length, 1)

  # Half-filled Scoring Row has a filled totalsBlock
  assert.equal(block.rows[2].constructor.name, 'ScoringRow', 'is a ScoringRow')
  assert.equal(block.rows[2].totalsBlock.cells[0].attributes['textContent'], '28', 'row total is correct')
  assert.equal(block.rows[2].totalsBlock.cells[3].attributes['textContent'], '81', 'running total is correct')

  # Unfilled scoring rows do not have filled total blocks
  assert.equal(block.rows[3].constructor.name, 'ScoringRow', 'is a ScoringRow')
  assert.equal(block.rows[3].totalsBlock.cells[0].attributes['textContent'], '', 'row total is empty')
  assert.equal(block.rows[3].totalsBlock.cells[3].attributes['textContent'], '', 'running total is empty')

  # assert.equal(block.toHtml().outerHTML, '<tbody></tbody>')
