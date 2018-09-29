class XCard.DistanceBlock

  constructor: (options = {}, @endsScoreData = {})->
    @options = Object.assign({
      element: 'tbody',
      config: null
      # We need a 'round totalizer' tracking overall totals
    }, options)

    unless @options.config?
      throw 'Distance configuration is required'

    @config = @options.config

    @configureBlock()

  configureBlock: ()->
    @shotsPerEnd = @config.shotsPerEnd
    @totalShots = @config.totalShots

    @numberOfEnds = @totalShots / @shotsPerEnd

    @endsPerRow = @getEndsPerRow()
    @cellsPerEnd = @getCellsPerEnd()

    @rowCount = @numberOfEnds / @endsPerRow
    @endTotalCells = @endsPerRow

    @withHits = @options.withHits
    @withGolds = @options.withGolds
    @withPoints = @options.withPoints
    @withX = @options.withX

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
        # shotsPerEnd: @shotsPerEnd,
        # withX: @withX,
        # withGolds: @withGolds,
        # withHits: @withHits,
        # withPoints: @withPoints

      }, @chunkedEndsScoreData[r - 1]))

    @rows.push new XCard.DistanceTotalsRow({
      config: @config,
      # withX: @withX,
      # withGolds: @withGolds,
      # withHits: @withHits,
      # withPoints: @withPoints,
      cellSpan: @titleCellSpan
      totals: {
        totalHits: ()->
          0e0.toString()
        ,
        totalGolds: ()->
          0e0.toString()
        ,
        totalX: ()->
          0e0.toString()
        ,
        runningTotal: ()->
          0e0.toString()
        ,
        runningTotalPoints: ()->
          0e0.toString()
      }
    })

  getCellsPerEnd: ()->
    if @shotsPerEnd <= 3
      return 3

    if @shotsPerEnd <= 6
      return 6

    12

  getEndsPerRow: ()->
    return if @shotsPerEnd <= 6 then 2 else 1

  getTitleCellSpan: ()->
    (@endsPerRow * @cellsPerEnd) + @endTotalCells

  toHtml: ()->
    element = document.createElement(@options.element)

    for r in @rows
      element.appendChild(r.toHtml())

    element
