class XCard.TargetDataAdapter

  # For Standard XRS round definition
  constructor: (@targetRoundDefinition, @bowType = 'recurve') ->
    unless @targetRoundDefinition?
      throw 'Target Round definition is required'

    @parseRoundDefinition()
    @ensureLeftPadding()

  ensureLeftPadding: () ->
    for distanceDef, i in @distances
      @distances[i]['leftPaddingCellCount'] = (@maxShotsPerEnd - distanceDef['shotsPerEnd']) * 2

  parseRoundDefinition: () ->
    @distances = []
    @maxShotsPerEnd = 0
    for d, i in @targetRoundDefinition.distances
      distanceDef = @distanceDefinition(d, i)
      @distances.push distanceDef
      @maxShotsPerEnd = if distanceDef['shotsPerEnd'] > @maxShotsPerEnd then distanceDef['shotsPerEnd'] else @maxShotsPerEnd

  distanceDefinition: (distanceDef, index) ->
    distanceIndex: index,
    shotsPerEnd: @toNumber(distanceDef['shots_per_end'] ? @targetRoundDefinition['default_shots_per_end']),
    title: @title(distanceDef['range'], index),
    totalShots: @toNumber(distanceDef['total_shots']),
    withHits: true,
    withGolds: true,
    goldScore: @toNumber(@targetRoundDefinition['scoring_scheme'][0]),
    goldsDescriptor: @goldsDescriptor(),
    withX: @withX(),
    recurveMatch: @isRecurveMatchRound(),
    compoundMatch: @isCompoundMatchRound(),
    withTotalHeaders: @withTotalHeaders(index)

  goldsDescriptor: ()->
    if @targetRoundDefinition['short_name'].match(/worcester|nfaa_300/i) then 'w' else 'g'

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

  title: (distance, distanceIndex) ->
    if @isMatchRound() and (distanceIndex > 0)
      return "Tie-break"

    "#{distance}#{@rangeUnit()}"

  toNumber: (v) ->
    parseInt(v, 10)

  withTotalHeaders: (index)->
    true

  withX: () ->
    @targetRoundDefinition['environment'] is 'outdoor' and @targetRoundDefinition['has_x']
