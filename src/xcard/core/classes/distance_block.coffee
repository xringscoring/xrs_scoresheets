class XCard.DistanceBlock

  constructor: (options = {}, @endsScoreData = {})->
    @options = Object.assign({
      shotsPerEnd: 6, # actual shots per end
      title: '1', # should be something like '90m'
      totalShots: 36,
      withGolds: true,
      withHits: true,
      withPoints: false,
      withX: false
    }, options)

    @configureBlock()

  configureBlock: ()->
    @shotsPerEnd = @options.shotsPerEnd
    @totalShots = @options.totalShots
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
      new XCard.HeaderRow({
        title: @options.title,
        titleCellSpan: @titleCellSpan
      })
    ]

    for r in [1..@rowCount]
      @rows.push( new XCard.ScoringRow({
        cellCount: @cellsPerEnd,
        endCount: @endsPerRow,
        shotsPerEnd: @shotsPerEnd,
        withX: @withX,
        withGolds: @withGolds,
        withHits: @withHits,
        withPoints: @withPoints
      }, @chunkedEndsScoreData[r - 1]))

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
    element = document.createElement('tbody')

    for r in @rows
      element.appendChild(r.toHtml())

    element
