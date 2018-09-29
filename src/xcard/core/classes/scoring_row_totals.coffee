class XCard.ScoringRowTotals

  constructor: (options = {})->
    @options = Object.assign({
      config: null
      scoringEnds: [],
      totals: null
    }, options)

    unless @options.config?
      throw "ScoringRow totals requires DistanceConfig"

    @scoringEnds = @options.scoringEnds
    @buildTotals()

  buildTotals: ()->
    rowTotalScore = @getRowTotalScore()
    @options.totals.totalScore += rowTotalScore

    rowTotalHits = @getRowTotalHits()
    @options.totals.totalHits += rowTotalHits

    rowTotalGolds = @getRowTotalGolds()
    @options.totals.totalGolds += rowTotalGolds

    rowTotalX = @getRowTotalX()
    @options.totals.totalX += rowTotalX

    @cells = [
      new XCard.BasicCell({
        className: 'row-total-score',
        textContent: rowTotalScore.toString()
        })
    ]

    if @options.config.withHits
      @cells.push(new XCard.BasicCell({
        className: 'row-hits-total',
        textContent: rowTotalHits.toString()
      }))

    # if @options.withPoints

    if @options.config.withGolds
      @cells.push(new XCard.BasicCell({
        className: 'row-golds-total',
        textContent: rowTotalGolds.toString()
      }))

    if @options.config.withX
      @cells.push(new XCard.BasicCell({
        className: 'row-x-total',
        textContent: rowTotalX.toString()
      }))

    #
    # TODO: how to calculate running total dynamically
    #
    @cells.push(new XCard.BasicCell({
      className: 'row-running-total'
      textContent: @options.totals.totalScore.toString()
      }))

  cells: ()->
    @cells

  getRowTotalGolds: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.endTotalCell.totalGolds()
    , 0)

  getRowTotalX: ()->
    0

  getRowTotalHits: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalHits()
    , 0)

  getRowTotalScore: ()->
    @scoringEnds.reduce((accum, se)->
      accum + se.totalScore()
    , 0)
