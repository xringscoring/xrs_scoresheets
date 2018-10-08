class XCard.DistanceHeaderRow extends XCard.BlockElement

  {displayCell} = XCard

  constructor: (options = {})->
    super(options)

    @totalsFunctionMap =
      'h': [ 'getRowHitsCell', @config.withHits ],
      'g': [ 'getRowGoldsCell', @config.withGolds ],
      'x': [ 'getRowXCell', @config.withX ],
      'p': [ 'getRowPointsCell', @config.withPoints ],
      't': [ 'getRowTotalCell', @config.endsPerRow > 1 ],
      'rt': [ 'getRunningTotalCell', true ]
      'tp': [ 'getRunningTotalPointsCell', @config.withPoints ]

    @cells = new XCard.DistanceTitleCells({config: @config}).cells

    for totalsItem in @config.totalsOrder
      f = @totalsFunctionMap[totalsItem]
      if f[1]
        @cells.push @[f[0]]()

  getRowGoldsCell: ()->
    displayCell(@forDisplay(@config.goldsDescriptor), "row-golds-cell")

  getRowTotalCell: ()->
    displayCell(@forDisplay("s"), "row-total-cell")

  getRowHitsCell: ()->
    displayCell(@forDisplay('h'), "row-hits-cell")

  getRowPointsCell: ()->
    displayCell(@forDisplay('pt'), "row-points-cell")

  getRowXCell: ()->
    displayCell(@forDisplay('x'), "row-x-cell")

  getRunningTotalCell: ()->
    displayCell(@forDisplay('tot'), "running-total-cell wide")

  getRunningTotalPointsCell: ()->
    displayCell(@forDisplay('tot pt'), "running-total-points-cell")

  forDisplay: (v)->
    if @options.config.withTotalHeaders then v else ''

  toHtmlString: ()->
    @toHtml().outerHTML

  toHtml: ()->
    element = new XCard.BasicElement({ className: 'header-row' }, 'tr').toHtml()

    for pCell in @paddingCells
      element.appendChild(pCell.toHtml())

    # Then total cells
    for c in @cells.slice(0)
      element.appendChild(c.toHtml())

    element
