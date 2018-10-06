class XCard.DistanceTitleCells

  {displayCell} = XCard

  constructor: (options = {})->
    @options = Object.assign({
      config: null
    }, options)

    @config = @options.config
    @endTotalCells = @config.endTotalCells # count

    @cellSpan = @getCellSpan()

    @cells = [
      displayCell(@config.title, 'title-cell', colSpan: @cellSpan)
    ]

    if @config.endTotalCells >= 1
      @cells.push displayCell('et', 'header-et-cell')

    if @config.endsPerRow > 1
      @cells.push displayCell('', 'header-spacer-cell', colSpan: @cellSpan)

    if @config.endTotalCells > 1
      @cells.push displayCell('et', 'header-et-cell')

  getCellSpan: ()->
    if @config.endsPerRow is 1
      return (@config.endsPerRow * @config.cellsPerEnd)

    @config.cellsPerEnd
