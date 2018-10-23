QUnit.test "DistanceHeaderRow builds correctly for general shoot", (assert)->
  config = new XCard.DistanceConfig({
    withX: false,
    title: '80yd',
    titleCellSpan: 8
  })
  headerRow = new XCard.DistanceHeaderRow({
    config: config
  })

  result = "<tr class=\"header-row\"><td class=\"title-cell\" colspan=\"6\">80yd</td><td class=\"header-et-cell\">et</td><td class=\"header-spacer-cell\" colspan=\"6\"></td><td class=\"header-et-cell\">et</td><td class=\"row-total-cell\">s</td><td class=\"row-hits-cell\">h</td><td class=\"row-golds-cell\">g</td><td class=\"running-total-cell wide\">tot</td></tr>"

  assert.equal(headerRow.toHtmlString(), result)

QUnit.test "DistanceHeaderRow builds correctly for match shoot", (assert)->
  config = new XCard.DistanceConfig({
    withX: true
    recurveMatch: true,
    title: '80yd',
    titleCellSpan: 4
  })

  headerRow = new XCard.DistanceHeaderRow({
    config: config
  })

  result = "<tr class=\"header-row\"><td class=\"title-cell\" colspan=\"3\">80yd</td><td class=\"row-golds-cell\">g</td><td class=\"row-x-cell\">x</td><td class=\"running-total-cell wide\">tot</td><td class=\"row-points-cell\">pt</td><td class=\"running-total-points-cell\">tot pt</td></tr>"

  assert.equal(headerRow.toHtmlString(), result)
