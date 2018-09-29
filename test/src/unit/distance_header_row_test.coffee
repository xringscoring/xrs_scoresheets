QUnit.test "HeaderRow builds correctly for general shoot", (assert)->
  config = new XCard.DistanceConfig({
    withX: false
  })
  headerRow = new XCard.DistanceHeaderRow({
    config: config,
    title: '80yd',
    titleCellSpan: 8
  })

  result = "<tr class=\"header-row\"><td class=\"title-cell\" colspan=\"8\">80yd</td><td class=\"row-total-cell\">rt</td><td class=\"row-hits-cell\">h</td><td class=\"row-golds-cell\">g</td><td class=\"running-total-cell\">tot</td></tr>"

  assert.equal(headerRow.toHtmlString(), result)

QUnit.test "HeaderRow builds correctly for match shoot", (assert)->
  config = new XCard.DistanceConfig({
    withX: true
    recurveMatch: true
  })

  headerRow = new XCard.DistanceHeaderRow({
    config: config
    title: '80yd',
    titleCellSpan: 4
  })

  result = "<tr class=\"header-row\"><td class=\"title-cell\" colspan=\"4\">80yd</td><td class=\"row-total-cell\">rt</td><td class=\"row-points-cell\">pt</td><td class=\"row-golds-cell\">g</td><td class=\"row-x-cell\">x</td><td class=\"running-total-cell\">tot</td></tr>"

  assert.equal(headerRow.toHtmlString(), result)
