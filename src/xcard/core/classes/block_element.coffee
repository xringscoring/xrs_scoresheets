class XCard.BlockElement

  constructor: (options = {})->
    @options = Object.assign({
      config: null,
      totals: null
    }, options)

    unless @options.config?
      throw "BlockElement requires DistanceConfig"

    @config = @options.config

    @handlePadding()

  handlePadding: ()->
    @paddingCells = []
    if @config.leftPaddingCellCount isnt 0
      for pCount in [1..@config.leftPaddingCellCount]
        @paddingCells.push( new XCard.BasicCell({className: 'padding-cell'}))

    
