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
  scoringRow = new XCard.ScoringRow({
    cellCount: 3,
    endCount: 2,
    shotsPerEnd: 3,
    withX: false,
    withGolds: true,
    withHits: true
  }, endShotData)

  assert.equal(scoringRow.scoringEnds.length, 2)
  assert.equal(scoringRow.totalsBlock.getRowTotalScore(), 59)
  assert.equal(scoringRow.totalsBlock.getRowTotalGolds(), 5)
  assert.equal(scoringRow.totalsBlock.getRowTotalHits(), 6)


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
    shotsPerEnd: 5,
    withX: false,
    withGolds: true,
    withHits: true
  }, endShotData)

  assert.equal(scoringRow.scoringEnds.length, 2)
  assert.equal(scoringRow.totalsBlock.getRowTotalGolds().toString(), '0')
  assert.equal(scoringRow.totalsBlock.getRowTotalScore(), 42)

  # assert.equal(scoringRow.toHTML(), '<tr></tr>')
