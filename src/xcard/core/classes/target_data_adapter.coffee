class XCard.TargetDataAdapter

  # For Standard XRS round definition
  constructor: (@targetRoundDefinition, @bowType = 'recurve') ->
    unless @targetRoundDefinition?
      throw 'Target Round definition is required'

    @parseRoundDefinition()

  parseRoundDefinition: () ->
    @distances = []
    for d, i in @targetRoundDefinition.distances
      @distances.push( @distanceDefinition(d, i) )

  distanceDefinition: (distanceDef, index) ->
    shotsPerEnd: @toNumber(distanceDef['shots_per_end'] ? @targetRoundDefinition['default_shots_per_end']),
    title: @title(distanceDef['range']),
    totalShots: @toNumber(distanceDef['total_shots']),
    withHits: true,
    withGolds: true,
    goldScore: @toNumber(@targetRoundDefinition['scoring_scheme'][0]),
    withX: @withX(),
    recurveMatch: @isRecurveMatchRound(),
    compoundMatch: @isCompoundMatchRound(),
    withTotalHeaders: index is 0

  isCompoundMatchRound: () ->
    return false unless @bowType is 'compound'
    @isMatchRound()

  isRecurveMatchRound: () ->
    return false if @bowType is 'compound'
    @isMatchRound()

  isMatchRound: ()->
    @targetRoundDefinition['short_name'].match(/match/)

  rangeUnit: () ->
    if @targetRoundDefinition['round_type'] is 'metric' then 'm' else 'yd'

  title: (distance) ->
    "#{distance}#{@rangeUnit()}"

  toNumber: (v) ->
    parseInt(v, 10)

  withX: () ->
    @targetRoundDefinition['environment'] is 'outdoor' and @targetRoundDefinition['has_x']
