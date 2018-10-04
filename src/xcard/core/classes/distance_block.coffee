class XCard.DistanceBlock

  constructor: (options = {}, @endsScoreData = {})->
    @options = Object.assign({
      element: 'tbody',
      config: null
    }, options)

    unless @options.config?
      throw 'Distance configuration is required'

    @config = @options.config
    @totalizer = @options.totalizer ? new XCard.Totalizer({config: @config})

    @configureBlock()

  configureBlock: ()->
    @chunkedEndsScoreData = XCard.chunkArray(@endsScoreData, @config.endsPerRow)

    @rows = [
      new XCard.DistanceHeaderRow({
        config: @config
      })
    ]

    for r in [1..@config.rowCount]
      @rows.push( new XCard.ScoringRow({
        config: @config,
        totals: @totalizer
      }, @chunkedEndsScoreData[r - 1]))

    @rows.push new XCard.DistanceTotalsRow({
      config: @config,
      totals: @totalizer,
      cellSpan: @config.titleCellSpan
    })

  toHtml: ()->
    element = document.createElement(@options.element)

    for r in @rows
      element.appendChild(r.toHtml())

    element
