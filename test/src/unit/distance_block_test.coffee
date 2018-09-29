QUnit.test "DistanceBlock configures for regular multi-distance shoots", (assert)->
  config = new XCard.DistanceConfig({
    shotsPerEnd: 6,
    totalShots: 36
  })

  block = new XCard.DistanceBlock({
    config: config
  })

  assert.equal(block.config.shotsPerEnd, 6, 'shots per end')
  assert.equal(block.endsPerRow, 2, 'ends per row')
  assert.equal(block.rowCount, 3, 'row count is correct')
  assert.equal(block.titleCellSpan, 14, 'title cellspan')

QUnit.test "DistanceBlock configures for indoor-type shoot", (assert)->
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
    totalShots: 60
  })

  block = new XCard.DistanceBlock({
    config: config,
  }, endsData)

  assert.equal(block.config.withGolds, true, 'with golds')
  assert.equal(block.config.withPoints, false, 'points not shown')
  assert.equal(block.endsPerRow, 2, 'ends per row')
  assert.equal(block.rowCount, 10, 'row count')
  assert.equal(block.titleCellSpan, 8, 'title cell span')
  assert.equal(block.rows[0].constructor.name, 'DistanceHeaderRow', 'constructor name correct')

  assert.equal(block.chunkedEndsScoreData[0].length, 2)
  assert.equal(block.chunkedEndsScoreData[1].length, 1)

  # assert.equal(block.toHtml().outerHTML, '<tbody></tbody>')
