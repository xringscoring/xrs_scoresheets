class XCard.ScoreCell extends XCard.BasicCell

  #
  # scoreData = {
  #  score: 1,
  #  isX: false,
  #  isGold: false,
  #  text: null
  # }
  #

  #
  # If @unused the cell is 'striped out'
  #
  constructor: (@scoreData = {}, @unused = false)->
    super()
    @scoreValue = if @scoreData.score? then parseInt(@scoreData.score, 10) else null
    @text = @scoreData.text ? ''

    @setAttributes({
      className: @getClasses(),
      textContent: @getTextContent()
      data: {
        score: @scoreValue
      }
    })

  getClasses: () ->
    classes = [ 'score-cell' ]
    classes.push( 'unused' ) if @unused
    classes.join(' ')

  getTextContent: ()->
    if !@scoreValue?
      return "" # non-breaking space

    if @scoreValue == 0
      return 'm'

    return if @text? then @text else @scoreValue

  score: ()->
    @scoreValue ? 0
