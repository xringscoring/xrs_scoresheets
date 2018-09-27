class XCard.BasicDistanceRow

  constructor: (@shotsPerEnd, options = {})->
    # Limit
    @MAX_SCORING_CELLS = 12

    @options = Object.assign({
      withHits: true,
      withGolds: true,
      withMatchPoints: false,
      withX: false,
      goldsDescriptor: 'g'
      hitsDescriptor: 'h'
      xDescriptor: 'x'
    }, options)

    @buildCells()

  buildCells: ()->
    @cells = []
    scoringCellsPerRow = @getScoringCellsPerRow()
    scoringCellChunks = @getScoringCellChunkCount()

    for t in [1..(scoringCellsPerRow / scoringCellChunks)]
      for s in [1..scoringCellChunks]
        @cells.push( new XCard.ScoreCell() )

      @cells.push( new XCard.EndTotalCell())

    # Handle Hits
    if @renderHits()
      @cells.push( new XCard.BasicCell( {classes: ['xcard-hits']}))

    # Handle Golds
    if @renderGolds()
      @cells.push( new XCard.BasicCell( {classes: ['xcard-golds']}))

    # Handle Xs
    if @renderX()
      @cells.push( new XCard.BasicCell( {classes: ['xcard-x']}))

    # Handle row total score
    @cells.push( new XCard.BasicCell( {classes: ['xcard-row-total']}))

    # Handle round total score
    @cells.push( new XCard.BasicCell( {classes: ['xcard-round-total']}))


  getCells: ()->
    @cells

  getScoringCellsPerRow: ()->
    return if @shotsPerEnd <= 3 then 6 else 12

  getScoringCellChunkCount: ()->
    # Switch statements with range value operators are very slow
    if @shotsPerEnd <= 3
      return 3

    if @shotsPerEnd <= 6
      return 6

    return 12

  goldsDescriptor: ()->
    @options.goldsDescriptor

  renderHits: ()->
    @options.withHits

  renderGolds: ()->
    @options.withGolds

  renderX: ()->
    @options.withX
