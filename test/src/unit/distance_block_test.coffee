QUnit.test "DistanceBlock configures for regular multi-distance shoots", (assert)->
  block = new XCard.DistanceBlock({
    shotsPerEnd: 6,
    totalShots: 36
  })
  assert.equal(block.endsPerRow, 2)
  assert.equal(block.rowCount, 3)
  assert.equal(block.titleCellSpan, 14)

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

  block = new XCard.DistanceBlock({
    shotsPerEnd: 3,
    totalShots: 60,
    withGolds: true,
    withHits: true
  }, endsData)

  assert.equal(block.withGolds, true)
  assert.equal(block.withPoints, false)
  assert.equal(block.endsPerRow, 2)
  assert.equal(block.rowCount, 10)
  assert.equal(block.titleCellSpan, 8)
  assert.equal(block.rows[0].constructor.name, 'HeaderRow')

  assert.equal(block.chunkedEndsScoreData[0].length, 2)
  assert.equal(block.chunkedEndsScoreData[1].length, 1)

  # assert.equal(block.toHtml().outerHTML, '<tbody></tbody>')
