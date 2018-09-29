class XCard.EndTotalCell extends XCard.BasicCell

  constructor: (@options = {}) ->
    unless @options.config?
      throw "EndTotalCell requires DistanceConfig"
      
    @scoringCells = @options.scoringCells ? []

    super({
      className: 'end-total-cell',
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
    @scoringCells.reduce( (accum, sc)->
      accum + if sc.isGold then 1 else 0e0
    , 0)

  totalScore: () ->
    @scoringCells.reduce((accum, sc)->
      accum + sc.score()
    , 0)
