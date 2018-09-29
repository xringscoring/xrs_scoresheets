QUnit.test "ScoringRow builds correctly for 3 SPE", (assert)->
  endShotData = [
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
          score: 10,
          isGold: true
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
          score: 9
        }
      ]
    }
  ]

  config = new XCard.DistanceConfig({
    shotsPerEnd: 3,
    totalShots: 60
  })

  scoringRow = new XCard.ScoringRow({
    cellCount: 3,
    endCount: 2,
    config: config
  }, endShotData)

  assert.equal(scoringRow.scoringEnds.length, 2, 'scoringEnds count')
  assert.equal(scoringRow.totalsBlock.getRowTotalScore(), 59, 'row total score')
  assert.equal(scoringRow.totalsBlock.getRowTotalGolds(), 5, 'row total golds')
  assert.equal(scoringRow.totalsBlock.getRowTotalHits(), 6, 'row total hits')


QUnit.test "ScoringRow builds correctly for 5 SPE", (assert)->
  endShotData = [
    {
      shots: [
        {
          score: 5
        },
        {
          score: 5
        },
        {
          score: 4
        },
        {
          score: 4
        },
        {
          score: 4
        }
      ]
    },
    {
      shots: [
        {
          score: 5
        },
        {
          score: 5
        },
        {
          score: 4
        },
        {
          score: 3
        },
        {
          score: 3
        }
      ]
    },
  ]
  scoringRow = new XCard.ScoringRow({
    cellCount: 6,
    endCount: 2,
    config: new XCard.DistanceConfig({
      shotsPerEnd: 5,
      totalShots: 60
    })
  }, endShotData)

  assert.equal(scoringRow.scoringEnds.length, 2)
  assert.equal(scoringRow.totalsBlock.getRowTotalGolds().toString(), '0')
  assert.equal(scoringRow.totalsBlock.getRowTotalScore(), 42)

  # assert.equal(scoringRow.toHTML(), '<tr></tr>')
