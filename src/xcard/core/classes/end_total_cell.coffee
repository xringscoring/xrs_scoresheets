class XCard.EndTotalCell extends XCard.BasicCell

  constructor: (@options = {}) ->
    unless @options.config?
      throw "EndTotalCell requires DistanceConfig"

    @scoringCells = @options.scoringCells ? []

    super({
      className: 'end-total-cell row-totals',
      textContent: @textContent()
    })

  #
  # TODO: simplify these tests
  #
  cellsInUse: ()->
    @scoringCells.filter (sc)->
      !sc.unused

  endIsScored: ()->
    scoredCells = @scoringCells.filter( (sc)->
      sc.scoreValue?
    )
    scoredCells.length == @cellsInUse().length

  #
  # End Total will be blank unless entire end is scored
  #
  textContent: ()->
    return '' unless @endIsScored()
    @totalScore().toString() # 0 does not render in HTML

  #
  # TODO: may not be best place for this...?
  #
  totalGolds: ()->
    self = @
    @scoringCells.reduce( (accum, sc)->
      accum + if sc.score() is self.options.config.goldScore then 1 else 0
    , 0)

  totalScore: () ->
    @scoringCells.reduce((accum, sc)->
      accum + sc.score()
    , 0)
