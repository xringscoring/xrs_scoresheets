QUnit.test "ScoringEnd builds correctly for 3 SPE", (assert)->
  shots = [
    {
      score: 8,
      text: null,
      isGold: false,
      isX: false
    },
    {
      score: 9,
      text: null,
      isGold: false,
      isX: false
    },
    {
      score: 10,
      text: 'x',
      isGold: true,
      isX: true
    }
  ]

  scoringEnd = new XCard.ScoringEnd({
    cellCount: 3,
    config: new XCard.DistanceConfig({
      shotsPerEnd: 3
    }),
    scores: shots
  })

  cells = scoringEnd.cells()

  assert.equal(cells.length, 4)
  assert.equal(cells[3].constructor.name, 'EndTotalCell')
  assert.equal(cells[3].totalScore(), 27)
  assert.equal(cells[3].textContent(), '27')


QUnit.test "ScoringEnd builds correctly for 3 SPE with only 2 scores", (assert)->
  shots = [
    {
      score: 8,
      text: null,
      isGold: false,
      isX: false
    },
    {
      score: 9,
      text: null,
      isGold: false,
      isX: false
    }
  ]

  scoringEnd = new XCard.ScoringEnd({
    cellCount: 3,
    scores: shots,
    config: new XCard.DistanceConfig({
      shotsPerEnd: 3
    })
  })

  cells = scoringEnd.cells()

  assert.equal(cells.length, 4)
  assert.equal(cells[3].constructor.name, 'EndTotalCell')
  assert.equal(scoringEnd.totalScore(), 17)
  assert.equal(cells[3].textContent(), '')

#
# A la Worcester
#
QUnit.test "ScoringEnd builds correctly for 5 SPE with 6 cells", (assert)->
  shots = [
    {
      score: 5,
      text: null,
      isGold: true,
      isX: false
    },
    {
      score: 5,
      text: null,
      isGold: true,
      isX: false
    },
    {
      score: 4,
      text: null,
      isGold: false,
      isX: false
    },
    {
      score: 4,
      text: null,
      isGold: false,
      isX: false
    },
    {
      score: 4,
      text: null,
      isGold: false,
      isX: false
    }
  ]

  scoringEnd = new XCard.ScoringEnd({
    cellCount: 6,
    scores: shots,
    config: new XCard.DistanceConfig({
      shotsPerEnd: 5
    }),
  })

  cells = scoringEnd.cells()

  assert.equal(cells.length, 7)
  assert.equal(cells[6].constructor.name, 'EndTotalCell')
  assert.equal(scoringEnd.totalScore(), 22)
  assert.equal(cells[6].textContent(), '22')

  assert.equal(cells[5].getClasses(), 'score-cell unused')
