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
    @numberOfEnds = @config.totalShots / @config.shotsPerEnd

    @endsPerRow = @getEndsPerRow()
    @cellsPerEnd = @getCellsPerEnd()

    @rowCount = @numberOfEnds / @endsPerRow
    @endTotalCells = @endsPerRow

    @titleCellSpan = @getTitleCellSpan()

    @chunkedEndsScoreData = XCard.chunkArray(@endsScoreData, @endsPerRow)

    @rows = [
      new XCard.DistanceHeaderRow({
        config: @config,
        title: @config.title,
        titleCellSpan: @titleCellSpan
      })
    ]

    for r in [1..@rowCount]
      @rows.push( new XCard.ScoringRow({
        cellCount: @cellsPerEnd,
        endCount: @endsPerRow,
        config: @config,
        totals: @totalizer
      }, @chunkedEndsScoreData[r - 1]))

    @rows.push new XCard.DistanceTotalsRow({
      config: @config,
      totals: @totalizer,
      cellSpan: @titleCellSpan
    })

  getCellsPerEnd: ()->
    if @config.shotsPerEnd <= 3
      return 3

    if @config.shotsPerEnd <= 6
      return 6

    12

  getEndsPerRow: ()->
    return if @config.shotsPerEnd <= 6 then 2 else 1

  getTitleCellSpan: ()->
    (@endsPerRow * @cellsPerEnd) + @endTotalCells

  toHtml: ()->
    element = document.createElement(@options.element)

    for r in @rows
      element.appendChild(r.toHtml())

    element
