QUnit.test "elementToString returns required tags", (assert)->
  element = XCard.elementToString('div', {
    className: "xc-cell blue",
    textContent: 'x',
    data:
      value: 10
  })
  assert.equal element, "<div data-value=\"10\" class=\"xc-cell blue\">x</div>"
