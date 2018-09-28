QUnit.test "ScoreCell builds correctly", (assert)->
  cell = new XCard.ScoreCell({
    score: 8,
  })

  assert.equal cell.toHtmlString(), "<td data-score=\"8\" class=\"score-cell\">8</td>"
  assert.equal cell.score(), 8
