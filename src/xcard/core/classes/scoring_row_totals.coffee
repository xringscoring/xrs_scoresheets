class XCard.ScoringRowTotals

  constructor: (options = {})->
    @options = Object.assign({
      withHits: false,
      withGolds: false,
      withPoints: false,
      withX: false,
      scoringEnds: [],
    }, options)

    @scoringEnds = @options.scoringEnds
    @buildTotals()

  buildTotals: ()->
    @cells = [
      new XCard.BasicCell({
        className: 'row-total-score',
        textContent: @getRowTotalScore().toString()
        })
    ]

    if @options.withHits
      @cells.push(new XCard.BasicCell({
        className: 'row-hits-total',
        textContent: @getRowTotalHits().toString()
      }))

    # if @options.withPoints

    if @options.withGolds
      @cells.push(new XCard.BasicCell({
        className: 'row-golds-total',
        textContent: @getRowTotalGolds().toString()
      }))

    if @options.withX
      @cells.push(new XCard.BasicCell({
        className: 'row-x-total',
        textContent: @getRowTotalX().toString()
      }))

    #
    # TODO: how to calculate running total dynamically
    #
    @cells.push(new XCard.BasicCell({
      className: 'row-running-total'
      textContent: 'rt'
      }))

    # if @options.withPoints
    #   @cells.push RUNNINGTOTALPOINTS

  cells: ()->
    @cells

  getRowTotalGolds: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.endTotalCell.totalGolds()
    , 0)

  getRowTotalHits: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalHits()
    , 0)

  getRowTotalScore: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalScore()
    , 0)
