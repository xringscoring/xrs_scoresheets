class XCard.ScoreCell extends XCard.BasicCell

  constructor: (scoreOptions = {})->
    @options = Object.assign({
      enabled: true
    }, scoreOptions)
    super()

  className: ()->
    "#{XCard.config.classPrefix}-score-cell"
