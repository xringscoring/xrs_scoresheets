class XCard.EndTotalCell extends XCard.BasicCell

  constructor: (@options = {}) ->
    unless @options.config?
      throw "EndTotalCell requires DistanceConfig"

    @totalScore = @options.totalScore ? 0
    @scoringCells = @options.scoringCells ? []

    super({
      className: 'end-total-cell row-totals',
      textContent: @textContent()
    })

  textContent: ()->
    return '' unless @options.hasAtLeastOneScore
    @totalScore.toString() # 0 does not render in HTML
