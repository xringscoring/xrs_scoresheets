QUnit.test "ScoreCell builds correctly", (assert)->
  cell = new XCard.ScoreCell
  cell.setAttributes({
    textContent: 'x',
    data:
      value: 10
  })

  assert.equal cell.toHtml(), "<td data-value=\"10\" class=\"xcard-score-cell\">x</td>"
